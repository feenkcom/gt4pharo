Class {
	#name : #GtSearchInstanceSlotReferenceFilter,
	#superclass : #GtSearchMethodsInClassFilter,
	#instVars : [
		'variableName',
		'includeReaders',
		'includeWriters'
	],
	#category : #'GToolkit-Pharo-SearchFilters-Filters'
}

{ #category : #'instance creation' }
GtSearchInstanceSlotReferenceFilter class >> forClass: aClass andVariable: aString [
	^ self new
		forClass: aClass andVariable: aString;
		yourself
]

{ #category : #'instance creation' }
GtSearchInstanceSlotReferenceFilter class >> forClassAndHierarchy: aClass andVariable: aString [
	^ self new
		forClass: aClass andVariable: aString;
		includeSubclasses: true;
		includeSuperclass: true;
		yourself
]

{ #category : #'instance creation' }
GtSearchInstanceSlotReferenceFilter class >> forClassAndSubclasses: aClass andVariable: aString [
	^ self new
		forClass: aClass andVariable: aString;
		includeSubclasses: true;
		yourself
]

{ #category : #comparing }
GtSearchInstanceSlotReferenceFilter >> = anObject [
	^ super = anObject 
		and: [ self variableName = anObject variableName
		and: [ self includeReaders = anObject includeReaders
		and: [ self includeWriters = anObject includeWriters ] ] ]
]

{ #category : #accessing }
GtSearchInstanceSlotReferenceFilter >> filterValueString [
	^ self variableName
]

{ #category : #'initialize-release' }
GtSearchInstanceSlotReferenceFilter >> forClass: aClass andVariable: aString [
	self forClass: aClass.
	variableName := aString
]

{ #category : #printing }
GtSearchInstanceSlotReferenceFilter >> gtDisplayOn: stream [
	stream
		print: filterClass;
		nextPut: $.;
		nextPutAll: variableName asString;
		nextPutAll: ' instanceSlotReferences'
]

{ #category : #accessing }
GtSearchInstanceSlotReferenceFilter >> gtMessagesSentToSlotFor: aView [
	<gtView>
	| selectorStream |
	selectorStream := (self asAsyncStream
			collect: [ :each | 
				| messages |
				messages := OrderedCollection new.
				each ast
					nodesDo: [ :node | 
						(node isMessage
							and: [ node receiver isVariable and: [ node receiver name = variableName ] ])
							ifTrue: [ messages add: node selector ] ].
				messages asAsyncStream ]) flatten withoutDuplicates cached.
	^ aView list
		title: 'Messages';
		priority: 30;
		items: [ selectorStream asyncSimilarCopy ];
		send: [ :each | 
			| pattern |
			pattern := each numArgs = 0
					ifTrue: [ ' ' , each ]
					ifFalse: [ String
							streamContents: [ :stream | 
								each keywords
									keysAndValuesDo: [ :i :kw | 
										stream space
											nextPutAll: kw;
											nextPutAll: ' `@a';
											print: i ] ] ].
			self & (variableName , pattern) gtASTMatches ]
]

{ #category : #accessing }
GtSearchInstanceSlotReferenceFilter >> gtReadersFor: aView [
	<gtView>
	^ aView forward
		title: 'Readers';
		priority: 11;
		object: [ self copy
				includeReaders: true;
				includeWriters: false;
				yourself ];
		view: #gtItemsFor:
]

{ #category : #accessing }
GtSearchInstanceSlotReferenceFilter >> gtWritersFor: aView [
	<gtView>
	^ aView forward
		title: 'Writers';
		priority: 12;
		object: [ self copy
				includeReaders: false;
				includeWriters: true;
				yourself ];
		view: #gtItemsFor:
]

{ #category : #comparing }
GtSearchInstanceSlotReferenceFilter >> hash [
	^ ((super hash 
		bitXor: self variableName hash)
		bitXor: self includeReaders hash)
		bitXor: self includeWriters hash
]

{ #category : #accessing }
GtSearchInstanceSlotReferenceFilter >> includeReaders [
	^ includeReaders
]

{ #category : #accessing }
GtSearchInstanceSlotReferenceFilter >> includeReaders: aBoolean [
	includeReaders := aBoolean
]

{ #category : #accessing }
GtSearchInstanceSlotReferenceFilter >> includeWriters [
	^ includeWriters
]

{ #category : #accessing }
GtSearchInstanceSlotReferenceFilter >> includeWriters: aBoolean [
	includeWriters := aBoolean
]

{ #category : #testing }
GtSearchInstanceSlotReferenceFilter >> includesMethod: aCompiledMethod [
	| index |
	variableName ifEmpty: [ ^ true ].
	(super includesMethod: aCompiledMethod) ifFalse: [ ^ false ].
	index := filterClass instVarIndexFor: variableName ifAbsent: [ ^ false ].
	^ (includeReaders and: [ aCompiledMethod readsField: index ])
		or: [ includeWriters and: [ aCompiledMethod writesField: index ] ]
]

{ #category : #'initialize-release' }
GtSearchInstanceSlotReferenceFilter >> initialize [
	super initialize.
	variableName := '' asSymbol.
	includeSubclasses := true.
	includeReaders := true.
	includeWriters := true
]

{ #category : #accessing }
GtSearchInstanceSlotReferenceFilter >> variableName [
	^ variableName
]

{ #category : #accessing }
GtSearchInstanceSlotReferenceFilter >> variableName: aSymbol [
	<gtPharoPatch: #StrictComparison>

	variableName := aSymbol asSymbol
]
