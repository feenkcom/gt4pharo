Class {
	#name : #GtPharoParserExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Parser-Examples'
}

{ #category : #accessing }
GtPharoParserExamples >> arrayNestingLevel [
	<gtExample>
	| ast |
	ast := GtPharoParser 
		parse: '{1}'
		startingAt: GtPharoParser startingStateForStatement.
	self assert: ast nestingLevel = 1.
	^ ast
]

{ #category : #accessing }
GtPharoParserExamples >> blockInParensNestingLevel [
	<gtExample>
	| ast |
	ast := GtPharoParser 
		parse: '([1])'
		startingAt: GtPharoParser startingStateForStatement.
	self assert: ast nestingLevel = 2.
	^ ast
]

{ #category : #accessing }
GtPharoParserExamples >> blockNestingLevel [
	<gtExample>
	| ast |
	ast := GtPharoParser 
		parse: '[1]'
		startingAt: GtPharoParser startingStateForStatement.
	self assert: ast nestingLevel = 1.
	^ ast
]

{ #category : #accessing }
GtPharoParserExamples >> literalArrayNestingLevel [
	<gtExample>
	| ast |
	ast := GtPharoParser 
		parse: '#(1)'
		startingAt: GtPharoParser startingStateForStatement.
	self assert: ast nestingLevel = 1.
	^ ast
]

{ #category : #accessing }
GtPharoParserExamples >> parensNestingLevel [
	<gtExample>
	| ast |
	ast := GtPharoParser 
		parse: '(1)'
		startingAt: GtPharoParser startingStateForStatement.
	self assert: ast nestingLevel = 1.
	^ ast
]

{ #category : #accessing }
GtPharoParserExamples >> rootNestingLevel [
	<gtExample>
	| ast |
	ast := GtPharoParser 
		parse: '1'
		startingAt: GtPharoParser startingStateForStatement.
	self assert: ast nestingLevel isZero.
	^ ast
]

{ #category : #accessing }
GtPharoParserExamples >> twoParensNestingLevel [
	<gtExample>
	| ast |
	ast := GtPharoParser 
		parse: '((1))'
		startingAt: GtPharoParser startingStateForStatement.
	self assert: ast nestingLevel = 2.
	^ ast
]
