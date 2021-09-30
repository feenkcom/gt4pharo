Class {
	#name : #GtAddParameterRefactoring,
	#superclass : #RBAddParameterRefactoring,
	#category : 'GToolkit-Pharo-Coder-AddOns-Refactoring'
}

{ #category : #private }
GtAddParameterRefactoring >> modifyImplementorParseTree: parseTree in: aClass [
	super modifyImplementorParseTree: parseTree in: aClass.
	newArgs do: [ :each | self replaceReference: each in: parseTree ]
]

{ #category : #private }
GtAddParameterRefactoring >> replaceReference: argumentName in: parseTree [
	| searchTree |
	searchTree := RBParser parseExpression: argumentName value1.
	parseTree body
		nodesDo:
			[ :each | 
			((each isVariable and: [ each isDefinition ]) not and: [ searchTree = each ])
				ifTrue: [ each replaceWith: (RBVariableNode named: argumentName newName) ] ]
]
