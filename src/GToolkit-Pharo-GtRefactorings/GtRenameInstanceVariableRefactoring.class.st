Class {
	#name : #GtRenameInstanceVariableRefactoring,
	#superclass : #RBRenameInstanceVariableRefactoring,
	#category : #'GToolkit-Pharo-GtRefactorings-Refactorings'
}

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
