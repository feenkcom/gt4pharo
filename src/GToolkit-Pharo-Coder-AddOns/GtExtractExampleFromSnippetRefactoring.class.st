Class {
	#name : #GtExtractExampleFromSnippetRefactoring,
	#superclass : #GtExtractMethodFromSnippetRefactoring,
	#instVars : [
		'category',
		'className'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Extract method'
}

{ #category : #accessing }
GtExtractExampleFromSnippetRefactoring class >> extract: anInterval from: aString into: exampleClassName category: aSymbol [
	^ (self extract: anInterval from: aString)
		className: exampleClassName;
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

{ #category : #transforming }
GtExtractExampleFromSnippetRefactoring >> modifyMovedMethods [
	movedSelector isUnary
		ifFalse: [ ^ GtRefactoringNotification
				signal: 'Example methods should not have arguments' ].
	moveToClasses
		do: [ :cls | 
			| ast |
			ast := (cls methodFor: movedSelector) ast.
			ast addPragma: (RBPragmaNode selector: #gtExample arguments: #()).
			cls compile: ast formattedCode ]
]

{ #category : #transforming }
GtExtractExampleFromSnippetRefactoring >> moveMethod [
	super moveMethod.
	self modifyMovedMethods
]

{ #category : #testing }
GtExtractExampleFromSnippetRefactoring >> shouldKeepChange: aRBChangeObject [
	^ (aRBChangeObject isKindOf: RBAddClassChange)
		or: [ super shouldKeepChange: aRBChangeObject ]
]

{ #category : #transforming }
GtExtractExampleFromSnippetRefactoring >> transform [
	self createNewClassIfNecessary.
	^ super transform
]
