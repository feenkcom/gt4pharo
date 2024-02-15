Class {
	#name : #GtExtractExampleFromSnippetRefactoring,
	#superclass : #GtExtractMethodFromSnippetRefactoring,
	#instVars : [
		'exampleClassName',
		'category'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Extract method'
}

{ #category : #accessing }
GtExtractExampleFromSnippetRefactoring class >> extract: anInterval from: aString into: exampleClassName category: aSymbol [
	^ (self extract: anInterval from: aString)
		exampleClassName: exampleClassName;
		category: aSymbol;
		yourself
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
GtExtractExampleFromSnippetRefactoring >> exampleClassName [
	^ exampleClassName
]

{ #category : #accessing }
GtExtractExampleFromSnippetRefactoring >> exampleClassName: anObject [
	exampleClassName := anObject
]

{ #category : #accessing }
GtExtractExampleFromSnippetRefactoring >> moveMethod [
	super moveMethod.
	moveToClasses
		do: [ :cls | 
			| ast |
			ast := (cls methodFor: movedSelector) ast.
			ast addPragma: (RBPragmaNode selector: #gtExample arguments: #()).
			cls compile: ast formattedCode ]
]

{ #category : #accessing }
GtExtractExampleFromSnippetRefactoring >> shouldKeepChange: aRBChangeObject [
	^ (aRBChangeObject isKindOf: RBAddClassChange)
		or: [ super shouldKeepChange: aRBChangeObject ]
]

{ #category : #accessing }
GtExtractExampleFromSnippetRefactoring >> transform [
	(self model classNamed: exampleClassName)
		ifNil: [ (category isNil or: [ category isEmpty ])
				ifTrue: [ self refactoringError: 'No package specified for new class' ].
			self
				performCompositeRefactoring: (RBAddClassRefactoring
						model: model
						addClass: exampleClassName
						superclass: Object
						subclasses: #()
						category: category) ].
	^ super transform
]
