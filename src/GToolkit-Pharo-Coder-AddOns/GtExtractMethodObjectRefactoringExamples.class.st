Class {
	#name : #GtExtractMethodObjectRefactoringExamples,
	#superclass : #Object,
	#instVars : [
		'test1',
		'test2'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Examples'
}

{ #category : #examples }
GtExtractMethodObjectRefactoringExamples >> methodObjectForTestMethod [
	<gtExample>
	| model selector cls |
	selector := #testMethod.
	model := self modelFromExtracting: selector.
	cls := model classNamed: #NewClass.
	self assert: (cls directlyDefinesMethod: #z).
	self
		assert: (cls parseTreeForSelector: #z)
		equals: (RBParser
				parseMethod: 'z 
					self myself printString size > 10 ifTrue: [^self myself].
					Transcript print: self myself test1.
					^self myself').
	self
		assert: ((model classFor: self class) parseTreeForSelector: selector)
		equals: (RBParser
				parseMethod: 'testMethod
					NewClass new myself: self; z').
	^ model
]

{ #category : #examples }
GtExtractMethodObjectRefactoringExamples >> methodObjectForTestMethodReturnLiteral [
	<gtExample>
	| model selector cls |
	selector := #testMethodReturnLiteral.
	model := self modelFromExtracting: selector.
	cls := model classNamed: #NewClass.
	self assert: (cls directlyDefinesMethod: #z).
	self
		assert: (cls parseTreeForSelector: #z)
		equals: (RBParser
				parseMethod: 'z 
					| col |
					col := Array new: 100 atRandom.
					col size > 10 ifTrue: [ ^ 0 ].
					Transcript print: col.
					^self myself').
	self
		assert: ((model classFor: self class) parseTreeForSelector: selector)
		equals: (RBParser
				parseMethod: 'testMethodReturnLiteral
					^NewClass new myself: self; z').
	^ model
]

{ #category : #examples }
GtExtractMethodObjectRefactoringExamples >> methodObjectForTestMethodReturnSelf [
	<gtExample>
	| model selector cls |
	selector := #testMethodReturnSelf.
	model := self modelFromExtracting: selector.
	cls := model classNamed: #NewClass.
	self assert: (cls directlyDefinesMethod: #z).
	self
		assert: (cls parseTreeForSelector: #z)
		equals: (RBParser
				parseMethod: 'z 
					| col |
					col := Array new: 100 atRandom.
					col size > 10 ifTrue: [ ^ self ].
					Transcript print: col').
	self
		assert: ((model classFor: self class) parseTreeForSelector: selector)
		equals: (RBParser
				parseMethod: 'testMethodReturnSelf
					NewClass new z').
	^ model
]

{ #category : #private }
GtExtractMethodObjectRefactoringExamples >> modelFromExtracting: selector [
	| model ast refactoring |
	ast := self class parseTreeForSelector: selector.
	model := GtRBNamespace new.
	refactoring := GtExtractMethodObjectRefactoring new
			model: model;
			extract: (ast body statements first start to: ast body statements last stop)
				from: selector
				in: (model classFor: self class);
			className: #NewClass;
			superclass: #Object;
			category: self class category;
			setOption: #variablesToMove toUse: [ :potential :ref | potential ];
			setOption: #newVariableName
				toUse: [ :oldName :ref | oldName = 'self' ifTrue: [ 'myself' ] ifFalse: [ oldName ] ];
			setOption: #methodName
				toUse: [ :methodName | 
					methodName
						selector: (('z:' repeat: methodName arguments size) ifEmpty: [ 'z' ]) asSymbol;
						yourself ].
	refactoring primitiveExecute.
	^ model
]

{ #category : #samples }
GtExtractMethodObjectRefactoringExamples >> testMethod [
	self printString size > 10 ifTrue: [^self].
	Transcript print: test1
]

{ #category : #samples }
GtExtractMethodObjectRefactoringExamples >> testMethodReturnLiteral [
	| col |
	col := Array new: 100 atRandom.
	col size > 10 ifTrue: [ ^ 0 ].
	Transcript print: col
]

{ #category : #samples }
GtExtractMethodObjectRefactoringExamples >> testMethodReturnSelf [
	| col |
	col := Array new: 100 atRandom.
	col size > 10 ifTrue: [ ^ self ].
	Transcript print: col
]
