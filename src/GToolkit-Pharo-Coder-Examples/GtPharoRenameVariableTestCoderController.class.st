"
I am a controller that renames an instance variable. I exist only to exercise {{gtClass:GtPharoRenameVariableCoderController}} in examples, see {{gtClass:GtPharoRenameVariableCoderControllerExamples}}.
"
Class {
	#name : #GtPharoRenameVariableTestCoderController,
	#superclass : #GtPharoRenameVariableCoderController,
	#category : #'GToolkit-Pharo-Coder-Examples-Refactoring - Method New'
}

{ #category : #hooks }
GtPharoRenameVariableTestCoderController >> createRefactoringsStencil [
	^ GtPharoRenameVariableTestRefactoringsStencil new
]

{ #category : #hooks }
GtPharoRenameVariableTestCoderController >> forbiddenNames [
	^ sourceCoderViewModel behavior allInstVarNames
]

{ #category : #hooks }
GtPharoRenameVariableTestCoderController >> refactoringName [
	^ 'Rename test instance variable'
]
