Class {
	#name : #GtRBCompositeTransformation,
	#superclass : #RBRefactoring,
	#instVars : [
		'refactorings'
	],
	#category : #'GToolkit-Pharo-GtRefactorings-Refactorings'
}

{ #category : #transforming }
GtRBCompositeTransformation >> basicTransform [
	self refactorings do: [ :each | self performTransformation: each ]
]

{ #category : #views }
GtRBCompositeTransformation >> gtRefactoringsFor: aView [
	<gtView>
	refactorings ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Refactorings';
		items: [ refactorings ];
		column: 'Value' text: [ :each | each class ];
		column: 'Value' text: [ :each | each gtDescription ]
]

{ #category : #private }
GtRBCompositeTransformation >> performTransformation: aRefactoring [
	| changes |
	changes := RBCompositeRefactoryChange new.
	changes name: aRefactoring gtDescription.
	model performChange: changes around: [ aRefactoring primitiveExecute ]
]

{ #category : #preconditions }
GtRBCompositeTransformation >> preconditions [
	^ RBCondition true
]

{ #category : #transforming }
GtRBCompositeTransformation >> privateTransform [
	self basicTransform
]

{ #category : #accessing }
GtRBCompositeTransformation >> refactorings [
	^ refactorings
]

{ #category : #accessing }
GtRBCompositeTransformation >> refactorings: anObject [
	refactorings := anObject
]

{ #category : #transforming }
GtRBCompositeTransformation >> transform [
	self basicTransform
]
