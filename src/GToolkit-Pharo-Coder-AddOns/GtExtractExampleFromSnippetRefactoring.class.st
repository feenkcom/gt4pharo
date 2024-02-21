Class {
	#name : #GtExtractExampleFromSnippetRefactoring,
	#superclass : #GtExtractMethodFromInspectorRefactoring,
	#instVars : [
		'category',
		'className'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Extract method'
}

{ #category : #accessing }
GtExtractExampleFromSnippetRefactoring class >> extract: anInterval from: aString into: exampleClassName category: aSymbol [
	^ self new
		extract: anInterval from: aString;
		className: exampleClassName;
		category: aSymbol;
		yourself
]

{ #category : #accessing }
GtExtractExampleFromSnippetRefactoring >> addSnippetRewritesTo: rewriter [
	rewriter
		replace: 'self `{:node | node parent isMessage and: [node parent selector = #'
				, newExtractedSelector , ']}'
		with: className , ' new'
]

{ #category : #accessing }
GtExtractExampleFromSnippetRefactoring >> buildNewSnippetSource [
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
GtExtractExampleFromSnippetRefactoring >> category [
	^ category
]

{ #category : #accessing }
GtExtractExampleFromSnippetRefactoring >> category: anObject [
	category := anObject
]

{ #category : #accessing }
GtExtractExampleFromSnippetRefactoring >> className [
	^ className
]

{ #category : #accessing }
GtExtractExampleFromSnippetRefactoring >> className: anObject [
	className := anObject
]

{ #category : #transforming }
GtExtractExampleFromSnippetRefactoring >> createNewClassIfNecessary [
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
GtExtractExampleFromSnippetRefactoring >> defaultSuperclass [
	^ Object
]

{ #category : #initialization }
GtExtractExampleFromSnippetRefactoring >> extract: anInterval from: aString [
	source := aString.
	originalInterval := anInterval
]

{ #category : #transforming }
GtExtractExampleFromSnippetRefactoring >> finishRefactoring [
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
GtExtractExampleFromSnippetRefactoring >> preconditions [
	self createNewClassIfNecessary.
	class := self model classNamed: className.
	^ super preconditions
]

{ #category : #transforming }
GtExtractExampleFromSnippetRefactoring >> replaceSelfReferences [
	| ast rewriter |
	ast := (class methodFor: newExtractedSelector) ast.
	rewriter := RBParseTreeRewriter new.
	rewriter replace: className , ' new' with: 'self'.
	(rewriter executeTree: ast)
		ifTrue: [ class compile: rewriter tree formattedCode ]
]

{ #category : #testing }
GtExtractExampleFromSnippetRefactoring >> shouldKeepChange: aRBChangeObject [
	^ (aRBChangeObject isKindOf: RBAddClassChange)
		or: [ super shouldKeepChange: aRBChangeObject ]
]

{ #category : #transforming }
GtExtractExampleFromSnippetRefactoring >> transform [
	self createNewClassIfNecessary.
	super transform.
	self finishRefactoring.
	self gtCleanupChanges
]
