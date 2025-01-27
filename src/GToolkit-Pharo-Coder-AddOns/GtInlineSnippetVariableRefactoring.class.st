Class {
	#name : #GtInlineSnippetVariableRefactoring,
	#superclass : #RBInlineTemporaryRefactoring,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Variables'
}

{ #category : #transforming }
GtInlineSnippetVariableRefactoring >> replaceReferences [
	| rewriter |
	rewriter := self parseTreeRewriter.
	rewriter replaceTree: assignmentNode variable
		withTree: assignmentNode value.
	rewriter executeTree: definingNode
]

{ #category : #preconditions }
GtInlineSnippetVariableRefactoring >> verifySelectedInterval [
	sourceTree := class parseTreeForSelector: selector.
	sourceTree ifNil: [ self refactoringFailure: 'Could not parse source' ].
	assignmentNode := sourceTree whichNodeIsContainedBy: sourceInterval.
	assignmentNode isAssignment
		ifFalse: [ self refactoringFailure: 'The selected node is not an assignment statement' ].
	definingNode := (assignmentNode whoDefines: assignmentNode variable name)
			ifNil: [ sourceTree ].
	self hasOnlyOneAssignment
		ifFalse: [ self refactoringError: 'There are multiple assignments to the variable' ].
	(RBReadBeforeWrittenTester
		isVariable: assignmentNode variable name
		writtenBeforeReadIn: definingNode)
		ifFalse: [ self refactoringError: 'The variable is possible read before it is assigned' ]
]
