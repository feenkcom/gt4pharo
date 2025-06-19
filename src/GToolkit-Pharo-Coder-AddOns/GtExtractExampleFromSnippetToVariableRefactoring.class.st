Class {
	#name : #GtExtractExampleFromSnippetToVariableRefactoring,
	#superclass : #GtExtractMethodFromSnippetRefactoring,
	#category : #'GToolkit-Pharo-Coder-AddOns-Extract method'
}

{ #category : #transforming }
GtExtractExampleFromSnippetToVariableRefactoring >> finishRefactoring [
	| ast |
	movedSelector isUnary
		ifFalse: [ ^ GtRefactoringNotification
				signal: 'Example methods should not have arguments' ].
	moveToClasses
		do: [ :each | 
			ast := (each methodFor: movedSelector) ast.
			ast addPragma: (RBPragmaNode selector: #gtExample arguments: #()).
			each compile: ast formattedCode ]
]

{ #category : #'as yet unclassified' }
GtExtractExampleFromSnippetToVariableRefactoring >> gtDescription [
	^ 'Extract example method from snippet'
]

{ #category : #transforming }
GtExtractExampleFromSnippetToVariableRefactoring >> privateTransform [
	super transform.
	self finishRefactoring.
	self gtCleanupChanges
]

{ #category : #transforming }
GtExtractExampleFromSnippetToVariableRefactoring >> transform [
	super transform.
	self finishRefactoring.
	self gtCleanupChanges
]
