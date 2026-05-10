Class {
	#name : #GtPharoClassExpanderCacheItem,
	#superclass : #Object,
	#instVars : [
		'behavior',
		'attributes',
		'areItemsReserved'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Expander'
}

{ #category : #'api - initialization' }
GtPharoClassExpanderCacheItem >> astNode: anAstNode attributes: aCollectionOfAttributes [
	self privateAstNode: anAstNode attributes: aCollectionOfAttributes
]

{ #category : #'api - cache' }
GtPharoClassExpanderCacheItem >> attributesForAstNode: anAstNode ifPresent: aPresentBlock ifAbsentPut: anAbsentBlock [
	<return: #GtPharoClassExpanderCacheItemAttributes>
	| firstAvailable |
	firstAvailable := nil.

	(areItemsReserved isNil or: [ areItemsReserved not ])
		ifTrue: [ anAstNode topParent
				allNodesOfType: anAstNode class
				do: [ :eachNode | 
					attributes
						detect: [ :eachItem | eachItem astNode == eachNode ]
						ifFound: [ :existingItem | existingItem reservedAstNode: eachNode ]
						ifNone: [  ] ].
			areItemsReserved := true ].

	^ attributes
		detect: [ :eachItem | 
			(firstAvailable isNil
				and: [ eachItem isUsed not and: [ eachItem isReserved not ] ])
				ifTrue: [ firstAvailable := eachItem ].
			eachItem isReserved
				ifTrue: [ eachItem reservedAstNode == anAstNode ]
				ifFalse: [ eachItem isUsed not and: [ eachItem astNode = anAstNode ] ] ]
		ifFound: [ :existingItem | 
			existingItem astNode: anAstNode.
			existingItem skip.
			aPresentBlock value: existingItem ]
		ifNone: [ firstAvailable
				ifNotNil: [ :existingItem | 
					existingItem astNode: anAstNode.
					existingItem skip.
					existingItem ]
				ifNil: [ self privateAstNode: anAstNode attributes: anAbsentBlock value ] ]
]

{ #category : #'api - cache' }
GtPharoClassExpanderCacheItem >> behavior [
	^ behavior
]

{ #category : #'api - initialization' }
GtPharoClassExpanderCacheItem >> behavior: anObject [
	behavior := anObject
]

{ #category : #views }
GtPharoClassExpanderCacheItem >> gtAttributesFor: aView [
	<gtView>
	attributes ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Attributes';
		items: [ attributes ];
		column: 'Used'
			text: [ :each | 
				each isUsed
					ifTrue: [ 'yes' ]
					ifFalse: [ 'no' asRopedText foreground: BlTheme default button disabledTextColor ] ]
			width: 60;
		column: 'Reserved'
			text: [ :each | 
				each isReserved
					ifTrue: [ 'yes' ]
					ifFalse: [ 'no' asRopedText foreground: BlTheme default button disabledTextColor ] ]
			width: 60;
		column: 'AST Node' text: [ :each | each astNode gtDisplayString ];
		column: 'Attributes' text: [ :each | each attributes gtDisplayString ]
]

{ #category : #initialization }
GtPharoClassExpanderCacheItem >> initialize [
	super initialize.

	attributes := OrderedCollection new.
	areItemsReserved := false.
]

{ #category : #'api - cache' }
GtPharoClassExpanderCacheItem >> numberOfItemAttributes [
	^ attributes size
]

{ #category : #printing }
GtPharoClassExpanderCacheItem >> printOn: aStream [
	super printOn: aStream.
	attributes ifNil: [ ^ self ].

	aStream
		nextPutAll: '(';
		print: (attributes count: [ :each | each isUsed not ]);
		nextPutAll: ' unused out of ';
		print: attributes size;
		nextPut: $)
]

{ #category : #private }
GtPharoClassExpanderCacheItem >> privateAstNode: anAstNode attributes: aCollectionOfAttributes [
	| newItem |
	newItem := attributes
			add: (GtPharoClassExpanderCacheItemAttributes new
					astNode: anAstNode;
					attributes: aCollectionOfAttributes).
	newItem skip.
	^ newItem
]

{ #category : #'api - cache' }
GtPharoClassExpanderCacheItem >> resetIndex [
	areItemsReserved := false.
	attributes do: #reset
]
