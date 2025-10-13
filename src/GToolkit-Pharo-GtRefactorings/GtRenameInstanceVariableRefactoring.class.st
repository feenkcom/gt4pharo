Class {
	#name : #GtRenameInstanceVariableRefactoring,
	#superclass : #RBRenameInstanceVariableRefactoring,
	#category : #'GToolkit-Pharo-GtRefactorings-Refactorings'
}

{ #category : #preconditions }
GtRenameInstanceVariableRefactoring >> applicabilityPreconditions [
	"Patch for P12 -- needed to change the creation of ReDefinesInstanceVariableCondition for metaclasses"
	
	^ {
		  (#ReIsValidInstanceVariableName asClass name: newName).
		  ((#ReDefinesInstanceVariableCondition asClass class: class)
			   instanceVariables: { variableName }).
		  (#ReIsVariableNotDefinedInHierarchy asClass name: newName class: class).
		  (#ReNameIsGlobalCondition asClass new model: self model className: newName)
			  not }
]

{ #category : #private }
GtRenameInstanceVariableRefactoring >> executeRenameExtensions [
	(Pragma allNamed: #gtRename in: self class)
		do: [ :each | self perform: each method selector ]
]

{ #category : #transforming }
GtRenameInstanceVariableRefactoring >> renameReferences [
	super renameReferences.
	self executeRenameExtensions
]
