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
