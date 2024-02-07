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
GtPharoArgumentBindingsBuilder >> argumentAt: anIndex setValueFrom: aParentArgument [
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
			self argumentAt: anIndex setValueFrom: anArgument ].
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
