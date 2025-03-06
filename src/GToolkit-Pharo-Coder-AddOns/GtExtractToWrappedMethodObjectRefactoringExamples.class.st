Class {
	#name : #GtExtractToWrappedMethodObjectRefactoringExamples,
	#superclass : #Object,
	#instVars : [
		'model',
		'testVar'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Examples'
}

{ #category : #examples }
GtExtractToWrappedMethodObjectRefactoringExamples >> extractWithIVarRef [
	<gtExample>
	| refactoring cls |
	refactoring := self refactoringFor: #writeOnVar:.
	refactoring
		setOption: #constructorMethodName
		toUse: [ :methodName :ref | 
			methodName selector: #var:.
			methodName ].
	refactoring primitiveExecute.
	cls := model classNamed: #NewClass.
	self assert: (cls directlyDefinesMethod: #writeOn:).
	self assert: (cls protocolsFor: #writeOn:) asArray equals: #(#writing).
	self
		assert: (cls parseTreeForSelector: #writeOn:)
		equals: (RBParser
				parseMethod: 'writeOn: aStream aStream nextPutAll: ''a''; nextPutAll:  testVar').
	self assert: (cls directlyDefinesMethod: #setVar:).
	self
		assert: ((cls parseTreeForSelector: #setVar:)
				equalTo: (RBParser parseMethod: 'setVar: aTestVar  testVar := aTestVar')
				exceptForVariables: #()).
	self assert: (cls protocolsFor: #setVar:) asArray equals: #(#private).
	self assert: (cls classSide directlyDefinesMethod: #var:).
	self
		assert: (cls classSide protocolsFor: #var:) asArray
		equals: #(#'instance creation').
	self
		assert: ((cls classSide parseTreeForSelector: #var:)
				equalTo: (RBParser parseMethod: 'var: aTestVar ^self new setVar: aTestVar; yourself')
				exceptForVariables: #()).
	self
		assert: ((model classFor: self class) parseTreeForSelector: #writeOnVar:)
		equals: (RBParser
				parseMethod: 'writeOnVar: aStream aStream writeOn: (NewClass var: testVar)').
	^ model
]

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
	self assert: (cls protocolsFor: #writeOn:) asArray equals: #(#writing).
	self
		assert: (cls parseTreeForSelector: #writeOn:)
		equals: (RBParser
				parseMethod: 'writeOn: aStream aStream nextPutAll: a; nextPutAll: ''b''').
	self assert: (cls directlyDefinesMethod: #setA:).
	self assert: (cls protocolsFor: #setA:) asArray equals: #(#private).
	self
		assert: ((cls parseTreeForSelector: #setA:)
				equalTo: (RBParser parseMethod: 'setA: anA  a := anA')
				exceptForVariables: #()).
	self assert: (cls classSide directlyDefinesMethod: #a:).
	self
		assert: (cls classSide protocolsFor: #a:) asArray
		equals: #(#'instance creation').
	self
		assert: ((cls classSide parseTreeForSelector: #a:)
				equalTo: (RBParser parseMethod: 'a: anA  ^self new setA: anA; yourself')
				exceptForVariables: #()).
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
	self assert: (cls protocolsFor: #writeOn:) asArray equals: #(#writing).
	self
		assert: (cls parseTreeForSelector: #writeOn:)
		equals: (RBParser parseMethod: 'writeOn: aStream aStream nextPutAll: a; nextPutAll: b').
	self assert: (cls directlyDefinesMethod: #setA:b:).
	self
		assert: (((cls parseTreeForSelector: #setA:b:)
				equalTo: (RBParser parseMethod: 'setA: aB b: anA  a := anA. b := aB')
				exceptForVariables: #())
				or: [ (cls parseTreeForSelector: #setA:b:)
						equalTo: (RBParser parseMethod: 'setA: aB b: anA  b := aB. a := anA')
						exceptForVariables: #() ]).
	self assert: (cls protocolsFor: #setA:b:) asArray equals: #(#private).
	self assert: (cls classSide directlyDefinesMethod: #a:b:).
	self
		assert: (cls classSide protocolsFor: #a:b:) asArray
		equals: #(#'instance creation').
	self
		assert: ((cls classSide parseTreeForSelector: #a:b:)
				equalTo: (RBParser parseMethod: 'a: aB  b: anA ^self new setA: aB b: anA; yourself')
				exceptForVariables: #()).
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
		setOption: #methodProtocol toUse: [ :sel :ref | #writing ];
		setOption: #selfArgumentName toUse: [ :ref | 'a' , self class name ];
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

{ #category : #'sample methods' }
GtExtractToWrappedMethodObjectRefactoringExamples >> writeOnVar: aStream [
	aStream
		nextPutAll: 'a';
		nextPutAll: testVar
]
