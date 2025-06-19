Class {
	#name : #GtExtractExampleFromSnippetToClassRefactoring,
	#superclass : #GtExtractMethodFromInspectorRefactoring,
	#instVars : [
		'category',
		'className'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Extract method'
}

{ #category : #accessing }
GtExtractExampleFromSnippetToClassRefactoring class >> extract: anInterval from: aString into: exampleClassName category: aSymbol [
	^ self new
		extract: anInterval from: aString;
		className: exampleClassName;
		category: aSymbol;
		yourself
]

{ #category : #accessing }
GtExtractExampleFromSnippetToClassRefactoring >> addSnippetRewritesTo: rewriter [
	rewriter
		replace: 'self `{:node | node parent isMessage and: [node parent selector = #'
				, newExtractedSelector , ']}'
		with: className , ' new'
]

{ #category : #accessing }
GtExtractExampleFromSnippetToClassRefactoring >> buildNewSnippetSource [
	| ast rewriter |
	ast := (class methodFor: snippetSelector) ast body.
	rewriter := RBParseTreeRewriter new.
	self addSnippetRewritesTo: rewriter.
	(rewriter executeTree: ast) ifTrue: [ ast := rewriter tree ].
	ast temporaryNames do: [ :each | ast removeTemporaryNamed: each ].
	returnPosition
		ifNotNil: [ (ast isSequence and: [ ast statements last isReturn ])
				ifTrue: [ ast statements last replaceWith: ast statements last value copy ] ].
	snippetSource := ast formattedCode
]

{ #category : #accessing }
GtExtractExampleFromSnippetToClassRefactoring >> category [
	^ category
]

{ #category : #accessing }
GtExtractExampleFromSnippetToClassRefactoring >> category: anObject [
	category := anObject
]

{ #category : #accessing }
GtExtractExampleFromSnippetToClassRefactoring >> className [
	^ className
]

{ #category : #accessing }
GtExtractExampleFromSnippetToClassRefactoring >> className: anObject [
	className := anObject
]

{ #category : #transforming }
GtExtractExampleFromSnippetToClassRefactoring >> createNewClassIfNecessary [
	(self model classNamed: className)
		ifNil: [ (category isNil or: [ category isEmpty ])
				ifTrue: [ self refactoringError: 'No package specified for new class' ].
			self
				performCompositeRefactoring: (RBAddClassRefactoring
						model: model
						addClass: className
						superclass: self defaultSuperclass
						subclasses: #()
						category: category) ]
]

{ #category : #transforming }
GtExtractExampleFromSnippetToClassRefactoring >> defaultSuperclass [
	^ Object
]

{ #category : #initialization }
GtExtractExampleFromSnippetToClassRefactoring >> extract: anInterval from: aString [
	source := aString.
	originalInterval := anInterval
]

{ #category : #transforming }
GtExtractExampleFromSnippetToClassRefactoring >> finishRefactoring [
	| ast |
	newExtractedSelector isUnary
		ifFalse: [ ^ GtRefactoringNotification
				signal: 'Example methods should not have arguments' ].
	ast := (class methodFor: newExtractedSelector) ast.
	ast addPragma: (RBPragmaNode selector: #gtExample arguments: #()).
	class compile: ast formattedCode.
	self replaceSelfReferences
]

{ #category : #accessing }
GtExtractExampleFromSnippetToClassRefactoring >> gtDescription [
	^ 'Extract example method from snippet'
]

{ #category : #accessing }
GtExtractExampleFromSnippetToClassRefactoring >> preconditions [
	self createNewClassIfNecessary.
	class := self model classNamed: className.
	^ super preconditions
]

{ #category : #transforming }
GtExtractExampleFromSnippetToClassRefactoring >> privateTransform [
	self createNewClassIfNecessary.
	super transform.
	self finishRefactoring.
	self gtCleanupChanges
]

{ #category : #transforming }
GtExtractExampleFromSnippetToClassRefactoring >> replaceSelfReferences [
	| ast rewriter |
	ast := (class methodFor: newExtractedSelector) ast.
	rewriter := RBParseTreeRewriter new.
	rewriter replace: className , ' new' with: 'self'.
	(rewriter executeTree: ast)
		ifTrue: [ class compile: rewriter tree formattedCode ]
]

{ #category : #testing }
GtExtractExampleFromSnippetToClassRefactoring >> shouldKeepChange: aRBChangeObject [
	^ (aRBChangeObject isKindOf: RBAddClassChange)
		or: [ super shouldKeepChange: aRBChangeObject ]
]

{ #category : #transforming }
GtExtractExampleFromSnippetToClassRefactoring >> transform [
	self createNewClassIfNecessary.
	super transform.
	self finishRefactoring.
	self gtCleanupChanges
]
