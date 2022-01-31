Class {
	#name : #GtCompositeDefinitionDifference,
	#superclass : #GtCodeDefinitionDifference,
	#instVars : [
		'differences'
	],
	#category : #'GToolkit-Pharo-Metamodels-Behavior - Differences'
}

{ #category : #'instance creation' }
GtCompositeDefinitionDifference class >> withAll: aCollectionOfDifferences [
	^ self new
		addAll: aCollectionOfDifferences;
		yourself
]

{ #category : #accessing }
GtCompositeDefinitionDifference >> add: aDifference [

	aDifference hasDifference
		ifFalse: [ ^ self ].

	differences add: aDifference
]

{ #category : #accessing }
GtCompositeDefinitionDifference >> addAll: aCollectionOfDifferences [
	differences addAll: (aCollectionOfDifferences select: [ :eachDifference | eachDifference hasDifference ])
]

{ #category : #converting }
GtCompositeDefinitionDifference >> asClassRefactorings: aClass [
	| refactoring |
	refactoring := RBCompositeRefactoring new.
	self differences do: [ :eachDifference | refactoring addRefactoring: (eachDifference asClassRefactorings: aClass) ].
	^ refactoring
]

{ #category : #converting }
GtCompositeDefinitionDifference >> asClassRefactorings: aClass in: anRBModel [
	| refactoring |
	refactoring := RBCompositeRefactoring new.
	self differences
		do: [ :eachDifference | refactoring addRefactoring: (eachDifference asClassRefactorings: aClass in: anRBModel) ].
	^ refactoring
]

{ #category : #accessing }
GtCompositeDefinitionDifference >> differences [
	^ differences
]

{ #category : #testing }
GtCompositeDefinitionDifference >> hasDifference [
	<return: #Boolean>
	
	^ self differences isNotEmpty
]

{ #category : #initialization }
GtCompositeDefinitionDifference >> initialize [
	super initialize.
	
	differences := OrderedCollection new
]
