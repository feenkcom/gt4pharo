Class {
	#name : #GtIndex,
	#superclass : #Object,
	#instVars : [
		'active'
	],
	#category : #'GToolkit-Pharo-Index'
}

{ #category : #private }
GtIndex >> asyncOrderedSearchForWords: aString in: prefixTree [
	"Order the results by 1) names that begin with aString, 2) names that have aString in them,
	3) names that have the words from aString in order and begins with the first word in aString,
	4) names that have the words from aString in order, and 5) names that have all the words from
	aString in any order. The stream returned may (and likely will) contain duplicates."

	| matchStream substringMatchStream wordsInOrderStream startingSubstringMatchStream startingWordsInOrderStream |
	matchStream := (self asyncSearchForWords: aString in: prefixTree) cached.
	substringMatchStream := (matchStream asyncSimilarCopy
			select: [ :each | self does: each includeString: aString ]) cached.
	startingSubstringMatchStream := substringMatchStream asyncSimilarCopy
			select: [ :each | self does: each beginWithWord: aString ].
	wordsInOrderStream := (matchStream asyncSimilarCopy
			select: [ :each | self does: each includeWordsInOrder: aString ]) cached.
	startingWordsInOrderStream := wordsInOrderStream asyncSimilarCopy
			select: [ :each | self does: each beginWithWord: aString ].
	^ (((startingSubstringMatchStream merge: substringMatchStream)
		merge: startingWordsInOrderStream) merge: wordsInOrderStream)
		merge: matchStream
]

