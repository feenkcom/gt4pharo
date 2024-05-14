Class {
	#name : #GtPharoEvaluatedCode,
	#superclass : #Object,
	#traits : 'TGtSourceCoderEvaluatedCode',
	#classTraits : 'TGtSourceCoderEvaluatedCode classTrait',
	#instVars : [
		'compiledMethod',
		'receiverObject',
		'methodArguments'
	],
	#category : #'GToolkit-Pharo-Coder-Method-Context'
}

{ #category : #accessing }
GtPharoEvaluatedCode >> compiledMethod [
	^ compiledMethod
]

{ #category : #accessing }
GtPharoEvaluatedCode >> compiledMethod: anObject [
	compiledMethod := anObject
]

{ #category : #accessing }
GtPharoEvaluatedCode >> findRelevantContextInStack: aStack [
	"Return a stack context that corresponds to a given evaluated code."

	<return: #Context or: nil>
	aStack
		do: [ :aContext | (self isRelevantContextInStack: aContext) ifTrue: [ ^ aContext ] ].
	^ nil
]

{ #category : #accessing }
GtPharoEvaluatedCode >> findSourceAstForContext: aContext [
	"Return an AST node that corresponds to a given executed code."

	<return: #RBMessageNode>
	^ aContext method sourceNodeForPC: aContext pc
]

{ #category : #printing }
GtPharoEvaluatedCode >> gtDisplayOn: stream [
	self compiledMethod ifNil: [ ^ super gtDisplayOn: stream ].
	self compiledMethod gtDisplayOn: stream
]

{ #category : #testing }
GtPharoEvaluatedCode >> isRelevantContextInStack: aContext [
	^ aContext isBlockContext
		ifTrue: [ aContext compiledCode method = self compiledMethod ]
		ifFalse: [ aContext compiledCode = self compiledMethod ]
]

{ #category : #accessing }
GtPharoEvaluatedCode >> methodArguments [
	^ methodArguments
]

{ #category : #accessing }
GtPharoEvaluatedCode >> methodArguments: anObject [
	methodArguments := anObject
]

{ #category : #accessing }
GtPharoEvaluatedCode >> receiverObject [
	^ receiverObject
]

{ #category : #accessing }
GtPharoEvaluatedCode >> receiverObject: anObject [
	receiverObject := anObject
]
