Class {
	#name : #GtReferencesPrefixTree,
	#superclass : #GtPrefixTree,
	#instVars : [
		'references'
	],
	#category : #'GToolkit-Pharo-Index-GToolkit-Pharo-Index'
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
