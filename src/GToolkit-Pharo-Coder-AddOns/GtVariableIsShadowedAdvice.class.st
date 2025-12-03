Class {
	#name : #GtVariableIsShadowedAdvice,
	#superclass : #GtMethodAdvice,
	#category : 'GToolkit-Pharo-Coder-AddOns-MethodAdvices'
}

{ #category : #accessing }
GtVariableIsShadowedAdvice >> description [
	^ 'Variable has same name as another variable defined in an outer scope.'
]

{ #category : #styling }
GtVariableIsShadowedAdvice >> fixItActionsForNode: aNode coderViewModel: coderViewModel [
	^ {GtInteractiveRenameVariableFixItAction new
			coderViewModel: coderViewModel;
			node: aNode;
			sourceCoder: coderViewModel coderModel;
			yourself}
]

{ #category : #testing }
GtVariableIsShadowedAdvice >> matches: aNode from: aCriticRunner [
	aNode isErrorNode ifTrue: [ ^ false ].
	aNode isVariable ifFalse: [ ^ false ].
	aNode parent ifNil: [ ^ false ].
	((aNode parent isBlock
		or: [ aNode parent isSequence or: [ aNode parent isMethod ] ])
		and: [ aNode parent variables identityIncludes: aNode ]) ifFalse: [ ^ false ].
	aNode parent parent
		ifNotNil: [ :superNode | (superNode whoDefines: aNode variableName) ifNotNil: [ ^ true ] ].
	^ aCriticRunner hasExplicitlyDeclaredVariableNamed: aNode variableName
]

{ #category : #accessing }
GtVariableIsShadowedAdvice >> name [
	^ 'Variable shadows another variable'
]
