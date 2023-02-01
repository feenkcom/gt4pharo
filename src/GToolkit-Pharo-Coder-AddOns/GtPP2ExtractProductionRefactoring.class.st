Class {
	#name : #GtPP2ExtractProductionRefactoring,
	#superclass : #GtExtractMethodRefactoring,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Rename'
}

{ #category : #accessing }
GtPP2ExtractProductionRefactoring >> nameNewMethod: aSymbol [
	| args |
	newExtractedSelector := aSymbol.
	args := parameters collect: [ :parm | RBVariableNode named: parm ].
	extractedParseTree renameSelector: aSymbol andArguments: args asArray.
	aSymbol numArgs = 0
		ifFalse: [ self
				refactoringFailure: 'Cannot extract production since it requires an argument' ].
	(class whoDefinesInstanceVariable: aSymbol)
		ifNil: [ class addInstanceVariable: aSymbol ].
	modifiedParseTree := RBParseTreeRewriter
			replace: self methodDelimiter
			with: aSymbol asString
			in: modifiedParseTree
]
