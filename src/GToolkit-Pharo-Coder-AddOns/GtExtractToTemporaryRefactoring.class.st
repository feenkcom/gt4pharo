Class {
	#name : #GtExtractToTemporaryRefactoring,
	#superclass : #RBExtractToTemporaryRefactoring,
	#instVars : [
		'source'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring'
}

{ #category : #transforming }
GtExtractToTemporaryRefactoring >> addTemporaryTo: sequenceNode [
	sequenceNode gtAddTemporaryNamed: newVariableName toSource: source.
	sequenceNode addTemporaryNamed: newVariableName
]

{ #category : #transforming }
GtExtractToTemporaryRefactoring >> compileNewMethod [
	| ast |
	ast := RBParser parseFaultyMethod: source asString.
	self parseTree = ast
		ifTrue: [ class compileTree: ast ]
		ifFalse: [  "Should only get here if editing the source didn't work."
			class compileTree: self parseTree ]
]

{ #category : #transforming }
GtExtractToTemporaryRefactoring >> createAssignmentOf: node in: sequenceNode [
	| methodSource |
	methodSource := sequenceNode methodNode source.
	source
		insert: newVariableName , ' := '
				, (methodSource
						copyFrom: node startWithoutParentheses
						to: node stopWithoutParentheses) , '.' , String cr
				, sequenceNode gtStartOfLineWhitespace
		at: node statementNode start.
	sequenceNode
		addNode: (self constructAssignmentFrom: node copy)
		before: node statementNode
]

{ #category : #transforming }
GtExtractToTemporaryRefactoring >> insertTemporary [
	| node statementNode nodeReferences sequenceNode index indexToRemove |
	node := self parseTree whichNodeIsContainedBy: sourceInterval.
	(node notNil and: [ node isValue ])
		ifFalse: [ self refactoringFailure: 'Cannot assign to non-value nodes' ].
	statementNode := node statementNode.
	sequenceNode := statementNode parent.
	nodeReferences := (sequenceNode allChildren
			select: [ :each | 
				each = node
					and: [ (each isVariable not or: [ each isDefinition not ])
							and: [ each isMessage not or: [ each parent isCascade not ] ] ] ])
			asIdentitySet asOrderedCollection sort: [ :a :b | a start < b start ].
	[ nodeReferences isEmpty
		ifTrue: [ self
				refactoringFailure: (node isMessage
						ifTrue: [ 'Cannot extract temporary from cascaded message' ]
						ifFalse: [ 'Cannot assign to non-value nodes' ]) ].
	nodeReferences first statementNode parent ~= sequenceNode ]
		whileTrue: [ nodeReferences removeFirst ].
	node := nodeReferences first.
	self addTemporaryTo: sequenceNode.
	(node isVariable and: [ node isWrite ])
		ifFalse: [ self createAssignmentOf: node in: sequenceNode ].
	index := 1.
	[ index <= nodeReferences size ]
		whileTrue: [ | each |
			each := nodeReferences at: index.
			(each isVariable and: [ each isWrite ])
				ifTrue: [ self replaceVariableAssignment: each.
					each parent value
						nodesDo: [ :n | 
							indexToRemove := nodeReferences identityIndexOf: n.
							indexToRemove > index
								ifTrue: [ nodeReferences removeAtIndex: indexToRemove ] ] ]
				ifFalse: [ self replaceNodeWithVariable: each ].
			index := index + 1 ]
]

{ #category : #'as yet unclassified' }
GtExtractToTemporaryRefactoring >> parseTree [
	parseTree
		ifNil: [ parseTree := class parseTreeForSelector: selector.
			parseTree ifNil: [ self refactoringError: 'Could not parse method' ].
			source := SmaCCString on: parseTree source ].
	^ parseTree doSemanticAnalysis
]

{ #category : #transforming }
GtExtractToTemporaryRefactoring >> replaceNodeWithVariable: aNode [
	source
		replaceFrom: aNode start
		to: aNode stop
		with: newVariableName.
	aNode replaceWith: (RBVariableNode named: newVariableName)
]

{ #category : #transforming }
GtExtractToTemporaryRefactoring >> replaceVariableAssignment: aVariable [
	| ws needsParens methodSource |
	methodSource := aVariable methodNode source.
	ws := aVariable statementNode parent gtStartOfLineWhitespace.
	source
		insert: (methodSource copyFrom: aVariable parent start to: aVariable parent stop) , '.'
				, String cr , ws
		at: aVariable statementNode start.
	aVariable statementNode parent
		addNode: aVariable parent copy
		before: aVariable statementNode.
	needsParens := aVariable parent parent isSequence not.

	source
		replaceFrom: aVariable parent start
		to: aVariable parent stop
		with: (needsParens ifTrue: [ '( ' ] ifFalse: [ '' ]) , newVariableName
				, ' := ' , (methodSource copyFrom: aVariable start to: aVariable stop)
				, (needsParens ifTrue: [ ' )' ] ifFalse: [ '' ]).
	aVariable parent
		replaceWith: (RBAssignmentNode
				variable: (RBVariableNode named: newVariableName)
				value: aVariable copy)
]
