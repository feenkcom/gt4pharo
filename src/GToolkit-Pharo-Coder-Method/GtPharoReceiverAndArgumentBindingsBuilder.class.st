Class {
	#name : #GtPharoReceiverAndArgumentBindingsBuilder,
	#superclass : #Object,
	#instVars : [
		'evaluationContext',
		'compiledMethod',
		'parentMessage',
		'localBindings',
		'receiverObject',
		'selfObject',
		'receiverBehavior',
		'messageNode'
	],
	#category : #'GToolkit-Pharo-Coder-Method-Utilities'
}

{ #category : #private }
GtPharoReceiverAndArgumentBindingsBuilder >> argumentAt: anIndex setValueFromLiteral: aParentArgument [
	| aNewName |
	aParentArgument isLiteral ifFalse: [ ^ self ].

	aNewName := compiledMethod argumentNames at: anIndex.
	localBindings localAt: aNewName put: aParentArgument literalValue
]

{ #category : #private }
GtPharoReceiverAndArgumentBindingsBuilder >> argumentAt: anIndex setValueFromVariable: aParentArgument [
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
GtPharoReceiverAndArgumentBindingsBuilder >> build [
	self buildLocalBindings.
	self buildReceiver.
	self buildReceiverBehavior.
]

{ #category : #building }
GtPharoReceiverAndArgumentBindingsBuilder >> buildLocalBindings [
	parentMessage arguments ifEmpty: [ ^ self ].
	localBindings := GtLocalVariablesBindings new.

	parentMessage arguments
		doWithIndex: [ :anArgument :anIndex | 
			self argumentAt: anIndex setValueFromVariable: anArgument.
			self argumentAt: anIndex setValueFromLiteral: anArgument ].
]

{ #category : #building }
GtPharoReceiverAndArgumentBindingsBuilder >> buildReceiver [
	"Inspired by {{gtMethod: GtPharoProgramNode class >> #typeOf:in:bindings:}}"

	| aGtPharoProgramNode |
	aGtPharoProgramNode := parentMessage parent receiver.
			
	(aGtPharoProgramNode isVariable and: [ aGtPharoProgramNode isSelf ])
		ifTrue: [ ^ receiverObject := selfObject ].
	
	(aGtPharoProgramNode isVariable and: [ aGtPharoProgramNode isSuper ])
		ifTrue: [ ^ receiverObject := selfObject ].
		
	(aGtPharoProgramNode isVariable and: [ aGtPharoProgramNode isThisContext ])
		ifTrue: [ ^ receiverObject := selfObject ].
		
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

{ #category : #building }
GtPharoReceiverAndArgumentBindingsBuilder >> buildReceiverBehavior [
	receiverBehavior ifNil: [ ^ self ].
	messageNode ifNil: [ ^ self ].
	(messageNode isVariable and: [ messageNode isSelf ]) ifFalse: [ ^ self ].

	receiverBehavior := receiverObject class
]

{ #category : #accessing }
GtPharoReceiverAndArgumentBindingsBuilder >> compiledMethod [
	^ compiledMethod
]

{ #category : #accessing }
GtPharoReceiverAndArgumentBindingsBuilder >> compiledMethod: anObject [
	compiledMethod := anObject
]

{ #category : #accessing }
GtPharoReceiverAndArgumentBindingsBuilder >> evaluationContext [
	^ evaluationContext
]

{ #category : #accessing }
GtPharoReceiverAndArgumentBindingsBuilder >> evaluationContext: anObject [
	evaluationContext := anObject
]

{ #category : #'accessing - results' }
GtPharoReceiverAndArgumentBindingsBuilder >> localBindings [
	<return: #GtLocalVariablesBindings>
	^ localBindings
]

{ #category : #accessing }
GtPharoReceiverAndArgumentBindingsBuilder >> messageNode [
	^ messageNode
]

{ #category : #accessing }
GtPharoReceiverAndArgumentBindingsBuilder >> messageNode: anObject [
	messageNode := anObject
]

{ #category : #accessing }
GtPharoReceiverAndArgumentBindingsBuilder >> parentMessage [
	^ parentMessage
]

{ #category : #accessing }
GtPharoReceiverAndArgumentBindingsBuilder >> parentMessage: anObject [
	parentMessage := anObject
]

{ #category : #'accessing - results' }
GtPharoReceiverAndArgumentBindingsBuilder >> receiverBehavior [
	^ receiverBehavior
]

{ #category : #'accessing - results' }
GtPharoReceiverAndArgumentBindingsBuilder >> receiverObject [
	^ receiverObject
]

{ #category : #accessing }
GtPharoReceiverAndArgumentBindingsBuilder >> selfObject [
	^ selfObject
]

{ #category : #accessing }
GtPharoReceiverAndArgumentBindingsBuilder >> selfObject: anObject [
	selfObject := anObject
]
