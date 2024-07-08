Class {
	#name : #GtPharoReceiverAndArgumentBindingsBuilder,
	#superclass : #Object,
	#instVars : [
		'compiledMethod',
		'parentMessage',
		'localBindings',
		'receiverObject',
		'receiverBehavior',
		'explicitProviderClass',
		'parentExplicitProviderClass',
		'parentSelfObject',
		'parentEvaluationContext'
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

	(aParentArgument isSelf or: [ aParentArgument isSuper ])
		ifTrue: [ parentSelfObject
				ifNotNil: [ | aNewName |
					aNewName := compiledMethod argumentNames at: anIndex.
					localBindings localAt: aNewName put: parentSelfObject ].
					^ self ].

	parentEvaluationContext
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
	self buildExplicitProviderClass
]

{ #category : #building }
GtPharoReceiverAndArgumentBindingsBuilder >> buildExplicitProviderClass [
	| aGtPharoProgramNode |
	compiledMethod ifNil: [ ^ self ].

	aGtPharoProgramNode := parentMessage parent receiver.
	(aGtPharoProgramNode isVariable
		and: [ aGtPharoProgramNode isSelf or: [ aGtPharoProgramNode isSuper ] ])
		ifFalse: [ explicitProviderClass := receiverBehavior.
			^ self ].

	explicitProviderClass := parentExplicitProviderClass
			ifNil: [ parentEvaluationContext targetBehavior ifNil: [ receiverBehavior ] ].
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
		ifTrue: [ ^ receiverObject := parentSelfObject ].
	
	(aGtPharoProgramNode isVariable and: [ aGtPharoProgramNode isSuper ])
		ifTrue: [ ^ receiverObject := parentSelfObject ].
		
	(aGtPharoProgramNode isVariable and: [ aGtPharoProgramNode isThisContext ])
		ifTrue: [ ^ receiverObject := nil ].
		
	aGtPharoProgramNode isVariable
		ifTrue: [ | aVariableName |
			aVariableName := aGtPharoProgramNode name value asSymbol. 
			parentEvaluationContext
				variableValueOf: aVariableName
				ifPresent: [ :aValue | ^ receiverObject := aValue  ]
				ifAbsent: [  "ignore" ] ].
				
	aGtPharoProgramNode isLiteral
		ifTrue: [ ^ receiverObject := aGtPharoProgramNode literalValue ].
]

{ #category : #building }
GtPharoReceiverAndArgumentBindingsBuilder >> buildReceiverBehavior [
	| aGtPharoProgramNode |
	parentMessage ifNil: [ ^ self ].

	receiverObject
		ifNotNil: [ receiverBehavior := receiverObject class.
			^ self ].

	aGtPharoProgramNode := parentMessage parent receiver.
	(aGtPharoProgramNode isVariable and: [ aGtPharoProgramNode isSelf ])
		ifTrue: [ receiverBehavior := parentEvaluationContext targetBehavior.
			^ self ].

	(aGtPharoProgramNode isVariable and: [ aGtPharoProgramNode isSuper ])
		ifTrue: [ receiverBehavior := parentEvaluationContext targetBehavior superclass.
			^ self ]
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
	^ self parentEvaluationContext
]

{ #category : #accessing }
GtPharoReceiverAndArgumentBindingsBuilder >> evaluationContext: anObject [
	self parentEvaluationContext: anObject
]

{ #category : #'accessing - results' }
GtPharoReceiverAndArgumentBindingsBuilder >> explicitProviderClass [
	^ explicitProviderClass
]

{ #category : #'accessing - results' }
GtPharoReceiverAndArgumentBindingsBuilder >> localBindings [
	<return: #GtLocalVariablesBindings>
	^ localBindings
]

{ #category : #accessing }
GtPharoReceiverAndArgumentBindingsBuilder >> parentEvaluationContext [
	<return: #GtPharoSourceCoderEvaluationContext>
	^ parentEvaluationContext
]

{ #category : #accessing }
GtPharoReceiverAndArgumentBindingsBuilder >> parentEvaluationContext: anObject [
	self assert: [ anObject isKindOf: GtPharoSourceCoderEvaluationContext ]
		description: [ 'Expected {1} kind of object, but received: {2}' 
			format: { GtPharoSourceCoderEvaluationContext. anObject } ].
	parentEvaluationContext := anObject
]

{ #category : #accessing }
GtPharoReceiverAndArgumentBindingsBuilder >> parentExplicitProviderClass [
	^ parentExplicitProviderClass
]

{ #category : #accessing }
GtPharoReceiverAndArgumentBindingsBuilder >> parentExplicitProviderClass: anObject [
	parentExplicitProviderClass := anObject
]

{ #category : #accessing }
GtPharoReceiverAndArgumentBindingsBuilder >> parentMessage [
	^ parentMessage
]

{ #category : #accessing }
GtPharoReceiverAndArgumentBindingsBuilder >> parentMessage: anObject [
	parentMessage := anObject
]

{ #category : #accessing }
GtPharoReceiverAndArgumentBindingsBuilder >> parentSelfObject: anObject [
	parentSelfObject := anObject
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
	^ parentSelfObject
]

{ #category : #accessing }
GtPharoReceiverAndArgumentBindingsBuilder >> selfObject: anObject [
	parentSelfObject := anObject
]