{ #category : #private }
GtIndex >> asyncSearchForSubstringWords: aString in: prefixTree [
	"aString isn't a word, so look for other words in aString that are followed by the rest of aString"

	^ ((aString size - 1 to: 1 by: -1) asAsyncStream
		collect: [ :i | 
			(prefixTree nodeFor: (aString copyFrom: 1 to: i))
				ifNil: [ #() asAsyncStream ]
				ifNotNil: [ :node | 
					node namesCollection asArray asAsyncStream
						select: [ :each | self does: each includeString: aString ] ] ])
		flatten withoutDuplicates
]

{ #category : #private }
GtIndex >> asyncSearchForWords: aString in: prefixTree [
	| words longest |
	words := self searchWordsFrom: aString.
	longest := words isEmpty ifTrue: [ '' ] ifFalse: [ words first ].
	(words size = 1 and: [ (prefixTree first: 1 startingWith: longest) isEmpty ])
		ifTrue: [ ^ self asyncSearchForSubstringWords: longest in: prefixTree ].
	^ ((prefixTree asyncStreamStartingWith: longest)
		collect: [ :each | 
			(prefixTree nodeFor: each)
				ifNil: [ #() asAsyncStream ]
				ifNotNil: [ :node | 
					node namesCollection asArray asAsyncStream
						select: [ :selector | words size <= 1 or: [ self does: selector matchWords: words ] ] ] ])
		flatten withoutDuplicates
			useContentComparison
]

{ #category : #private }
GtIndex >> basicSubscribe [
	self subclassResponsibility
]

{ #category : #private }
GtIndex >> basicUnsubscribe [
	self subclassResponsibility
]

{ #category : #initialization }
GtIndex >> computeIndex [
	self subclassResponsibility
]

{ #category : #testing }
GtIndex >> does: aSymbol beginWithWord: aString [
	| string |
	string := aSymbol asString asLowercase.
	self
		wordsIn: aString
		do: [ :each | ^ string beginsWith: each asLowercase ]
		minSize: 1
		includeSubStrings: false.
	^ false
]

{ #category : #testing }
GtIndex >> does: aSymbol includeString: aString [
	^ aSymbol includesSubstring: aString caseSensitive: false
]

{ #category : #testing }
GtIndex >> does: aSymbol includeWordsInOrder: wordString [
	| string index |
	string := aSymbol asString asLowercase.
	index := 1.
	self
		wordsIn: wordString
		do: [ :each | 
			index := string indexOfSubCollection: each asLowercase startingAt: index.
			index > 0 ifTrue: [ index := index + each size ] ifFalse: [ ^ false ] ]
		minSize: 1
		includeSubStrings: false.
	^ true
]

{ #category : #testing }
GtIndex >> does: selector matchWords: words [
	^ (self intervalsIn: selector matchingWords: words) notEmpty
]

{ #category : #initialization }
GtIndex >> initialize [
	super initialize.
	active := false
]

{ #category : #initialization }
GtIndex >> initializeCache [
	self unsubscribeFromModel.
	self computeIndex.
	self subscribeToModel
]

{ #category : #accessing }
GtIndex >> intervalsIn: selector matching: wordString [
	| words |
	words := self searchWordsFrom: wordString.
	^ self intervalsIn: selector matchingWords: words
]

{ #category : #private }
GtIndex >> intervalsIn: selector matchingWords: words [
	| selectorWords intervals |
	intervals := OrderedCollection new: words size.
	selectorWords := OrderedCollection new.
	self
		wordsIn: selector
		do: [ :each :index | 
			selectorWords
				add: {index.
						each asLowercase} ]
		minSize: 1
		includeSubStrings: true.
	selectorWords
		sort: [ :a :b | a last size > b last size or: [ a last = b last and: [ a first < b first ] ] ].
	words
		do: [ :each | 
			| item |
			item := selectorWords
					detect: [ :sel | sel last beginsWith: each ]
					ifNone: [ ^ #() ].
			intervals add: (item first to: item first + each size - 1).
			selectorWords remove: item ].
	^ intervals
]

{ #category : #testing }
GtIndex >> isActive [
	^ active
]

{ #category : #accessing }
GtIndex >> map: aSelector toKeywords: anArray [
	| selector otherKeywords index map |
	map := OrderedCollection new: anArray size.
	selector := aSelector asSymbol.
	index := 0.
	otherKeywords := selector keywords.
	anArray
		do: [ :kw | 
			kw last = $:
				ifTrue: [ index := otherKeywords indexOf: kw startingAt: index + 1 ]
				ifFalse: [ | myWords |
					myWords := self wordsIn: kw.
					index := (index + 1 to: otherKeywords size)
							detect: [ :i | 
								| otherWords currentIndex |
								otherWords := self wordsIn: (otherKeywords at: i).
								currentIndex := 0.
								myWords
									allSatisfy: [ :e | 
										currentIndex := (currentIndex + 1 to: otherWords size)
												detect: [ :j | (otherWords at: j) beginsWith: e ]
												ifNone: [ 0 ].
										currentIndex > 0 ] ]
							ifNone: [ 0 ] ].
			index > 0 ifFalse: [ ^ nil ].
			map add: index ].
	^ map
]

{ #category : #accessing }
GtIndex >> searchWordsFrom: aString [
	| words |
	words := OrderedCollection new.
	self
		wordsIn: aString
		do: [ :each | words add: each asLowercase ]
		minSize: 1
		includeSubStrings: false.
	^ words sort: [ :a :b | a size > b size ]
]

{ #category : #private }
GtIndex >> subscribeToModel [
	self basicSubscribe.
	active := true
]

{ #category : #private }
GtIndex >> unsubscribeFromModel [
	self basicUnsubscribe.
	active := false
]

{ #category : #private }
GtIndex >> wordsIn: kw [
	| myWords |
	myWords := OrderedCollection new.
	self
		wordsIn: kw
		do: [ :each | myWords add: each asLowercase ]
		minSize: 1
		includeSubStrings: false.
	^ myWords
]

{ #category : #private }
GtIndex >> wordsIn: aSymbol do: aBlock [
	self
		wordsIn: aSymbol
		do: aBlock
		minSize: 1
		includeSubStrings: true
]

{ #category : #private }
GtIndex >> wordsIn: aSymbol do: aBlock minSize: anInteger includeSubStrings: aBoolean [
	| start end char size firstIsDigit |
	size := aSymbol size.
	start := 1.
	[ start <= size ]
		whileTrue: [ [ start <= size
				and: [ ((char := aSymbol at: start) isLetter or: [ char isDigit ]) not ] ]
				whileTrue: [ start := start + 1 ].
			start > size ifTrue: [ ^ self ].
			end := start + 1.
			char isUppercase
				ifTrue: [ [ end <= size and: [ (aSymbol at: end) isUppercase ] ]
						whileTrue: [ end := end + 1 ] ].
			firstIsDigit := char isDigit.
			[ end <= size
				and: [ char := aSymbol at: end.
					firstIsDigit ifTrue: [ char isDigit ] ifFalse: [ char isLowercase ] ] ]
				whileTrue: [ end := end + 1 ].
			end := end - 1.
			[ end - start + 1 >= anInteger ]
				whileTrue: [ aBlock cull: (aSymbol copyFrom: start to: end) cull: start.
					(aBoolean and: [ (aSymbol at: end) isUppercase not ])
						ifTrue: [ start := start + 1.
							(start < size and: [ (aSymbol at: start) isUppercase ])
								ifFalse: [ start := end + 1 ] ]
						ifFalse: [ start := end + 1 ] ].
			start := end + 1 ]
]
