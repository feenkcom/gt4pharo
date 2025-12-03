Class {
	#name : #GtRemoveParameterRefactoring,
	#superclass : #RBRemoveParameterRefactoring,
	#category : 'GToolkit-Pharo-Coder-AddOns-Refactoring'
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
	"Pharo 11"
	super renameMessageSends.
	self executeRenameExtensions
]

{ #category : #transforming }
GtRemoveParameterRefactoring >> replaceMessageSends [
	"Pharo 12"
	super replaceMessageSends.
	self executeRenameExtensions
]
