Class {
	#name : #GtExtractLiteralToClassVariableRefactoring,
	#superclass : #RBMethodRefactoring,
	#instVars : [
		'literalInterval',
		'selector',
		'variable',
		'literalNode',
		'getter'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method'
}

{ #category : #'instance creation' }
GtExtractLiteralToClassVariableRefactoring class >> model: model extract: anInterval inMethod: aSelector forClass: aClass [
	^ self new
		model: model;
		extract: anInterval
			inMethod: aSelector
			forClass: aClass;
		yourself
]

{ #category : #transforming }
GtExtractLiteralToClassVariableRefactoring >> addClassVariable [
	self
		performCompositeRefactoring: (RBAddClassVariableRefactoring
				model: model
				variable: variable
				class: class instanceSide)
]

{ #category : #transforming }
GtExtractLiteralToClassVariableRefactoring >> basicTranform [
	self getVariableName.
	self addClassVariable.
	self createAccessors.
	self replaceLiteral
]

{ #category : #preconditions }
GtExtractLiteralToClassVariableRefactoring >> checkLiteralToExtract [
	| method ast |
	method := class methodFor: selector.
	ast := method ast.
	ast
		nodesDo: [ :each | 
			(each isLiteralNode and: [ each sourceInterval = literalInterval ])
				ifTrue: [ each parent isLiteralNode
						ifTrue: [ self refactoringError: 'Cannot extract literal inside of literal array' ].
					^ literalNode := each ] ].
	self refactoringError: 'Cannot find literal node'
]

{ #category : #transforming }
GtExtractLiteralToClassVariableRefactoring >> createAccessors [
	self
		performCompositeRefactoring: (RBAddMethodRefactoring
				model: model
				addMethod: (RBParser
						parseMethod: getter , ' ^ ' , variable , ' ifNil: [' , variable , ' := '
								, literalNode formattedCode , ']') formattedCode
				toClass: class classSide
				inProtocols: #(#accessing)).
	self
		performCompositeRefactoring: (RBAddMethodRefactoring
				model: model
				addMethod: (RBParser
						parseMethod: getter , ': anObject ' , variable , ' := anObject')
						formattedCode
				toClass: class classSide
				inProtocols: #(#accessing))
]

{ #category : #initialization }
GtExtractLiteralToClassVariableRefactoring >> extract: anInterval inMethod: aSelector forClass: aClass [
	literalInterval := anInterval.
	class := model classFor: aClass.
	selector := aSelector
]

{ #category : #transforming }
GtExtractLiteralToClassVariableRefactoring >> getVariableName [
	getter := (self
			requestMethodNameFor: (RBMethodName selector: #_ arguments: #()))
			ifNil: [ self refactoringError: 'Invalid variable name' ]
			ifNotNil: [ :mn | mn selector ].
	variable := getter asString capitalized
]

{ #category : #preconditions }
GtExtractLiteralToClassVariableRefactoring >> preconditions [
	^ (RBCondition definesSelector: selector in: class)
		& (RBCondition
				withBlock: [ self checkLiteralToExtract.
					true ])
]

{ #category : #transforming }
GtExtractLiteralToClassVariableRefactoring >> privateTransform [
	self basicTranform
]

{ #category : #transforming }
GtExtractLiteralToClassVariableRefactoring >> replaceLiteral [
	| replacementNode method ast receiver |
	method := class methodFor: selector.
	ast := method ast.
	receiver := RBVariableNode named: 'self'.
	class isMeta
		ifFalse: [ receiver := RBMessageNode receiver: receiver selector: #class ].
	replacementNode := RBMessageNode receiver: receiver selector: getter.
	ast
		nodesDo: [ :each | 
			(each = literalNode and: [ each sourceInterval = literalNode sourceInterval ])
				ifTrue: [ each replaceWith: replacementNode.
					^ method compileTree: ast ] ].
	self refactoringError: 'Could not find literal node'
]

{ #category : #transforming }
GtExtractLiteralToClassVariableRefactoring >> transform [
	self basicTranform
]
