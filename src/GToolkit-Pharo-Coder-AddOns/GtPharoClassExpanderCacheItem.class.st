Class {
	#name : #GtPharoClassExpanderCacheItem,
	#superclass : #Object,
	#instVars : [
		'behavior',
		'attributes'
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
	| firstUnused |
	firstUnused := nil.
	^ attributes
		detect: [ :eachItem | 
			(firstUnused isNil and: [ eachItem isUsed not ]) ifTrue: [ firstUnused := eachItem ].
			eachItem isUsed not and: [ eachItem astNode = anAstNode ] ]
		ifFound: [ :existingItem | 
			existingItem astNode: anAstNode.
			existingItem skip.
			aPresentBlock value: existingItem ]
		ifNone: [ firstUnused
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
		column: 'Used' text: [  :each | each isUsed gtDisplayString ] width: 60;
		column: 'AST Node' text: [ :each | each astNode gtDisplayString ];
		column: 'Attributes' text: [ :each | each attributes gtDisplayString ]
]

{ #category : #initialization }
GtPharoClassExpanderCacheItem >> initialize [
	super initialize.

	attributes := OrderedCollection new
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
	attributes do: #reset
]
