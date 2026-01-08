Class {
	#name : #GtExtractLiteralToClassVariableRefactoring,
	#superclass : #RBMethodRefactoring,
	#instVars : [
		'literalInterval',
		'selector',
		'variable',
		'literalNode',
		'getter',
		'variableClassName'
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
		performCompositeRefactoring: (GtRBAddClassVariableRefactoring
				model: model
				variable: variable
				class: self classForClassVariable instanceSide)
]

{ #category : #transforming }
GtExtractLiteralToClassVariableRefactoring >> basicTranform [
	self getVariableName.
	self addClassVariable.
	self createAccessors.
	self replaceLiteral
]

{ #category : #preconditions }
GtExtractLiteralToClassVariableRefactoring >> checkClassForVariable [
	variableClassName ifNil: [ ^ self ].
	(model classNamed: variableClassName)
		ifNotNil: [ :cls | cls isMeta ifFalse: [ ^ self ] ].
	self refactoringError: 'Invalid class for class variable'
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

{ #category : #preconditions }
GtExtractLiteralToClassVariableRefactoring >> classForClassVariable [
	^ (variableClassName
		ifNil: [ class ]
		ifNotNil: [ model classNamed: variableClassName ]) instanceSide
]

{ #category : #transforming }
GtExtractLiteralToClassVariableRefactoring >> createAccessors [
	self
		performCompositeRefactoring: (GtRBAddMethodRefactoring
				model: model
				addMethod: (RBParser
						parseMethod: getter , ' ^ ' , variable , ' ifNil: [' , variable , ' := '
								, literalNode formattedCode , ']') formattedCode
				toClass: self classForClassVariable classSide
				inProtocols: #(#accessing)).
	self
		performCompositeRefactoring: (GtRBAddMethodRefactoring
				model: model
				addMethod: (RBParser
						parseMethod: getter , ': anObject ' , variable , ' := anObject')
						formattedCode
				toClass: self classForClassVariable classSide
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
					self checkClassForVariable.
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
	variableClassName
		ifNil: [ receiver := RBVariableNode named: 'self'.
			class isMeta
				ifFalse: [ receiver := RBMessageNode receiver: receiver selector: #class ] ]
		ifNotNil: [ receiver := RBVariableNode named: variableClassName ].
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

{ #category : #accessing }
GtExtractLiteralToClassVariableRefactoring >> variableClassName [
	^ variableClassName
]

{ #category : #accessing }
GtExtractLiteralToClassVariableRefactoring >> variableClassName: anObject [
	variableClassName := anObject
]
