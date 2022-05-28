Class {
	#name : #GtReferencesPrefixTree,
	#superclass : #GtPrefixTree,
	#instVars : [
		'references'
	],
	#category : #'GToolkit-Pharo-Completer-Completion'
}

{ #category : #adding }
GtReferencesPrefixTree >> addReference: aMethod [
	references
		ifNil: [ references := aMethod ]
		ifNotNil: [ references class == OrderedCollection
				ifFalse: [ references := OrderedCollection with: references ].
			references add: aMethod ]
]

{ #category : #accessing }
GtReferencesPrefixTree >> gtSpecificSizeInMemory [
	^ super gtSpecificSizeInMemory
		+ (references class == OrderedCollection
				ifTrue: [ references gtSpecificSizeInMemory ]
				ifFalse: [ 0 ])
]

{ #category : #accessing }
GtReferencesPrefixTree >> references [
	^ references
]

{ #category : #accessing }
GtReferencesPrefixTree >> references: aCollection [
	references := aCollection
]

{ #category : #accessing }
GtReferencesPrefixTree >> referencesTo: aString [
	self
		nodeFor: aString
		startingAt: 1
		do: [ :node :ignore | ^ node references ifNil: [ #() ] ifNotNil: [ :refs | refs asOrderedCollection ] ].
	^ #()
]

{ #category : #removing }
GtReferencesPrefixTree >> removeReference: aMethod [
	references ifNil: [ ^ self ].
	references == aMethod ifTrue: [ ^ references := nil ].
	references class == OrderedCollection ifFalse: [ ^ self ].
	references remove: aMethod ifAbsent: [  ]
]

{ #category : #accessing }
GtReferencesPrefixTree >> splitAt: anInteger [
	| newChild |
	newChild := self class new.
	newChild children: children.
	newChild weight: weight.
	newChild maxWeight: maxWeight.
	newChild prefix: (prefix copyFrom: anInteger to: prefix size).
	newChild references: references.
	references := nil.
	weight := 0.
	children := nil.
	self prefix: (prefix copyFrom: 1 to: anInteger - 1).
	self ensureChildren.
	children add: newChild
]
