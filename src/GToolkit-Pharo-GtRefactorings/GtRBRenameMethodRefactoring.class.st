Class {
	#name : #GtRBRenameMethodRefactoring,
	#superclass : #RBRenameMethodRefactoring,
	#category : #'GToolkit-Pharo-GtRefactorings-Refactorings'
}

{ #category : #accessing }
GtRBRenameMethodRefactoring >> executeRenameExtensions [
	(Pragma
		allNamed: #gtRename
		from: self class
		to: GtRBRenameMethodRefactoring)
		do: [ :each | self perform: each method selector ]
]

{ #category : #lepiter }
GtRBRenameMethodRefactoring >> renameLepiterReferences [
	<gtRename>
	(LeSearchReferencesFilter new selector: oldSelector) contents
		do: [ :snippet | 
			(snippet
				changeToRenameSelector: oldSelector
				to: newSelector
				using: (self hasPermutedArguments ifTrue: [ self parseTreeRewriter ]))
				ifNotNil: [ :change | self model changes addChange: change ] ]
]

{ #category : #accessing }
GtRBRenameMethodRefactoring >> renameMessageSends [
	super renameMessageSends.
	self executeRenameExtensions
]
