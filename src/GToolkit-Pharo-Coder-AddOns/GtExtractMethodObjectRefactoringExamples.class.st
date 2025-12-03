Class {
	#name : #GtExtractMethodObjectRefactoringExamples,
	#superclass : #Object,
	#instVars : [
		'test1',
		'test2'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-Examples'
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
GtExtractMethodObjectRefactoringExamples >> methodObjectForTestMethodReadsIVars [
	<gtExample>
	| model selector cls refactoring |
	selector := #testMethodReadsIVars.
	refactoring := self refactoringForExtracting: selector.
	refactoring setOption: #splitVariableLifetimes toUse: [ true ].
	refactoring primitiveExecute.
	model := refactoring model.
	cls := model classNamed: #NewClass.
	self assert: (cls directlyDefinesMethod: #z).
	self
		assert: (cls parseTreeForSelector: #z)
		equals: (RBParser
				parseMethod: 'z 
						self test1 printString < self test2 printString ifTrue: [ ^ -1 ].
						^ self test1 printString = self test2 printString ifTrue: [ 0 ] ifFalse: [ 1 ]').
	self
		assert: ((model classFor: self class) parseTreeForSelector: selector)
		equals: (RBParser
				parseMethod: 'testMethodReadsIVars
					^NewClass new test1: test1; test2: test2; z').
	^ model
]

{ #category : #examples }
GtExtractMethodObjectRefactoringExamples >> methodObjectForTestMethodReadsIVarsDoNotSplit [
	<gtExample>
	| model selector cls refactoring |
	selector := #testMethodReadsIVars.
	refactoring := self refactoringForExtracting: selector.
	refactoring setOption: #splitVariableLifetimes toUse: [ false ].
	refactoring primitiveExecute.
	model := refactoring model.
	cls := model classNamed: #NewClass.
	self assert: (cls directlyDefinesMethod: #z).
	self
		assert: (cls parseTreeForSelector: #z)
		equals: (RBParser
				parseMethod: 'z 
						self myself test1 printString < self myself test2 printString ifTrue: [ ^ -1 ].
						^ self myself test1 printString = self myself test2 printString ifTrue: [ 0 ] ifFalse: [ 1 ]').
	self
		assert: ((model classFor: self class) parseTreeForSelector: selector)
		equals: (RBParser
				parseMethod: 'testMethodReadsIVars
					^NewClass new myself: self; z').
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

{ #category : #examples }
GtExtractMethodObjectRefactoringExamples >> methodObjectForTestMethodWritesIVars [
	<gtExample>
	| model selector cls refactoring |
	selector := #testMethodWritesIVars.
	refactoring := self refactoringForExtracting: selector.
	refactoring setOption: #splitVariableLifetimes toUse: [ true ].
	refactoring primitiveExecute.
	model := refactoring model.
	cls := model classNamed: #NewClass.
	self assert: (cls directlyDefinesMethod: #z).
	self
		assert: (cls parseTreeForSelector: #z)
		equals: (RBParser
				parseMethod: 'z 
						self myself test1: self test2').
	self
		assert: ((model classFor: self class) parseTreeForSelector: selector)
		equals: (RBParser
				parseMethod: 'testMethodWritesIVars
					NewClass new myself: self; test2: test2; z').
	^ model
]

{ #category : #private }
GtExtractMethodObjectRefactoringExamples >> modelFromExtracting: selector [
	| refactoring |
	refactoring := self refactoringForExtracting: selector.
	refactoring primitiveExecute.
	^ refactoring model
]

{ #category : #private }
GtExtractMethodObjectRefactoringExamples >> refactoringForExtracting: selector [
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
	^ refactoring
]

{ #category : #samples }
GtExtractMethodObjectRefactoringExamples >> testMethod [
	self printString size > 10 ifTrue: [^self].
	Transcript print: test1
]

{ #category : #samples }
GtExtractMethodObjectRefactoringExamples >> testMethodReadsIVars [
	test1 printString < test2 printString ifTrue: [ ^ -1 ].
	^ test1 printString = test2 printString ifTrue: [ 0 ] ifFalse: [ 1 ]
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

{ #category : #samples }
GtExtractMethodObjectRefactoringExamples >> testMethodWritesIVars [
	test1 := test2
]
