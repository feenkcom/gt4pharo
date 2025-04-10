Class {
	#name : #GtConvertCascadesToStatementsRefactoring,
	#superclass : #GtCascadesRefactoring,
	#instVars : [
		'sourceInterval'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring'
}

{ #category : #'instance creation' }
GtConvertCascadesToStatementsRefactoring class >> model: model convert: anInterval inMethod: aSelector forClass: aClass [
	^ self new
		model: model;
		convert: anInterval
			inMethod: aSelector
			forClass: aClass;
		yourself
]

{ #category : #initialization }
GtConvertCascadesToStatementsRefactoring >> convert: anInterval inMethod: aSelector forClass: aClassOrSymbol [
	sourceInterval := anInterval.
	selector := aSelector.
	class := self model classObjectFor: aClassOrSymbol
]

{ #category : #private }
GtConvertCascadesToStatementsRefactoring >> findNode [
	| sourceTree |
	sourceTree := class parseTreeForSelector: selector.
	sourceTree ifNil: [ self refactoringFailure: 'Could not parse source' ].
	sourceTree
		nodesDo: [ :each | 
			(each isCascade and: [ each sourceInterval = sourceInterval ])
				ifTrue: [ ^ each ] ].
	^ nil
]

{ #category : #accessing }
GtConvertCascadesToStatementsRefactoring >> gtDescription [
	^ 'Convert cascades to statements'
]

{ #category : #transforming }
GtConvertCascadesToStatementsRefactoring >> transformNode: aNode [
	| statement newMessages |
	newMessages := aNode messages collect: [ :each | each copy ].
	(newMessages last isMessage and: [ newMessages last selector = #yourself ])
		ifTrue: [ newMessages at: newMessages size put: newMessages last receiver ].
	statement := aNode statementNode.
	statement parent addNodes: newMessages allButLast before: statement.
	(statement == aNode and: [ newMessages last isVariable ])
		ifTrue: [ aNode parent removeNode: aNode ]
		ifFalse: [ aNode parent replaceNode: aNode withNode: newMessages last ].
	class compileTree: aNode methodNode
]
