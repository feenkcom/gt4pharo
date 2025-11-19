Class {
	#name : #GtAddParameterRefactoring,
	#superclass : #RBAddParameterRefactoring,
	#instVars : [
		'shouldReplaceExpressions'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring'
}

{ #category : #accessing }
GtAddParameterRefactoring >> checkSendersAccessTo: name [
	| classes |
	(#('self' 'super') includes: name) ifTrue: [ ^ self ].
	classes := Dictionary new.
	self model
		allReferencesTo: oldSelector
		do: [ :each | 
			((classes
				at: each modelClass
				ifAbsentPut: [ self canReferenceVariable: name in: each modelClass ])
				or: [ | canRef |
					canRef := true.
					each ast
						nodesDo: [ :node | 
							(node isMessage and: [ node selector = oldSelector ])
								ifTrue: [ canRef := canRef and: [ (node whoDefines: name) notNil ] ] ].
					canRef ])
				ifFalse: [ self
						refactoringError: ('<1s> doesn''t appear to be defined in <2p>'
								expandMacrosWith: name
								with: each modelClass) ] ]
]

{ #category : #transforming }
GtAddParameterRefactoring >> executeRenameExtensions [
	(Pragma
		allNamed: #gtRename
		from: self class
		to: GtAddParameterRefactoring)
		do: [ :each | self perform: each method selector ]
]

{ #category : #accessing }
GtAddParameterRefactoring >> initialize [
	super initialize.
	shouldReplaceExpressions := false
]

{ #category : #private }
GtAddParameterRefactoring >> isDefinition: aVariableNode [
	| parent |
	parent := aVariableNode parent.
	parent ifNil: [ ^ false ].
	parent isSequence
		ifTrue: [ ^ parent temporaries identityIncludes: aVariableNode ].
	(parent isBlock or: [ parent isMethod ])
		ifTrue: [ ^ parent arguments identityIncludes: aVariableNode ].
	^ false
]

{ #category : #private }
GtAddParameterRefactoring >> modifyImplementorParseTree: parseTree in: aClass [
	super modifyImplementorParseTree: parseTree in: aClass.
	shouldReplaceExpressions ifFalse: [ ^ self ].
	newArgs do: [ :each | self replaceReference: each in: parseTree ]
]

{ #category : #transforming }
GtAddParameterRefactoring >> renameMessageSends [
	"Pharo 11"
	super renameMessageSends.
	self executeRenameExtensions
]

{ #category : #transforming }
GtAddParameterRefactoring >> replaceMessageSends [
	"Pharo 12"
	super replaceMessageSends.
	self executeRenameExtensions
]

{ #category : #private }
GtAddParameterRefactoring >> replaceReference: argumentName in: parseTree [
	| searchTree |
	searchTree := RBParser parseExpression: argumentName argValue.
	parseTree body
		nodesDo: [ :each | 
			((each isVariable and: [ self isDefinition: each ]) not
				and: [ searchTree = each
						and: [ each parent notNil and: [ each parent isLiteralNode not ] ] ])
				ifTrue: [ each replaceWith: (RBVariableNode named: argumentName newName) ] ]
]

{ #category : #accessing }
GtAddParameterRefactoring >> shouldReplaceExpressions [
	^ shouldReplaceExpressions
]

{ #category : #accessing }
GtAddParameterRefactoring >> shouldReplaceExpressions: anObject [
	shouldReplaceExpressions := anObject
]
