Class {
	#name : #GtPharoTemplateParserExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Parser-Examples'
}

{ #category : #'examples - variables' }
GtPharoTemplateParserExamples >> invalidTemplateVariableWithSpaceAfterTemplate [
	<gtExample>
	
	[ | ast |
	ast := GtPharoTemplateParser parse: 'before{{self printString}} after' startingAt: GtPharoParser startingStateForVariable.
	self assert: ast equals: 'Should not get here' ] on: SmaCCParserError do: [ :ex | ^ ex ]
]

{ #category : #'examples - variables' }
GtPharoTemplateParserExamples >> invalidTemplateVariableWithSpaceBeforeTemplate [
	<gtExample>
	
	[ | ast |
	ast := GtPharoTemplateParser parse: 'before {{self printString}}after' startingAt: GtPharoParser startingStateForVariable.
	self assert: ast equals: 'Should not get here' ] on: SmaCCParserError do: [ :ex | ^ ex ]
]

{ #category : #'examples - variables' }
GtPharoTemplateParserExamples >> normalVariable [
	<gtExample>
	| ast |

	ast := GtPharoTemplateParser 
		parse: 'hello'
		startingAt: GtPharoParser startingStateForVariable.

	self assert: ast class equals: GtPharoNamedVariableNode.

	^ ast
]

{ #category : #'examples - messages' }
GtPharoTemplateParserExamples >> validTemplateKeywordMessage [
	<gtExample>
	| ast |

	ast := GtPharoTemplateParser 
		parse: '3 {{self printString}}: 4'
		startingAt: GtPharoParser startingStateForStatement.

	self assert: ast class equals: GtPharoMessageSendNode.
	self assert: ast receiver literalValue equals: 3.
	self assert: ast message class equals: GtPharoTemplateKeywordMessageNode.
	self assert: ast message parts first class equals: GtPharoTemplateNode.
	self assert: ast message arguments size equals: 1.
	self assert: ast message arguments first literalValue equals: 4.

	^ ast
]

{ #category : #'examples - method patterns' }
GtPharoTemplateParserExamples >> validTemplateKeywordMethodPattern [
	<gtExample>
	| ast |

	ast := GtPharoTemplateParser 
		parse: '{{self printString}}: a'
		startingAt: GtPharoParser startingStateForMethodPattern.

	self assert: ast class equals: GtPharoTemplatePatternNode.
	self assert: ast parts first class equals: GtPharoTemplateNode.
	self assert: ast variables size equals: 1.
	self assert: ast variables first source equals: 'a'.

	^ ast
]

{ #category : #'examples - pragmas' }
GtPharoTemplateParserExamples >> validTemplateKeywordPragma [
	<gtExample>
	| ast |

	ast := GtPharoTemplateParser 
		parse: '<{{self printString}}: 4>'
		startingAt: GtPharoParser startingStateForPragma.

	self assert: ast class equals: GtPharoTemplatePragmaNode.
	self assert: ast parts size equals: 1.
	self assert: ast parts first class equals: GtPharoTemplateNode.
	self assert: ast values size equals: 1.
	self assert: ast values first literalValue equals: 4.

	^ ast
]

{ #category : #'examples - messages' }
GtPharoTemplateParserExamples >> validTemplateUnaryMessage [
	<gtExample>
	| ast |

	ast := GtPharoTemplateParser 
		parse: '3 a{{self printString}}b'
		startingAt: GtPharoParser startingStateForStatement.

	self assert: ast class equals: GtPharoMessageSendNode.
	self assert: ast receiver literalValue equals: 3.
	self assert: ast message class equals: GtPharoTemplateUnaryMessageNode.
	self assert: ast message parts first source equals: 'a'.
	self assert: ast message parts second class equals: GtPharoTemplateNode.
	self assert: ast message parts third source equals: 'b'.

	^ ast
]

{ #category : #'examples - method patterns' }
GtPharoTemplateParserExamples >> validTemplateUnaryMethodPattern [
	<gtExample>
	| ast |

	ast := GtPharoTemplateParser 
		parse: 'a{{self printString}}b'
		startingAt: GtPharoParser startingStateForMethodPattern.

	self assert: ast class equals: GtPharoTemplatePatternNode.
	self assert: ast parts first source equals: 'a'.
	self assert: ast parts second class equals: GtPharoTemplateNode.
	self assert: ast parts third source equals: 'b'.
	self assert: ast variables size equals: 0.

	^ ast
]

{ #category : #'examples - pragmas' }
GtPharoTemplateParserExamples >> validTemplateUnaryPragma [
	<gtExample>
	| ast |

	ast := GtPharoTemplateParser 
		parse: '<a{{self printString}}b>'
		startingAt: GtPharoParser startingStateForPragma.

	self assert: ast class equals: GtPharoTemplatePragmaNode.
	self assert: ast parts size equals: 3.
	self assert: ast parts first source equals: 'a'.
	self assert: ast parts second class equals: GtPharoTemplateNode.
	self assert: ast parts third source equals: 'b'.
	self assert: ast values size equals: 0.

	^ ast
]

{ #category : #'examples - variables' }
GtPharoTemplateParserExamples >> validTemplateVariable [
	<gtExample>
	| ast |

	ast := GtPharoTemplateParser 
		parse: 'before{{self printString}}after'
		startingAt: GtPharoParser startingStateForVariable.

	self assert: ast class equals: GtPharoTemplateVariableNode.
	self assert: ast parts size equals: 3.
	self assert: ast parts first source equals: 'before'.
	self assert: ast parts second class equals: GtPharoTemplateNode.
	self assert: ast parts last source equals: 'after'.

	^ ast
]
