Class {
	#name : #GtPharoParserExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Parser-Examples'
}

{ #category : #'examples - nesting level' }
GtPharoParserExamples >> arrayNestingLevel [
	<gtExample>
	| ast |
	ast := GtPharoParser 
		parse: '{1}'
		startingAt: GtPharoParser startingStateForStatement.
	self assert: ast nestingLevel = 1.
	^ ast
]

{ #category : #'examples - nesting level' }
GtPharoParserExamples >> blockInParensNestingLevel [
	<gtExample>
	| ast |
	ast := GtPharoParser 
		parse: '([1])'
		startingAt: GtPharoParser startingStateForStatement.
	self assert: ast nestingLevel = 2.
	^ ast
]

{ #category : #'examples - nesting level' }
GtPharoParserExamples >> blockNestingLevel [
	<gtExample>
	| ast |
	ast := GtPharoParser 
		parse: '[1]'
		startingAt: GtPharoParser startingStateForStatement.
	self assert: ast nestingLevel = 1.
	^ ast
]

{ #category : #'examples - name and keyword' }
GtPharoParserExamples >> failTemplateVariableNode [
	<gtExample>
	
	[ | ast |
	ast := GtPharoParser parse: '{{self printString}}' startingAt: GtPharoParser startingStateForVariable.
	self assert: ast equals: 'Should not get here' ] on: SmaCCParserError do: [ :ex | ^ ex ]
]

{ #category : #'examples - message send' }
GtPharoParserExamples >> invalidReceiverKeywordMessageSend [
	<gtExample>
	| ast |
	
	ast := GtPharoParser
		parseWithErrors: 'printOn:'
		startingAt: GtPharoParser startingStateForKeywordMessageSend.
	
	self assert: ast receiver isErrorNode.
	self assert: ast message selector equals: #printOn:.
	self assert: ast message arguments size equals: 1.
	self assert: ast message arguments first isErrorNode.
	
	^ ast
]

{ #category : #'examples - nesting level' }
GtPharoParserExamples >> literalArrayNestingLevel [
	<gtExample>
	| ast |
	ast := GtPharoParser 
		parse: '#(1)'
		startingAt: GtPharoParser startingStateForStatement.
	self assert: ast nestingLevel = 1.
	^ ast
]

{ #category : #'examples - nesting level' }
GtPharoParserExamples >> parensNestingLevel [
	<gtExample>
	| ast |
	ast := GtPharoParser 
		parse: '(1)'
		startingAt: GtPharoParser startingStateForStatement.
	self assert: ast nestingLevel = 1.
	^ ast
]

{ #category : #'examples - nesting level' }
GtPharoParserExamples >> rootNestingLevel [
	<gtExample>
	| ast |
	ast := GtPharoParser 
		parse: '1'
		startingAt: GtPharoParser startingStateForStatement.
	self assert: ast nestingLevel isZero.
	^ ast
]

{ #category : #'examples - nesting level' }
GtPharoParserExamples >> twoParensNestingLevel [
	<gtExample>
	| ast |
	ast := GtPharoParser 
		parse: '((1))'
		startingAt: GtPharoParser startingStateForStatement.
	self assert: ast nestingLevel = 2.
	^ ast
]

{ #category : #'examples - message send' }
GtPharoParserExamples >> validKeywordMessageSend [
	<gtExample>
	| ast |

	ast := GtPharoParser
		parseWithErrors: '42 printOn: nil'
		startingAt: GtPharoParser startingStateForKeywordMessageSend.
	
	self assert: ast receiver literalValue equals: 42.
	self assert: ast message selector equals: #printOn:.
	self assert: ast message arguments size equals: 1.
	self assert: ast message arguments first literalValue equals: nil.
	
	^ ast
]

{ #category : #'examples - symbol' }
GtPharoParserExamples >> validLiteralArrayNode [
	<gtExample>
	| ast |

	ast := GtPharoParser 
		parse: '#($a #a "a" 1 1.0)'
		startingAt: GtPharoParser startingStateForStatement.

	self assert: ast literalValue equals: #($a #a "a" 1 1.0).
	self assert: ast values size equals: 4.

	^ ast
]

{ #category : #'examples - symbol' }
GtPharoParserExamples >> validSymbolNode [
	<gtExample>
	| ast |

	ast := GtPharoParser 
		parse: '#hello'
		startingAt: GtPharoParser startingStateForStatement.

	self assert: ast literalValue equals: #hello.
	self assert: ast symbol equals: #hello.
	self assert: ast asSymbol equals: #hello.

	^ ast
]

{ #category : #'examples - name and keyword' }
GtPharoParserExamples >> validVariableNode [
	<gtExample>
	| ast |

	ast := GtPharoParser 
		parse: 'hello'
		startingAt: GtPharoParser startingStateForVariable.

	self assert: ast asString equals: 'hello'.
	self assert: ast asSymbol equals: #hello.
	self assert: ast selector equals: #hello.

	^ ast
]
