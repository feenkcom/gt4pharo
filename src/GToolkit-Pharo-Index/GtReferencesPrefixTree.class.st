Class {
	#name : #GtReferencesPrefixTree,
	#superclass : #GtPrefixTree,
	#instVars : [
		'references'
	],
	#category : #'GToolkit-Pharo-Index'
}

{ #category : #adding }
GtReferencesPrefixTree >> addReference: aMethod [
	references
		ifNil: [ references := aMethod ]
		ifNotNil: [ references class == OrderedCollection
				ifFalse: [ references := references isArray
							ifTrue: [ references := references asOrderedCollection ]
							ifFalse: [ OrderedCollection with: references ] ].
			references add: aMethod ]
]

{ #category : #private }
GtReferencesPrefixTree >> compressData [
	super compressData.
	references isCollection ifTrue: [ references := references asArray ]
]

{ #category : #inspector }
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

{ #category : #inspector }
GtReferencesPrefixTree >> gtPhlowInspectNodeAction: aString [
	^ (GtPhlowObjectAdviceAction object: (self nodeFor: aString))
		title: aString asRopedText;
		yourself
]

{ #category : #inspector }
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

{ #category : #inspector }
GtReferencesPrefixTree >> gtReferencesFor: aView [
	<gtView>
	^ aView list
		title: 'References';
		items: [ references
				ifNil: [ {} ]
				ifNotNil: [ references isCollection
						ifTrue: [ references ]
						ifFalse: [ Array with: references ] ] ]
]

{ #category : #accessing }
GtReferencesPrefixTree >> gtSpecificSizeInMemory [
	^ super gtSpecificSizeInMemory
		+ ((references isArray or: [ references class == OrderedCollection ])
				ifTrue: [ references gtSpecificSizeInMemory ]
				ifFalse: [ 0 ])
]

{ #category : #private }
GtReferencesPrefixTree >> moveDataTo: newChild [
	super moveDataTo: newChild.
	newChild references: references.
	references := nil
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
	^ references ifNil: [ #() ] ifNotNil: [ references asOrderedCollection ]
]

{ #category : #accessing }
GtReferencesPrefixTree >> referencesTo: aString [
	^ ((self nodeFor: aString) ifNotNil: [ :node | node references ])
		ifNil: [ #() ]
		ifNotNil: [ :refs | refs asOrderedCollection ]
]

{ #category : #removing }
GtReferencesPrefixTree >> removeReference: aMethod [
	references ifNil: [ ^ self ].
	references == aMethod ifTrue: [ ^ references := nil ].
	references isArray ifTrue: [ references := references asOrderedCollection ].
	references class == OrderedCollection ifFalse: [ ^ self ].
	references remove: aMethod ifAbsent: [  ]
]

{ #category : #private }
GtReferencesPrefixTree >> updateReference: aMethod [
	references
		ifNil: [ self addReference: aMethod.
			^ false ].
	references isCompiledMethod
		ifTrue: [ ^ (references methodClass = aMethod methodClass
				and: [ references selector = aMethod selector ])
				ifTrue: [ references := aMethod.
					true ]
				ifFalse: [ self addReference: aMethod.
					false ] ].
	1
		to: references size
		do: [ :i | 
			| each |
			each := references at: i.
			(each methodClass = aMethod methodClass
				and: [ each selector = aMethod selector ])
				ifTrue: [ references at: i put: aMethod.
					^ true ] ].
	self addReference: aMethod.
	^ false
]
