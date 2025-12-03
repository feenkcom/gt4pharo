Class {
	#name : #GtExtractTestFromSnippetToVariableRefactoring,
	#superclass : #GtExtractExampleFromSnippetToVariableRefactoring,
	#category : 'GToolkit-Pharo-Coder-AddOns-Extract method'
}

{ #category : #'as yet unclassified' }
GtExtractTestFromSnippetToVariableRefactoring >> finishRefactoring [
	| testClass |
	movedSelector isUnary
		ifFalse: [ ^ self refactoringError: 'Test methods cannot have arguments.' ].
	testClass := model classNamed: #TestCase.
	(testClass isNil
		or: [ moveToClasses anySatisfy: [ :each | (each includesClass: testClass) not ] ])
		ifTrue: [ GtRefactoringNotification
				signal: 'Test methods should be compiled in subclasses of TestCase.' ].
	(movedSelector beginsWith: 'test')
		ifFalse: [ ^ GtRefactoringNotification signal: 'Test methods should begin with "test".' ]
]

{ #category : #'as yet unclassified' }
GtExtractTestFromSnippetToVariableRefactoring >> gtDescription [
	^ 'Extract test method from snippet'
]
