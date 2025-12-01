Class {
	#name : #GtReferencesPrefixTree,
	#superclass : #GtPrefixTree,
	#instVars : [
		'references'
	],
	#classVars : [
		'DebugMode',
		'MaxOCSize'
	],
	#category : #'GToolkit-Pharo-Index'
}

{ #category : #debugging }
GtReferencesPrefixTree class >> disableDebugMode [
	DebugMode := false
]

{ #category : #debugging }
GtReferencesPrefixTree class >> enableDebugMode [
	DebugMode := true
]

{ #category : #'class initialization' }
GtReferencesPrefixTree class >> initialize [
	MaxOCSize := 1000
]

{ #category : #debugging }
GtReferencesPrefixTree class >> isDebuggingEnabled [
	^ DebugMode = true
]

{ #category : #adding }
GtReferencesPrefixTree >> addReference: aMethod [
	references
		ifNil: [ references := aMethod ]
		ifNotNil: [ references isDictionary
				ifTrue: [ | className |
					className := aMethod methodClass instanceSide name.
					^ references
						at: className
						ifPresent: [ :refs | 
							refs gtIsIndexMethod
								ifTrue: [ references at: className put: (OrderedCollection with: refs with: aMethod) ]
								ifFalse: [ refs isArray
										ifTrue: [ references
												at: className
												put: (refs asOrderedCollection
														add: aMethod;
														yourself) ]
										ifFalse: [ refs add: aMethod ] ] ]
						ifAbsentPut: [ aMethod ] ].
			references class == OrderedCollection
				ifFalse: [ references := references isArray
							ifTrue: [ references := references asOrderedCollection ]
							ifFalse: [ OrderedCollection with: references ] ].
			references add: aMethod.
			references size > MaxOCSize
				ifTrue: [ | refs |
					refs := references.
					references := IdentityDictionary new.
					refs do: [ :each | self addReference: each ] ] ]
]

{ #category : #accessing }
GtReferencesPrefixTree >> classRenamedFrom: oldName to: newName [
	self childrenDo: [ :each | each classRenamedFrom: oldName to: newName ].
	references isDictionary ifFalse: [ ^ self ].
	references
		at: oldName
		ifPresent: [ :value | 
			references at: newName put: value.
			references removeKey: oldName ifAbsent: [  ] ]
]

{ #category : #private }
GtReferencesPrefixTree >> compressData [
	super compressData.
	references isDictionary
		ifTrue: [ references := references
					collect: [ :each | each isCollection ifTrue: [ each asArray ] ifFalse: [ each ] ].
			^ self ].
	references isCollection ifTrue: [ references := references asArray ]
]

{ #category : #accessing }
GtReferencesPrefixTree >> gtLocalSizeInMemory [
	^ super gtLocalSizeInMemory
		+ (references isDictionary
				ifTrue: [ references gtSpecificSizeInMemory
						+ (references
								inject: 0
								into: [ :sum :each | 
									sum
										+ ((each isArray or: [ each class == OrderedCollection ])
												ifTrue: [ each gtSpecificSizeInMemory ]
												ifFalse: [ 0 ]) ]) ]
				ifFalse: [ (references isArray or: [ references class == OrderedCollection ])
						ifTrue: [ references gtSpecificSizeInMemory ]
						ifFalse: [ 0 ] ])
]

{ #category : #'gt - extensions' }
GtReferencesPrefixTree >> gtNoDuplicateReferences: aGtAdvice [
	<gtAdvice>
	^ aGtAdvice asyncStream
		description: [ :each | (each , ' has duplicate reference methods') asRopedText ];
		compute: [ (self asyncStreamStartingWith: '')
				select: [ :each | 
					(self nodeFor: each) referencesCollection
						ifEmpty: [ false ]
						ifNotEmpty: [ :col | col size ~= col asIdentitySet size ] ] ];
		action: [ :each | self gtPhlowInspectNodeAction: each ]
]

{ #category : #'gt - extensions' }
GtReferencesPrefixTree >> gtNotInstalledReferencesBySelector [ 
	| notInstalledMethodsBySelector |
	notInstalledMethodsBySelector 	:= OrderedDictionary new.
	((self asyncStreamStartingWith: '')	do: [ :each | 
		| notInstalledReferences |
		notInstalledReferences := ((self nodeFor: each) referencesCollection
				select: [ :method | method gtIsActive not ]).
		notInstalledReferences ifNotEmpty: [
			notInstalledMethodsBySelector 
				at: each 
				put: notInstalledReferences] ]) wait.
	^ notInstalledMethodsBySelector
]

{ #category : #'gt - extensions' }
GtReferencesPrefixTree >> gtPhlowInspectNodeAction: aString [
	^ (GtPhlowObjectAdviceAction object: (self nodeFor: aString))
		title: aString asRopedText;
		yourself
]

{ #category : #'gt - extensions' }
GtReferencesPrefixTree >> gtReferencesAreInstalled: aGtAdvice [
	<gtAdvice>
	^ aGtAdvice asyncStream
		priority: 10;
		description: [ :each | (each , ' has a reference method that is not installed') asRopedText ];
		compute: [ (self asyncStreamStartingWith: '')
				select: [ :each | 
					(self nodeFor: each) referencesCollection
						anySatisfy: [ :method | method gtIsActive not ] ] ];
		action: [ :each | self gtPhlowInspectNodeAction: each ]
]

{ #category : #'gt - extensions' }
GtReferencesPrefixTree >> gtReferencesFor: aView [
	<gtView>
	^ aView list
		title: 'References';
		items: [ self referencesCollection ]
]

{ #category : #private }
GtReferencesPrefixTree >> moveDataTo: newChild [
	super moveDataTo: newChild.
	newChild references: references.
	references := nil
]

{ #category : #accessing }
GtReferencesPrefixTree >> notInstalledMethods [
	^ (self gtReferencesAreInstalled: GtNoAdvice new) result toArray wait
]

{ #category : #private }
GtReferencesPrefixTree >> references [
	^ references
]

{ #category : #private }
GtReferencesPrefixTree >> references: aCollection [
	references := aCollection
]

{ #category : #accessing }
GtReferencesPrefixTree >> referencesCollection [
	^ references
		ifNil: [ #() ]
		ifNotNil: [ references isDictionary
				ifTrue: [ references
						inject: OrderedCollection new
						into: [ :sum :each | 
							each gtIsIndexMethod ifTrue: [ sum add: each ] ifFalse: [ sum addAll: each ].
							sum ] ]
				ifFalse: [ references asOrderedCollection ] ]
]

{ #category : #accessing }
GtReferencesPrefixTree >> referencesTo: aString [
	^ ((self nodeFor: aString) ifNotNil: [ :node | node referencesCollection ])
		ifNil: [ #() ]
]

{ #category : #removing }
GtReferencesPrefixTree >> removeReference: aMethod [
	| index refs isDictionary className class |
	references ifNil: [ ^ self ].
	references == aMethod ifTrue: [ ^ references := nil ].
	isDictionary := references isDictionary.
	isDictionary
		ifTrue: [ class := aMethod methodClass instanceSide.
			className := class isObsolete
					ifTrue: [ (class name removePrefix: 'AnObsolete') asSymbol ]
					ifFalse: [ class name ].
			refs := references at: className ifAbsent: [  ].
			refs == aMethod ifTrue: [ ^ references removeKey: className ifAbsent: [  ] ] ]
		ifFalse: [ refs := references ].
	refs isArray
		ifTrue: [ refs := refs asOrderedCollection.
			isDictionary
				ifTrue: [ references at: className put: refs ]
				ifFalse: [ references := refs ] ].
	refs class == OrderedCollection ifFalse: [ ^ self ].
	index := refs identityIndexOf: aMethod.
	index > 0
		ifTrue: [ refs removeAt: index.
			(isDictionary and: [ refs isEmpty ])
				ifTrue: [ references removeKey: className ifAbsent: [  ] ] ]
]

{ #category : #accessing }
GtReferencesPrefixTree >> removeUninstalledReferences [
	| refs |
	refs := self referencesCollection.
	refs size
		to: 1
		by: -1
		do: [ :i | 
			| method |
			method := refs at: i.
			method gtIsActive ifFalse: [ self removeReference: method ] ]
]

{ #category : #private }
GtReferencesPrefixTree >> updateReference: aMethod [
	| refs isDictionary className |
	references
		ifNil: [ self addReference: aMethod.
			^ false ].
	isDictionary := references isDictionary.
	refs := isDictionary
			ifTrue: [ className := aMethod methodClass instanceSide name.
				references at: className ifAbsent: [ #() ] ]
			ifFalse: [ references ].
	refs gtIsIndexMethod
		ifTrue: [ ^ (refs methodClass = aMethod methodClass
				and: [ refs selector = aMethod selector ])
				ifTrue: [ isDictionary
						ifTrue: [ references at: className put: aMethod ]
						ifFalse: [ references := aMethod ].
					true ]
				ifFalse: [ self addReference: aMethod.
					false ] ].
	1
		to: refs size
		do: [ :i | 
			| each |
			each := refs at: i.
			(each methodClass = aMethod methodClass
				and: [ each selector = aMethod selector ])
				ifTrue: [ refs at: i put: aMethod.
					^ true ] ].
	self addReference: aMethod.
	^ false
]
