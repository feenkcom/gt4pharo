Class {
	#name : #GtExtractTestFromSnippetRefactoring,
	#superclass : #GtExtractExampleFromSnippetRefactoring,
	#classInstVars : [
		'defaultTestCaseSuperclass'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Extract method'
}

{ #category : #accessing }
GtExtractTestFromSnippetRefactoring class >> defaultTestCaseSuperclass [
	^ defaultTestCaseSuperclass ifNil: [ #TestCase ]
]

{ #category : #accessing }
GtExtractTestFromSnippetRefactoring class >> defaultTestCaseSuperclass: aSymbol [
	defaultTestCaseSuperclass := aSymbol
]

{ #category : #accessing }
GtExtractTestFromSnippetRefactoring >> buildNewSnippetSource [
	| ast rewriter |
	ast := ((model classFor: nil class) methodFor: snippetSelector) ast body.
	rewriter := RBParseTreeRewriter new.
	rewriter
		replace: className , ' new ' , movedSelector
		with: className , ' run: #' , movedSelector.
	(rewriter executeTree: ast) ifTrue: [ ast := rewriter tree ].
	ast temporaryNames do: [ :each | ast removeTemporaryNamed: each ].
	returnPosition
		ifNotNil: [ (ast isSequence and: [ ast statements last isReturn ])
				ifTrue: [ ast statements last replaceWith: ast statements last value copy ] ].
	snippetSource := ast formattedCode
]

{ #category : #transforming }
GtExtractTestFromSnippetRefactoring >> defaultSuperclass [
	^ model classNamed: self class defaultTestCaseSuperclass
]

{ #category : #transforming }
GtExtractTestFromSnippetRefactoring >> modifyMovedMethods [
	movedSelector isUnary
		ifFalse: [ ^ self refactoringError: 'Test methods cannot have arguments.' ].
	(movedSelector beginsWith: 'test')
		ifFalse: [ ^ GtRefactoringNotification signal: 'Test methods should begin with "test".' ]
]
