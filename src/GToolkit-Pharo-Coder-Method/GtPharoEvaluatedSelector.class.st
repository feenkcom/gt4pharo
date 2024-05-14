Class {
	#name : #GtPharoEvaluatedSelector,
	#superclass : #Object,
	#traits : 'TGtSourceCoderEvaluatedCode',
	#classTraits : 'TGtSourceCoderEvaluatedCode classTrait',
	#instVars : [
		'receiver',
		'methodSelector',
		'methodArguments'
	],
	#category : #'GToolkit-Pharo-Coder-Method-Context'
}

{ #category : #accessing }
GtPharoEvaluatedSelector >> findRelevantContextInStack: aStack [
	"Return a stack context that corresponds to a given evaluated code."

	<return: #Context or: nil>
	aStack
		do: [ :aContext | (self isRelevantContextInStack: aContext) ifTrue: [ ^ aContext ] ].
	^ nil
]

{ #category : #accessing }
GtPharoEvaluatedSelector >> findSourceIntervalForContext: aContext sourceString: aSourceString [
	"Return an AST node that corresponds to a given executed code."

	<return: #RBMessageNode>
	^ aContext method rangeForPC: aContext pc
]

{ #category : #testing }
GtPharoEvaluatedSelector >> isRelevantContextInStack: aContext [
	| aMethod |
	aMethod := aContext isBlockContext
			ifTrue: [ aContext compiledCode method ]
			ifFalse: [ aContext compiledCode ].
	^ aMethod selector = self methodSelector
		and: [ aContext receiver == self receiver ]
]

{ #category : #accessing }
GtPharoEvaluatedSelector >> methodArguments [
	^ methodArguments
]

{ #category : #accessing }
GtPharoEvaluatedSelector >> methodArguments: anObject [
	methodArguments := anObject
]

{ #category : #accessing }
GtPharoEvaluatedSelector >> methodSelector [
	^ methodSelector
]

{ #category : #accessing }
GtPharoEvaluatedSelector >> methodSelector: anObject [
	methodSelector := anObject
]

{ #category : #accessing }
GtPharoEvaluatedSelector >> receiver [
	^ receiver
]

{ #category : #accessing }
GtPharoEvaluatedSelector >> receiver: anObject [
	receiver := anObject
]
