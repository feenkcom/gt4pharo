Class {
	#name : #GtReferencesAndImplementersPrefixTree,
	#superclass : #GtReferencesPrefixTree,
	#instVars : [
		'implementers'
	],
	#category : #'GToolkit-Pharo-Index'
}

{ #category : #adding }
GtReferencesAndImplementersPrefixTree >> addImplementer: aMethod [
	implementers
		ifNil: [ implementers := aMethod ]
		ifNotNil: [ implementers class == OrderedCollection
				ifFalse: [ implementers := implementers isArray
							ifTrue: [ implementers := implementers asOrderedCollection ]
							ifFalse: [ OrderedCollection with: implementers ] ].
			implementers add: aMethod ]
]

{ #category : #private }
GtReferencesAndImplementersPrefixTree >> compressData [
	super compressData.
	implementers isCollection ifTrue: [ implementers := implementers asArray ]
]

{ #category : #accessing }
GtReferencesAndImplementersPrefixTree >> gtImplementersAreInstalled: aGtAdvice [
	<gtAdvice>
	^ aGtAdvice asyncStream
		description: [ :each | (each , ' has an implementer that is not installed') asRopedText ];
		compute: [ (self asyncStreamStartingWith: '')
				select: [ :each | 
					(self nodeFor: each) implementersCollection
						anySatisfy: [ :method | method gtIsActive not ] ] ];
		action: [ :each | self gtPhlowInspectNodeAction: each ]
]

{ #category : #inspector }
GtReferencesAndImplementersPrefixTree >> gtImplementersFor: aView [
	<gtView>
	^ aView list
		title: 'Implementers';
		items: [ implementers
				ifNil: [ #() ]
				ifNotNil: [ implementers isCollection
						ifTrue: [ implementers ]
						ifFalse: [ Array with: implementers ] ] ]
]

{ #category : #inspector }
GtReferencesAndImplementersPrefixTree >> gtNoDuplicateImplementers: aGtAdvice [
	<gtAdvice>
	^ aGtAdvice asyncStream
		description: [ :each | (each , ' has duplicate implementer methods') asRopedText ];
		compute: [ (self asyncStreamStartingWith: '')
				select: [ :each | 
					(self nodeFor: each) implementersCollection
						ifEmpty: [ false ]
						ifNotEmpty: [ :col | col size ~= col asIdentitySet size ] ] ];
		action: [ :each | self gtPhlowInspectNodeAction: each ]
]

{ #category : #accessing }
GtReferencesAndImplementersPrefixTree >> gtSpecificSizeInMemory [
	^ super gtSpecificSizeInMemory
		+ ((implementers isArray or: [ implementers class == OrderedCollection ])
				ifTrue: [ implementers gtSpecificSizeInMemory ]
				ifFalse: [ 0 ])
]

{ #category : #private }
GtReferencesAndImplementersPrefixTree >> implementers [
	^ implementers
]

{ #category : #private }
GtReferencesAndImplementersPrefixTree >> implementers: aCollection [
	implementers := aCollection
]

{ #category : #accessing }
GtReferencesAndImplementersPrefixTree >> implementersCollection [
	^ implementers ifNil: [ #() ] ifNotNil: [ implementers asOrderedCollection ]
]

{ #category : #accessing }
GtReferencesAndImplementersPrefixTree >> implementersOf: aString [
	^ ((self nodeFor: aString) ifNotNil: [ :node | node implementers ])
		ifNil: [ #() ]
		ifNotNil: [ :impls | impls asOrderedCollection ]
]

{ #category : #private }
GtReferencesAndImplementersPrefixTree >> moveDataTo: newChild [
	super moveDataTo: newChild.
	newChild implementers: implementers.
	implementers := nil
]

{ #category : #removing }
GtReferencesAndImplementersPrefixTree >> removeImplementer: aMethod [
	implementers ifNil: [ ^ self ].
	implementers == aMethod ifTrue: [ ^ implementers := nil ].
	implementers isArray
		ifTrue: [ implementers := implementers asOrderedCollection ].
	implementers class == OrderedCollection ifFalse: [ ^ self ].
	implementers remove: aMethod ifAbsent: [  ]
]
