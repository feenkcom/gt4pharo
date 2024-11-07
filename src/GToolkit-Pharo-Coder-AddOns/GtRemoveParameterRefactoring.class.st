Class {
	#name : #GtRemoveParameterRefactoring,
	#superclass : #RBRemoveParameterRefactoring,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring'
}

{ #category : #transforming }
GtRemoveParameterRefactoring >> executeRenameExtensions [
	(Pragma
		allNamed: #gtRename
		from: self class
		to: GtRemoveParameterRefactoring)
		do: [ :each | self perform: each method selector ]
]

{ #category : #transforming }
GtRemoveParameterRefactoring >> renameMessageSends [
	super renameMessageSends.
	self executeRenameExtensions
]
