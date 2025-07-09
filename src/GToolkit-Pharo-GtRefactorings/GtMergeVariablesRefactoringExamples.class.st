Class {
	#name : #GtMergeVariablesRefactoringExamples,
	#superclass : #Object,
	#instVars : [
		'ivar1'
	],
	#category : #'GToolkit-Pharo-GtRefactorings-Examples'
}

{ #category : #private }
GtMergeVariablesRefactoringExamples >> intervalFor: from in: selector [
	| ast |
	ast := (self class >> selector) ast.
	ast
		nodesDo: [ :each | (each isVariable and: [ each name = from ]) ifTrue: [ ^ each sourceInterval ] ].
	self error: 'Variable not found'
]

{ #category : #examples }
GtMergeVariablesRefactoringExamples >> invalidFromVariable [
	<gtExample>
	| model refactoring |
	model := GtRBNamespace new.
	refactoring := GtMergeVariablesRefactoring
			model: model
			mergeVariableFrom: (1 to: 3)
			into: (self intervalFor: 'b' in: #testMethod1)
			from: #testMethod1
			in: self class.
	[ refactoring primitiveExecute ]
		on: RBRefactoringError
		do: [ :ex | ^ ex freeze ].
	self assert: false description: 'Refactoring should have thrown an error'
]

{ #category : #examples }
GtMergeVariablesRefactoringExamples >> invalidToVariable [
	<gtExample>
	| model refactoring |
	model := GtRBNamespace new.
	refactoring := GtMergeVariablesRefactoring
			model: model
			mergeVariableFrom: (self intervalFor: 'b' in: #testMethod1)
			into: (1 to: 3)
			from: #testMethod1
			in: self class.
	[ refactoring primitiveExecute ]
		on: RBRefactoringError
		do: [ :ex | ^ ex freeze ].
	self assert: false description: 'Refactoring should have thrown an error'
]

{ #category : #examples }
GtMergeVariablesRefactoringExamples >> ivarShouldThrowError [
	<gtExample>
	| temp1 |
	temp1 := ivar1.
	^ self
		merge: 'temp1'
		into: 'ivar1'
		in: thisContext selector
]

{ #category : #private }
GtMergeVariablesRefactoringExamples >> merge: from into: to in: selector [
	| model refactoring newAst expectedAst shouldFail resultSelector |
	model := GtRBNamespace new.
	refactoring := GtMergeVariablesRefactoring
			model: model
			mergeVariableFrom: (self intervalFor: from in: selector)
			into: (self intervalFor: to in: selector)
			from: selector
			in: self class.
	resultSelector := selector numArgs > 0
			ifTrue: [ (selector allButLast , 'Result:') asSymbol ]
			ifFalse: [ (selector , 'Result') asSymbol ].
	shouldFail := (self class includesSelector: resultSelector) not.
	[ refactoring primitiveExecute ]
		on: Error, RBRefactoringWarning
		do: [ :ex | 
			self assert: shouldFail.
			^ ex messageText ].
	self
		assert: shouldFail not
		description: 'Refactoring should have thrown an error'.
	newAst := (model classFor: self class) parseTreeForSelector: selector.
	expectedAst := RBParser
			parseMethod: ((self class sourceCodeAt: resultSelector)
					copyReplaceAll: resultSelector
					with: selector).
	self assert: newAst equals: expectedAst.
	^ newAst
]

{ #category : #examples }
GtMergeVariablesRefactoringExamples >> notInSameScope [
	<gtExample>
	| temp1 |
	temp1 := 42.
	[ | temp2 |
	temp2 := temp1.
	temp2 ] value.
	^ self
		merge: 'temp1'
		into: 'temp2'
		in: thisContext selector
]

{ #category : #examples }
GtMergeVariablesRefactoringExamples >> tempHasLargerScopeThanBlock [
	<gtExample>
	| temp1 |
	[ :temp2 | temp1 := temp2 ] value: 42.
	temp1 printString.
	^ self
		merge: 'temp1'
		into: 'temp2'
		in: thisContext selector
]

{ #category : #'sample methods' }
GtMergeVariablesRefactoringExamples >> testAliasToBlockDefinedInInnerScope [
	| blocks a |
	blocks := (1 to: 5)
			collect: [ :i | 
				a := i.
				[ a ] ].
	^ blocks collect: #value
]

{ #category : #'sample methods' }
GtMergeVariablesRefactoringExamples >> testAssignmentInBlock [
	| a b block |
	block := [ a := 42 ].
	b := a.
	block value.
	^ b
]

{ #category : #'sample methods' }
GtMergeVariablesRefactoringExamples >> testBlockArg [
	^ [ :a | 
	| b |
	b := a.
	b ]
]

{ #category : #'sample methods' }
GtMergeVariablesRefactoringExamples >> testBlockArgResult [
	^ [ :a | a ]
]

{ #category : #'sample methods' }
GtMergeVariablesRefactoringExamples >> testMethod1 [
	| a b |
	a := 42.
	b := a.
	^ b
]

{ #category : #'sample methods' }
GtMergeVariablesRefactoringExamples >> testMethod1Result [
	| a |
	a := 42.
	^ a
]

{ #category : #'sample methods' }
GtMergeVariablesRefactoringExamples >> testMethod2 [
	| a b |
	a := 42.
	b := a.
	^ b
]

{ #category : #'sample methods' }
GtMergeVariablesRefactoringExamples >> testMethod2Result [
	| b |
	b := 42.
	^ b
]

{ #category : #'sample methods' }
GtMergeVariablesRefactoringExamples >> testMethod3 [
	| a b |
	a := 42.
	a odd ifTrue: [ b := a ].
	^ b
]

{ #category : #'sample methods' }
GtMergeVariablesRefactoringExamples >> testMethodArg: a [
	| b |
	b := a.
	^ b
]

{ #category : #'sample methods' }
GtMergeVariablesRefactoringExamples >> testMethodArgResult: b [
	^ b
]

{ #category : #examples }
GtMergeVariablesRefactoringExamples >> testMethodExamples [
	<gtExample>
	^ #(
		#(testBlockArg 'b' 'a')
		#(testMethodArg: 'a' 'b')
		#(testMethod1 'b' 'a') 
		#(testMethod2 'a' 'b') 
		#(testMethod3 'b' 'a') 
		#(testMethod3 'a' 'b')
		#(testReassignedMethod 'a' 'b')
		#(testAliasToBlockDefinedInInnerScope 'a' 'i')
		#(testAssignmentInBlock 'a' 'b')
	)
		collect: [ :each | 
			self
				merge: each second
				into: each third
				in: each first ]
]

{ #category : #'sample methods' }
GtMergeVariablesRefactoringExamples >> testReassignedMethod [
	| a b |
	a := 42.
	b := a.
	a := 43.
	^ b
]
