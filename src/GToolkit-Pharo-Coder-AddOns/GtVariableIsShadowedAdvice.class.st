Class {
	#name : #GtVariableIsShadowedAdvice,
	#superclass : #GtMethodAdvice,
	#category : #'GToolkit-Pharo-Coder-AddOns-MethodAdvices'
}

{ #category : #'as yet unclassified' }
GtVariableIsShadowedAdvice >> description [
	^ 'Variable has same name as another variable defined in an outer scope.'
]

{ #category : #'as yet unclassified' }
GtVariableIsShadowedAdvice >> matches: aNode from: aCriticRunner [
	aNode isErrorNode ifTrue: [ ^ false ].
	aNode isVariable ifFalse: [ ^ false ].
	aNode parent ifNil: [ ^ false ].
	((aNode parent isBlock
		or: [ aNode parent isSequence or: [ aNode parent isMethod ] ])
		and: [ aNode parent variables identityIncludes: aNode ]) ifFalse: [ ^ false ].
	aNode parent parent
		ifNotNil: [ :superNode | (superNode whoDefines: aNode variableName) ifNotNil: [ ^ true ] ].
	^ aCriticRunner hasDeclaredVariableNamed: aNode variableName
]

{ #category : #'as yet unclassified' }
GtVariableIsShadowedAdvice >> name [
	^ 'Variable shadows another variable'
]
