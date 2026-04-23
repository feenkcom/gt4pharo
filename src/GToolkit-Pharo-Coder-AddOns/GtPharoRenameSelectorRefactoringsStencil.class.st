Class {
	#name : #GtPharoRenameSelectorRefactoringsStencil,
	#superclass : #BlStencil,
	#instVars : [
		'selectorModel',
		'someImplementor'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #private }
GtPharoRenameSelectorRefactoringsStencil >> computeRefactoring [
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

	refactoring := (self refactoringClass)
			model: model
			renameMethod: selector
			in: (model classFor: implementor)
			to: newSelector
			permutation: permutations.

	self configureRefactoring: refactoring.
	
	^ refactoring
]

{ #category : #private }
GtPharoRenameSelectorRefactoringsStencil >> computeRefactorings [
	^ self computeRefactoring
		ifNil: [ #() ]
		ifNotNil: [ :aRefactoring | {aRefactoring} ]
]

{ #category : #private }
GtPharoRenameSelectorRefactoringsStencil >> configureRefactoring: refactoring [ 
]

{ #category : #'api - instantiation' }
GtPharoRenameSelectorRefactoringsStencil >> create [
	^ self computeRefactorings
]

{ #category : #private }
GtPharoRenameSelectorRefactoringsStencil >> createModel [
	| model |
	model := GtRBNamespace onEnvironment: RBBrowserEnvironment new.
	model name: self refactoringName.
	^ model
]

{ #category : #private }
GtPharoRenameSelectorRefactoringsStencil >> refactoringClass [
	^ GtRBRenameMethodRefactoring
]

{ #category : #private }
GtPharoRenameSelectorRefactoringsStencil >> refactoringName [
	^ 'Rename method'
]

{ #category : #accessing }
GtPharoRenameSelectorRefactoringsStencil >> selectorModel [
	^ selectorModel
]

{ #category : #accessing }
GtPharoRenameSelectorRefactoringsStencil >> selectorModel: anObject [
	selectorModel := anObject
]

{ #category : #private }
GtPharoRenameSelectorRefactoringsStencil >> someImplementor [
	^ someImplementor
		ifNil: [ (SystemNavigation default allImplementorsOf: selectorModel originalSelector)
				ifEmpty: [ nil ]
				ifNotEmpty: [ :impls | 
					someImplementor := impls
							detect: [ :each | each isFromTrait not ]
							ifFound: [ :each | each methodClass ]
							ifNone: [ nil ] ] ]
]
