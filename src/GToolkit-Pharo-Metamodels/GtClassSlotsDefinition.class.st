Class {
	#name : #GtClassSlotsDefinition,
	#superclass : #GtSlotsDefinition,
	#category : #'GToolkit-Pharo-Metamodels-Behavior - Definitions'
}

{ #category : #'gt - editors' }
GtClassSlotsDefinition >> generateAccessorsFor: varName [
	| aModel aClass |
	aModel := self createRefactoringModel.
	aClass := (aModel classNamed: self definition topMostParent name) classSide.

	^ RBCreateAccessorsForVariableRefactoring
		model: aModel
		variable: varName
		class: aClass
		classVariable: false
]

{ #category : #'gt - editors' }
GtClassSlotsDefinition >> pushDownSlotRefactoringFor: varName [
	| aModel aClass |
	aModel := self createRefactoringModel.
	aClass := (aModel classNamed: self definition topMostParent name) classSide.

	^ RBPushDownInstanceVariableRefactoring
		model: aModel
		variable: varName
		class: aClass
]

{ #category : #'gt - editors' }
GtClassSlotsDefinition >> pushUpSlotRefactoringFor: varName [
	| aModel aClass |
	aModel := self createRefactoringModel.
	aClass := (aModel classNamed: self definition topMostParent name) classSide.

	^ RBPullUpInstanceVariableRefactoring
		model: aModel
		variable: varName
		class: aClass superclass
]

{ #category : #'gt - editors' }
GtClassSlotsDefinition >> title [
	^ 'Class Slots'
]
