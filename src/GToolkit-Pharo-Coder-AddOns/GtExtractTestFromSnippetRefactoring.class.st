Class {
	#name : #GtExtractTestFromSnippetRefactoring,
	#superclass : #GtExtractExampleFromSnippetToClassRefactoring,
	#classInstVars : [
		'defaultTestCaseSuperclass'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-Extract method'
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
GtExtractTestFromSnippetRefactoring >> addSnippetRewritesTo: rewriter [
	rewriter
		replace: '`{:node | node isMessage and: [node selector = #' , newExtractedSelector
				, ' and: [node receiver isSelfVariable]]}'
		with: className , ' run: #' , newExtractedSelector
]

{ #category : #transforming }
GtExtractTestFromSnippetRefactoring >> defaultSuperclass [
	^ model classNamed: self class defaultTestCaseSuperclass
]

{ #category : #transforming }
GtExtractTestFromSnippetRefactoring >> finishRefactoring [
	newExtractedSelector isUnary
		ifFalse: [ ^ self refactoringError: 'Test methods cannot have arguments.' ].
	(newExtractedSelector beginsWith: 'test')
		ifFalse: [ ^ GtRefactoringNotification signal: 'Test methods should begin with "test".' ]
]

{ #category : #accessing }
GtExtractTestFromSnippetRefactoring >> gtDescription [
	^ 'Extract test method from snippet'
]
