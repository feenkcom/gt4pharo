Class {
	#name : #GtPP2CreateParserRefactoring,
	#superclass : #RBRefactoring,
	#instVars : [
		'source',
		'className',
		'category',
		'ast'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Rename'
}

{ #category : #'instance creation' }
GtPP2CreateParserRefactoring class >> model: aRBNamespace className: aSymbol category: packageName source: aString [
	^ self new
		model: aRBNamespace;
		className: aSymbol;
		category: packageName;
		source: aString;
		yourself
]

{ #category : #transforming }
GtPP2CreateParserRefactoring >> addMethods [
	ast statements do: [ :each | self compileProduction: each ]
]

{ #category : #accessing }
GtPP2CreateParserRefactoring >> category [
	^ category
]

{ #category : #accessing }
GtPP2CreateParserRefactoring >> category: anObject [
	category := anObject
]

{ #category : #accessing }
GtPP2CreateParserRefactoring >> className [
	^ className
]

{ #category : #accessing }
GtPP2CreateParserRefactoring >> className: aSymbol [
	className := aSymbol
]

{ #category : #transforming }
GtPP2CreateParserRefactoring >> compileProduction: each [
	| method |
	method := '<1s><n><t>^ <2s>'
			expandMacrosWith: each variable name
			with: each value formattedCode.
	self ppClass
		compile: (RBParser parseMethod: method) formattedCode
		classified: #grammar
]

{ #category : #transforming }
GtPP2CreateParserRefactoring >> createAst [
	ast := RBParser parseExpression: source.
	ast statements isEmpty
		ifTrue: [ self refactoringFailure: 'Cannot find production' ].
	(ast statements allSatisfy: [ :each | each isAssignment ])
		ifFalse: [ self refactoringFailure: 'All statements are not assignments' ]
]

{ #category : #transforming }
GtPP2CreateParserRefactoring >> createParserClass [
	| variables |
	variables := ast statements collect: [ :each | each variable name ].
	self model
		defineClass: ('PP2CompositeNode subclass: #<1s> instanceVariableNames: ''<2s>'' classVariableNames: '''' poolDictionaries: '''' category: <3p>'
				expandMacrosWith: className
				with: (' ' join: variables)
				with: category)
]

{ #category : #transforming }
GtPP2CreateParserRefactoring >> createStartMethod [
	self ppClass
		compile: ('start<n><t>^ <1s>' expandMacrosWith: ast statements last variable name)
		classified: #accessing
]

{ #category : #transforming }
GtPP2CreateParserRefactoring >> ppClass [
	^ self model classNamed: className
]

{ #category : #preconditions }
GtPP2CreateParserRefactoring >> preconditions [
	^ (RBCondition
		withBlock: [ (RBScanner isVariable: className) and: [ className first isLowercase not ] ]
		errorString: className , ' is not a valid class name')
		& (RBCondition isGlobal: className in: self model) not
]

{ #category : #accessing }
GtPP2CreateParserRefactoring >> source [
	^ source
]

{ #category : #accessing }
GtPP2CreateParserRefactoring >> source: aString [
	source := aString
]

{ #category : #transforming }
GtPP2CreateParserRefactoring >> transform [
	self createAst.
	self createParserClass.
	self addMethods.
	self createStartMethod
]
