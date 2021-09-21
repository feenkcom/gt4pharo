Class {
	#name : 'GtMethodRefactoringController',
	#superclass : 'GtSourceCoderRefactoringController',
	#instVars : [
		'methodNode'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-Variables refactoring'
}

{ #category : 'executing' }
GtMethodRefactoringController >> createModel [
	| model modelClass |
	model := RBClassModelFactory rbNamespace onEnvironment:
		         RBBrowserEnvironment new.
	model name: self refactoringName.
	modelClass := model classFor: sourceCoderViewModel behavior.
	(modelClass sourceCodeFor: self methodSelector) = originalSource asString 
		ifFalse: [ 
			modelClass
				compile: originalSource asString
				classified: sourceCoderViewModel protocol ].
	^ model
]

{ #category : 'accessing' }
GtMethodRefactoringController >> methodClass [
	^ sourceCoderViewModel behavior
]

{ #category : 'accessing' }
GtMethodRefactoringController >> methodNode [
	^ methodNode
]

{ #category : 'accessing' }
GtMethodRefactoringController >> methodNode: aGtPharoMethodNode [
	methodNode := aGtPharoMethodNode
]

{ #category : 'accessing' }
GtMethodRefactoringController >> methodSelector [
	^ sourceCoderViewModel selector
]

{ #category : 'executing' }
GtMethodRefactoringController >> safelyExecute [
	self preventSave.

	sourceCoderViewModel selectNone.

	self
		addRefactoringChangesPreview: self refactoring
		at: methodNode pattern stopPosition
		whenComplete: [
			self removeRefactoringAttribute.
			self allowSave ]
]
