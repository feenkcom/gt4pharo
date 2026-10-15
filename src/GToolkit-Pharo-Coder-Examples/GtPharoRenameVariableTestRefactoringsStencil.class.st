"
I compute {{gtClass:GtRenameInstanceVariableRefactoring}}. I exist only to exercise {{gtClass:GtPharoRenameVariableCoderController}} in examples, see {{gtClass:GtPharoRenameVariableTestCoderController}}.
"
Class {
	#name : #GtPharoRenameVariableTestRefactoringsStencil,
	#superclass : #GtPharoRenameVariableRefactoringsStencil,
	#category : #'GToolkit-Pharo-Coder-Examples-Refactoring - Method New'
}

{ #category : #creation }
GtPharoRenameVariableTestRefactoringsStencil >> computeRefactoring [
	| aModel aClass |
	aModel := self createModel.
	aClass := (aModel classFor: sourceCoderViewModel behavior)
			whoDefinesInstanceVariable: variableModel originalName.
	^ GtRenameInstanceVariableRefactoring
		model: aModel
		rename: variableModel originalName
		to: variableModel currentName
		in: aClass
]

{ #category : #accessing }
GtPharoRenameVariableTestRefactoringsStencil >> refactoringName [
	^ 'Rename test instance variable'
]
