Class {
	#name : #GtPharoArgumentBindingsBuilder,
	#superclass : #Object,
	#instVars : [
		'evaluationContext',
		'compiledMethod',
		'parentMessage',
		'localBindings',
		'receiverObject'
	],
	#category : #'GToolkit-Pharo-Coder-Method-Utilities'
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
	self buildLocalBindings.
	self buildReceiver.
]

{ #category : #building }
GtPharoArgumentBindingsBuilder >> buildLocalBindings [
	parentMessage arguments ifEmpty: [ ^ self ].
	localBindings := GtLocalVariablesBindings new.

	parentMessage arguments
		doWithIndex: [ :anArgument :anIndex | 
			self argumentAt: anIndex setValueFromVariable: anArgument.
			self argumentAt: anIndex setValueFromLiteral: anArgument ].
]

{ #category : #building }
GtPharoArgumentBindingsBuilder >> buildReceiver [
	"Inspired by {{gtMethod: GtPharoProgramNode class >> #typeOf:in:bindings:}}"

	| aGtPharoProgramNode |
	aGtPharoProgramNode := parentMessage parent receiver.
			
	(aGtPharoProgramNode isVariable and: [ aGtPharoProgramNode isSelf ])
		ifTrue: [ ^ receiverObject := evaluationContext receiverObject ].
	
	(aGtPharoProgramNode isVariable and: [ aGtPharoProgramNode isSuper ])
		ifTrue: [ ^ receiverObject := evaluationContext receiverObject ].
		
	(aGtPharoProgramNode isVariable and: [ aGtPharoProgramNode isThisContext ])
		ifTrue: [ ^ receiverObject := evaluationContext receiverObject ].
		
	aGtPharoProgramNode isVariable
		ifTrue: [ | aVariableName |
			aVariableName := aGtPharoProgramNode name value asSymbol. 
			evaluationContext
				variableValueOf: aVariableName
				ifPresent: [ :aValue | ^ receiverObject := aValue  ]
				ifAbsent: [  "ignore" ] ].
				
	aGtPharoProgramNode isLiteral
		ifTrue: [ ^ receiverObject := aGtPharoProgramNode literalValue ].
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

{ #category : #accessing }
GtPharoArgumentBindingsBuilder >> receiverObject [
	^ receiverObject
]
