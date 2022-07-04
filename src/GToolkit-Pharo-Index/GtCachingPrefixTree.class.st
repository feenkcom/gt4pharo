Class {
	#name : #GtCachingPrefixTree,
	#superclass : #GtPrefixTree,
	#instVars : [
		'references',
		'implementers'
	],
	#category : #'GToolkit-Pharo-Index'
}

{ #category : #accessing }
GtCachingPrefixTree >> addImplementer: aMethod [
	implementers
		ifNil: [ implementers := aMethod ]
		ifNotNil: [ implementers class == OrderedCollection
				ifFalse: [ implementers := implementers isArray
							ifTrue: [ implementers := implementers asOrderedCollection ]
							ifFalse: [ OrderedCollection with: implementers ] ].
			implementers add: aMethod ]
]

{ #category : #adding }
GtCachingPrefixTree >> addReference: aMethod [
	references
		ifNil: [ references := aMethod ]
		ifNotNil: [ references class == OrderedCollection
				ifFalse: [ references := references isArray
							ifTrue: [ references := references asOrderedCollection ]
							ifFalse: [ OrderedCollection with: references ] ].
			references add: aMethod ]
]

{ #category : #accessing }
GtCachingPrefixTree >> gtImplementersFor: aView [
	<gtView>
	^ aView list
		title: 'Implementers';
		items: [ implementers
				ifNil: [ #() ]
				ifNotNil: [ implementers isCollection
						ifTrue: [ implementers ]
						ifFalse: [ Array with: implementers ] ] ]
]

{ #category : #accessing }
GtCachingPrefixTree >> gtReferencesFor: aView [
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
GtCachingPrefixTree >> gtSpecificSizeInMemory [
	^ super gtSpecificSizeInMemory
		+ ((references isArray or: [ references class == OrderedCollection ])
				ifTrue: [ references gtSpecificSizeInMemory ]
				ifFalse: [ 0 ])
		+ ((implementers isArray or: [ implementers class == OrderedCollection ])
				ifTrue: [ implementers gtSpecificSizeInMemory ]
				ifFalse: [ 0 ])
]

{ #category : #accessing }
GtCachingPrefixTree >> implementers [
	^ implementers
]

{ #category : #accessing }
GtCachingPrefixTree >> implementers: aCollection [
	implementers := aCollection
]

{ #category : #accessing }
GtCachingPrefixTree >> implementersOf: aString [
	(self nodeFor: aString)
		ifNotNil: [ :node | 
			^ node implementers
				ifNil: [ #() ]
				ifNotNil: [ :refs | refs asOrderedCollection ] ].
	^ #()
]

{ #category : #accessing }
GtCachingPrefixTree >> references [
	^ references
]

{ #category : #accessing }
GtCachingPrefixTree >> references: aCollection [
	references := aCollection
]

{ #category : #accessing }
GtCachingPrefixTree >> referencesTo: aString [
	(self nodeFor: aString)
		ifNotNil: [ :node | ^ node references ifNil: [ #() ] ifNotNil: [ :refs | refs asOrderedCollection ] ].
	^ #()
]

{ #category : #accessing }
GtCachingPrefixTree >> removeImplementer: aMethod [
	implementers ifNil: [ ^ self ].
	implementers == aMethod ifTrue: [ ^ implementers := nil ].
	implementers isArray
		ifTrue: [ implementers := implementers asOrderedCollection ].
	implementers class == OrderedCollection ifFalse: [ ^ self ].
	implementers remove: aMethod ifAbsent: [  ]
]

{ #category : #removing }
GtCachingPrefixTree >> removeReference: aMethod [
	references ifNil: [ ^ self ].
	references == aMethod ifTrue: [ ^ references := nil ].
	references isArray ifTrue: [ references := references asOrderedCollection ].
	references class == OrderedCollection ifFalse: [ ^ self ].
	references remove: aMethod ifAbsent: [  ]
]

{ #category : #accessing }
GtCachingPrefixTree >> splitAt: anInteger [
	| newChild |
	newChild := self class new.
	newChild children: children.
	newChild weight: weight.
	newChild maxWeight: maxWeight.
	newChild prefix: (prefix copyFrom: anInteger to: prefix size).
	newChild references: references.
	newChild implementers: implementers.
	references := nil.
	implementers := nil.
	weight := 0.
	children := nil.
	self prefix: (prefix copyFrom: 1 to: anInteger - 1).
	self ensureChildren.
	children add: newChild
]
