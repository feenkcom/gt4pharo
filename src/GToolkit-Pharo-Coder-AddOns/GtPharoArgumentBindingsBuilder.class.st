Class {
	#name : #GtPharoArgumentBindingsBuilder,
	#superclass : #Object,
	#instVars : [
		'evaluationContext',
		'compiledMethod',
		'parentMessage',
		'localBindings'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Expander'
}

{ #category : #private }
GtPharoArgumentBindingsBuilder >> argumentAt: anIndex setValueFromLiteral: aParentArgument [
	| aNewName |
	aParentArgument isLiteral ifFalse: [ ^ self ].

	aNewName := compiledMethod argumentNames at: anIndex.
	localBindings localAt: aNewName put: aParentArgument literalValue
]

{ #category : #private }
GtPharoArgumentBindingsBuilder >> argumentAt: anIndex setValueFromVariable: aParentArgument [
	aParentArgument isVariable ifFalse: [ ^ self ].
	evaluationContext
		variableValueOf: aParentArgument variableName
		ifPresent: [ :aValue | 
			| aNewName |
			aNewName := compiledMethod argumentNames at: anIndex.
			localBindings localAt: aNewName put: aValue ]
		ifAbsent: [  "ignore" ]
]

{ #category : #building }
GtPharoArgumentBindingsBuilder >> build [
	parentMessage arguments ifEmpty: [ ^ self ].
	localBindings := GtLocalVariablesBindings new.

	parentMessage arguments
		doWithIndex: [ :anArgument :anIndex | 
			self argumentAt: anIndex setValueFromVariable: anArgument.
			self argumentAt: anIndex setValueFromLiteral: anArgument ].
]

{ #category : #accessing }
GtPharoArgumentBindingsBuilder >> compiledMethod [
	^ compiledMethod
]

{ #category : #accessing }
GtPharoArgumentBindingsBuilder >> compiledMethod: anObject [
	compiledMethod := anObject
]

{ #category : #accessing }
GtPharoArgumentBindingsBuilder >> evaluationContext [
	^ evaluationContext
]

{ #category : #accessing }
GtPharoArgumentBindingsBuilder >> evaluationContext: anObject [
	evaluationContext := anObject
]

{ #category : #accessing }
GtPharoArgumentBindingsBuilder >> localBindings [
	<return: #GtLocalVariablesBindings>
	^ localBindings
]

{ #category : #accessing }
GtPharoArgumentBindingsBuilder >> parentMessage [
	^ parentMessage
]

{ #category : #accessing }
GtPharoArgumentBindingsBuilder >> parentMessage: anObject [
	parentMessage := anObject
]
