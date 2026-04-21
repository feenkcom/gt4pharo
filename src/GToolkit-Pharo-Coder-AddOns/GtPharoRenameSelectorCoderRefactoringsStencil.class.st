Class {
	#name : #GtPharoRenameSelectorCoderRefactoringsStencil,
	#superclass : #GtPharoRenameSelectorRefactoringsStencil,
	#instVars : [
		'sourceCoderViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #private }
GtPharoRenameSelectorCoderRefactoringsStencil >> computeRefactoring [
	| selector implementor newSelector permutations model isCoderMethodBeingRenamed refactoring |
	selectorModel isModified ifFalse: [ ^ nil ].
	selector := selectorModel originalSelector.
	permutations := selectorModel currentParameterPermutations.
	implementor := self someImplementor.
	implementor isNil ifTrue: [ ^ nil ].
	newSelector := selectorModel currentSelector.

	(newSelector = selector and: [ permutations = (1 to: permutations size) ])
		ifTrue: [ ^ nil ].
	model := self createModel.

	isCoderMethodBeingRenamed := sourceCoderViewModel coderModel isForMethod
			and: [ sourceCoderViewModel coderModel selector = selector ].

	refactoring := (isCoderMethodBeingRenamed
			ifTrue: [ GtCoderRenameMethodRefactoring ]
			ifFalse: [ GtRBRenameMethodRefactoring ])
			model: model
			renameMethod: selector
			in: (model classFor: implementor)
			to: newSelector
			permutation: permutations.

	isCoderMethodBeingRenamed
		ifTrue: [ refactoring methodCoder: sourceCoderViewModel coderModel ].
	
	^ refactoring
]

{ #category : #private }
GtPharoRenameSelectorCoderRefactoringsStencil >> configureRefactoring: refactoring [
	self isCoderMethodBeingRenamed
		ifTrue: [ refactoring methodCoder: sourceCoderViewModel coderModel ]
]

{ #category : #private }
GtPharoRenameSelectorCoderRefactoringsStencil >> createModel [
	| model modelClass |
	model := super createModel.
	sourceCoderViewModel coderModel isForMethod
		ifTrue: [ modelClass := model classFor: sourceCoderViewModel behavior.
			model changes
				attributeNamed: #defaultClassFilterName
				put: modelClass instanceSide name ].
	^ model
]

{ #category : #private }
GtPharoRenameSelectorCoderRefactoringsStencil >> isCoderMethodBeingRenamed [
	^ sourceCoderViewModel coderModel isForMethod
		and: [ sourceCoderViewModel coderModel selector = selectorModel originalSelector ]
]

{ #category : #private }
GtPharoRenameSelectorCoderRefactoringsStencil >> refactoringClass [
	^ self isCoderMethodBeingRenamed
		ifTrue: [ GtCoderRenameMethodRefactoring ]
		ifFalse: [ GtRBRenameMethodRefactoring ]
]

{ #category : #accessing }
GtPharoRenameSelectorCoderRefactoringsStencil >> sourceCoderViewModel [
	^ sourceCoderViewModel
]

{ #category : #accessing }
GtPharoRenameSelectorCoderRefactoringsStencil >> sourceCoderViewModel: anObject [
	sourceCoderViewModel := anObject
]
