Class {
	#name : #GtPharoClassExpanderCacheItemAttributes,
	#superclass : #Object,
	#instVars : [
		'astNode',
		'attributes',
		'isUsed'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Expander'
}

{ #category : #accessing }
GtPharoClassExpanderCacheItemAttributes >> astNode [
	^ astNode
]

{ #category : #accessing }
GtPharoClassExpanderCacheItemAttributes >> astNode: anObject [
	astNode := anObject
]

{ #category : #accessing }
GtPharoClassExpanderCacheItemAttributes >> attributes [
	^ attributes
]

{ #category : #accessing }
GtPharoClassExpanderCacheItemAttributes >> attributes: anObject [
	attributes := anObject
]

{ #category : #views }
GtPharoClassExpanderCacheItemAttributes >> gtAstNodeFor: aView [
	<gtView>
	^ aView forward
		title: 'Ast node';
		object: [ astNode ];
		view: #gtExploreFor:
]

{ #category : #views }
GtPharoClassExpanderCacheItemAttributes >> gtAttributesFor: aView [
	<gtView>
	attributes ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Attributes';
		items: [ attributes ];
		column: 'Value' text: [ :each | each gtDisplayString ]
]

{ #category : #initialization }
GtPharoClassExpanderCacheItemAttributes >> initialize [
	super initialize.
	isUsed := false
]

{ #category : #accessing }
GtPharoClassExpanderCacheItemAttributes >> isUsed [
	^ isUsed ifNil: [ false ]
]

{ #category : #'api - cache' }
GtPharoClassExpanderCacheItemAttributes >> reset [
	^ isUsed := false
]

{ #category : #'api - cache' }
GtPharoClassExpanderCacheItemAttributes >> skip [
	isUsed := true
]
