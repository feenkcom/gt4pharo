Class {
	#name : #GtExtractToWrappedMethodObjectRefactoringExamples,
	#superclass : #Object,
	#instVars : [
		'model'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Examples'
}

{ #category : #examples }
GtExtractToWrappedMethodObjectRefactoringExamples >> extractWithNoArgConstructor [
	<gtExample>
	| refactoring cls |
	refactoring := self refactoringFor: #writeOn:.
	refactoring primitiveExecute.
	cls := model classNamed: #NewClass.
	self assert: (cls directlyDefinesMethod: #writeOn:).
	self
		assert: (cls parseTreeForSelector: #writeOn:)
				= (RBParser
						parseMethod: 'writeOn: aStream aStream nextPutAll: ''a''; nextPutAll: ''b''').
	self
		assert: ((model classFor: self class) parseTreeForSelector: #writeOn:)
				= (RBParser parseMethod: 'writeOn: aStream aStream writeOn: NewClass new').
	^ model
]

{ #category : #examples }
GtExtractToWrappedMethodObjectRefactoringExamples >> extractWithOneArgConstructor [
	<gtExample>
	| refactoring cls |
	refactoring := self refactoringFor: #writeOn1:.
	refactoring
		setOption: #constructorMethodName
		toUse: [ :methodName :ref | 
			methodName selector: #a:.
			methodName ].
	refactoring primitiveExecute.
	cls := model classNamed: #NewClass.
	self assert: (cls directlyDefinesMethod: #writeOn:).
	self
		assert: (cls parseTreeForSelector: #writeOn:)
		equals: (RBParser
				parseMethod: 'writeOn: aStream aStream nextPutAll: a; nextPutAll: ''b''').
	self assert: (cls directlyDefinesMethod: #setA:).
	self assert: (cls classSide directlyDefinesMethod: #a:).
	self
		assert: ((model classFor: self class) parseTreeForSelector: #writeOn1:)
		equals: (RBParser
				parseMethod: 'writeOn1: aStream | a | a := ''a''. aStream writeOn: (NewClass a: a)').
	^ model
]

{ #category : #examples }
GtExtractToWrappedMethodObjectRefactoringExamples >> extractWithTwoArgConstructor [
	<gtExample>
	| refactoring cls |
	refactoring := self refactoringFor: #writeOn2:.
	refactoring
		setOption: #constructorMethodName
		toUse: [ :methodName :ref | 
			methodName selector: #a:b:.
			methodName arguments: methodName arguments asSortedCollection reversed.
			methodName ].
	refactoring primitiveExecute.
	cls := model classNamed: #NewClass.
	self assert: (cls directlyDefinesMethod: #writeOn:).
	self
		assert: (cls parseTreeForSelector: #writeOn:)
		equals: (RBParser parseMethod: 'writeOn: aStream aStream nextPutAll: a; nextPutAll: b').
	self assert: (cls directlyDefinesMethod: #setA:b:).
	self assert: (cls classSide directlyDefinesMethod: #a:b:).
	self
		assert: ((model classFor: self class) parseTreeForSelector: #writeOn2:)
		equals: (RBParser
				parseMethod: 'writeOn2: aStream | a b | a := ''a''. b := ''b''. aStream writeOn: (NewClass a: b b: a)').
	^ model
]

{ #category : #initialization }
GtExtractToWrappedMethodObjectRefactoringExamples >> initialize [
	super initialize.
	model := GtRBNamespace new
]

{ #category : #'as yet unclassified' }
GtExtractToWrappedMethodObjectRefactoringExamples >> refactoring [
	^ GtExtractToWrappedMethodObjectRefactoring new
		model: model;
		className: #NewClass;
		superclass: #Object;
		category: 'Test';
		setOption: #wrappedReceiver
			toUse: [ :receivers :ref | receivers detect: [ :each | each = 'aStream' ] ];
		setOption: #wrappedMethodName
			toUse: [ :methodName :ref | 
				methodName selector: #writeOn:.
				methodName ];
		setOption: #selectVariableToMoveTo toUse: [ :ref :cls :sel | 'aStream' ];
		yourself
]

{ #category : #'as yet unclassified' }
GtExtractToWrappedMethodObjectRefactoringExamples >> refactoringFor: aSelector [
	| class ast |
	class := model classFor: self class.
	ast := class parseTreeForSelector: aSelector.
	^ GtExtractToWrappedMethodObjectRefactoring new
		model: model;
		extract: ast body statements last sourceInterval
			from: aSelector
			in: class;
		className: #NewClass;
		superclass: #Object;
		category: #Test;
		setOption: #methodName
			toUse: [ :methodName :ref | 
				methodName selector: #writeOn:.
				methodName ];
		setOption: #variablesToMove
			toUse: [ :potential :ref | potential copyWithout: 'aStream' ];
		setOption: #newVariableName toUse: [ :oldName :ref | oldName ];
		setOption: #wrappedReceiver
			toUse: [ :receivers :ref | receivers detect: [ :each | each = 'aStream' ] ];
		setOption: #wrappedMethodName
			toUse: [ :methodName :ref | 
				methodName selector: #writeOn:.
				methodName ];
		setOption: #selectVariableToMoveTo toUse: [ :ref :cls :sel | 'aStream' ];
		yourself
]

{ #category : #'sample methods' }
GtExtractToWrappedMethodObjectRefactoringExamples >> writeOn1: aStream [
	| a |
	a := 'a'.
	aStream
		nextPutAll: a;
		nextPutAll: 'b'
]

{ #category : #'sample methods' }
GtExtractToWrappedMethodObjectRefactoringExamples >> writeOn2: aStream [
	| a b |
	a := 'a'.
	b := 'b'.
	aStream
		nextPutAll: a;
		nextPutAll: b
]

{ #category : #'sample methods' }
GtExtractToWrappedMethodObjectRefactoringExamples >> writeOn: aStream [
	aStream
		nextPutAll: 'a';
		nextPutAll: 'b'
]
