Class {
	#name : #GtPharoNoIndex,
	#superclass : #GtIndex,
	#category : #'GToolkit-Pharo-Index'
}

{ #category : #'accessing - implementers' }
GtPharoNoIndex >> allImplementersOf: aSymbol [
	^ self implementersOf: aSymbol
]

{ #category : #'message sends' }
GtPharoNoIndex >> allSendersOf: aSymbol [
	^ self sendersOf: aSymbol
]

{ #category : #accessing }
GtPharoNoIndex >> asyncClassNamesForWord: aString [
	| words |
	words := self searchWordsFrom: aString.
	^ (self class environment allBehaviors asAsyncStream
		select: [ :each | each isClassSide not and: [ self does: each name matchWords: words ] ])
		collect: [ :each | each name ]
]

{ #category : #'accessing - implementers' }
GtPharoNoIndex >> asyncImplementersForWord: aString [
	| words |
	words := self searchWordsFrom: aString.
	^ (self class environment allBehaviors asAsyncStream
		collect: [ :each | 
			((each methods
				select: [ :method | 
					(self isIgnoredMethod: method) not
						and: [ self does: method selector matchWords: words ] ])
				collect: [ :method | method gtIndexMethod ]) asOrderedCollection
				asAsyncStream ]) flatten
]

{ #category : #'accessing - implementers' }
GtPharoNoIndex >> asyncImplementersForWord: aString convertUsing: aWordToCompiledMethodBlock [
	^ (((self asyncImplementersForWord: aString) collect: [ :each | each selector ])
		withoutDuplicates collect: aWordToCompiledMethodBlock)
		select: [ :each | each notNil ]
]

{ #category : #accessing }
GtPharoNoIndex >> asyncKeywordImplementorsFor: anArray [
	^ ((self asyncImplementersForWord: (' ' join: anArray))
		collect: [ :each | each selector ]) withoutDuplicates
		select: [ :each | (self map: each toKeywords: anArray) notNil ]
]

{ #category : #accessing }
GtPharoNoIndex >> asyncSelectorsForWord: aString [
	| words seen |
	seen := IdentitySet new.
	words := self searchWordsFrom: aString.
	^ (self class environment allBehaviors asAsyncStream
		collect: [ :each | 
			| selectors |
			selectors := OrderedCollection new.
			each
				methodsDo: [ :installedMethod | 
					(self isIgnoredMethod: installedMethod)
						ifFalse: [ | method literalBlock |
							method := installedMethod gtOriginalMethod.
							(self does: method selector matchWords: words)
								ifTrue: [ selectors add: method selector ].
							literalBlock := [ :literal | 
								literal isArray
									ifTrue: [ literal do: literalBlock ]
									ifFalse: [ (literal isSymbol and: [ (seen includes: literal) not ])
											ifTrue: [ seen add: literal.
												(self does: literal matchWords: words)
													ifTrue: [ selectors add: literal ] ] ] ].
							method allLiterals do: literalBlock ] ].
			selectors asAsyncStream ]) flatten withoutDuplicates
]

{ #category : #private }
GtPharoNoIndex >> basicSubscribe [
]

{ #category : #private }
GtPharoNoIndex >> basicUnsubscribe [
]

{ #category : #accessing }
GtPharoNoIndex >> cacheSizeInMemory [
	^ 0
]

{ #category : #examples }
GtPharoNoIndex >> classNameTree [
	| tree |
	tree := GtPrefixTree new.
	Smalltalk globals
		keysAndValuesDo: [ :key :value | (value isBehavior and: [ value isClassSide not ]) ifTrue: [ tree add: key ] ].
	^ tree
]

{ #category : #accessing }
GtPharoNoIndex >> classWordCacheSpecificSize [
	^ 0
]

{ #category : #initialization }
GtPharoNoIndex >> computeIndex [
]

{ #category : #examples }
GtPharoNoIndex >> globalCache [
	| tree |
	tree := GtPrefixTree new.
	Smalltalk globals
		keysAndValuesDo: [ :key :value | (value isBehavior and: [ value isClassSide ]) ifFalse: [ tree add: key ] ].
	^ tree
]

{ #category : #accessing }
GtPharoNoIndex >> globalCacheSpecificSize [
	^ 0
]

{ #category : #accessing }
GtPharoNoIndex >> globalVariableReferencesTo: aVariable [
	| references special |
	references := OrderedCollection new.
	special := Smalltalk specialSelectorIndexOrNil: aVariable name.
	self class environment allBehaviors
		do: [ :class | 
			class
				methodsDo: [ :each | 
					((self isIgnoredMethod: each) not
						and: [ (each refersToLiteral: aVariable)
								or: [ each hasSelector: aVariable name specialSelectorIndex: special ] ])
						ifTrue: [ references add: each ] ] ].
	^ references
]

{ #category : #testing }
GtPharoNoIndex >> hasImplementersOf: aSymbol [
	^ (self implementersOf: aSymbol) notEmpty
]

{ #category : #enumerating }
GtPharoNoIndex >> implementersDo: aBlock [
	| implementers |
	implementers := IdentitySet new.
	self class environment allBehaviors
		do: [ :class | 
			class
				methodsDo: [ :method | 
					(self isIgnoredMethod: method)
						ifFalse: [ | selector |
							selector := method selector.
							(implementers includes: selector)
								ifFalse: [ implementers add: selector.
									aBlock value: selector ] ] ] ]
]

{ #category : #'accessing - implementers' }
GtPharoNoIndex >> implementersOf: aSymbol [
	| implementers |
	implementers := OrderedCollection new.
	self class environment allBehaviors
		do: [ :class | 
			(class includesSelector: aSymbol)
				ifTrue: [ | method |
					method := class >> aSymbol.
					(self isIgnoredMethod: method) ifFalse: [ implementers add: method ] ] ].
	^ implementers
]

{ #category : #testing }
GtPharoNoIndex >> isActive [
	^ true
]

{ #category : #private }
GtPharoNoIndex >> isIgnoredMethod: aMethod [
	^ aMethod isFromTrait or: [ aMethod methodClass isAnonymous ]
]

{ #category : #accessing }
GtPharoNoIndex >> prefixStringsSizeInMemory [
	^ 0
]

{ #category : #accessing }
GtPharoNoIndex >> selectorCache [
	^ GtPharoNoCacheSelectorCache new
]

{ #category : #accessing }
GtPharoNoIndex >> selectorCacheSpecificSize [
	^ 0
]

{ #category : #accessing }
GtPharoNoIndex >> selectorWordCacheSpecificSize [
	^ 0
]

{ #category : #preconditions }
GtPharoNoIndex >> sendersOf: aSymbol [
	| senders special |
	senders := OrderedCollection new.
	special := Smalltalk specialSelectorIndexOrNil: aSymbol.
	self class environment allBehaviors
		do: [ :class | 
			class
				methodsDo: [ :each | 
					((self isIgnoredMethod: each) not
						and: [ each hasSelector: aSymbol specialSelectorIndex: special ])
						ifTrue: [ senders add: each ] ] ].
	^ senders
]

{ #category : #'private - subscriptions' }
GtPharoNoIndex >> subscribeToSystem [
]

{ #category : #'private - subscriptions' }
GtPharoNoIndex >> unsubscribeFromSystem [
]
