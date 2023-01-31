Class {
	#name : #GtPP2RenameRefactoring,
	#superclass : #RBRenameInstanceVariableRefactoring,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Rename'
}

{ #category : #transforming }
GtPP2RenameRefactoring >> removeRenamedMethods [
	class withAllSubclasses
		do: [ :each | 
			(each directlyDefinesMethod: variableName asSymbol)
				ifTrue: [ each removeMethod: variableName asSymbol ] ]
]

{ #category : #transforming }
GtPP2RenameRefactoring >> renameImplementors [
	class withAllSubclasses
		do: [ :each | 
			(each directlyDefinesMethod: variableName asSymbol)
				ifTrue: [ | ast |
					ast := class parseTreeFor: variableName asSymbol.
					ast ifNil: [ self refactoringFailure: 'Could not parse source code.' ].
					ast renameSelector: newName asSymbol andArguments: #().
					(each methodFor: variableName asSymbol) compileTree: ast ] ]
]

{ #category : #transforming }
GtPP2RenameRefactoring >> renameSelfSends [
	| rewriter |
	rewriter := RBParseTreeRewriter new.
	rewriter replace: 'self ' , variableName with: 'self ' , newName.
	rewriter replace: 'super ' , variableName with: 'super ' , newName.
	model
		allReferencesTo: variableName asSymbol
		do: [ :method | 
			(method methodClass includesClass: class)
				ifTrue: [ | ast |
					ast := method ast.
					(rewriter executeTree: ast) ifTrue: [ method compileTree: ast ] ] ]
]

{ #category : #transforming }
GtPP2RenameRefactoring >> transform [
	self renameImplementors.
	super transform.
	self renameSelfSends.
	self removeRenamedMethods
]
