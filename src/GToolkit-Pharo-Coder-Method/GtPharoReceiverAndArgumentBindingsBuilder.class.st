Class {
	#name : #GtPharoReceiverAndArgumentBindingsBuilder,
	#superclass : #Object,
	#instVars : [
		'compiledMethod',
		'parentMessage',
		'localBindings',
		'receiverBehavior',
		'explicitProviderClass',
		'parentExplicitProviderClass',
		'parentEvaluationContext',
		'parentExample',
		'parentTestCase',
		'parentCoderViewModel',
		'parentSelfObjectHolder',
		'receiverObjectHolder',
		'receiverSubclassBehavior'
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

	(aParentArgument isSelf or: [ aParentArgument isSuper ]) ifTrue: [ 
		parentSelfObjectHolder ifNotNil: [ :aHolder | 
			aHolder 
				ifDefined: [ :aSelfObject |
					| aNewName |
					aNewName := compiledMethod argumentNames at: anIndex.
					localBindings localAt: aNewName put: aSelfObject ] 
				ifNone: [ ] ].
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
	"Likely related to the https://github.com/feenkcom/gtoolkit/issues/3862
	changes. We need to review whether we can pass context information also
	to cases like 
		`self announcer weak when: Announcement send: #onAnnouncement: to: self`."
	(parentMessage respondsTo: #arguments) ifFalse: [ ^ self ].

	self buildLocalBindings.
	self buildReceiver.
	self buildReceiverBehavior.
	self buildExplicitProviderClass.
	self buildMethodBehavior.
]

{ #category : #building }
GtPharoReceiverAndArgumentBindingsBuilder >> buildExplicitProviderClass [
	compiledMethod ifNil: [ ^ self ].
	parentMessage ifNil: [ ^ self ].
	self isSelfOrSuperReceiver ifFalse: [ 
		explicitProviderClass := receiverBehavior.
		^ self ].

	explicitProviderClass := parentExplicitProviderClass.
	explicitProviderClass ifNil: [ 
		explicitProviderClass := parentEvaluationContext targetBehavior ].
	explicitProviderClass ifNil: [
		parentCoderViewModel ifNotNil: [
			parentCoderViewModel coderModel methodBehavior
				ifRealSubclassBehaviorSameAsRealBehaviorDo: [ :aBehavior | "ignore" ]
				ifDifferentDo: [ :aSubclassBehavior | 
					(aSubclassBehavior inheritsFrom: compiledMethod methodClass)
						ifTrue: [ explicitProviderClass := aSubclassBehavior ] ]
				ifAbsent: [ "ignore" ] ] ].
	explicitProviderClass ifNil: [
		explicitProviderClass := receiverBehavior ].
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
GtPharoReceiverAndArgumentBindingsBuilder >> buildMethodBehavior [
	| aSelectedBehavior |
	compiledMethod ifNil: [ ^ self ].
	parentCoderViewModel ifNil: [ ^ self ].

	self isSelfOrSuperReceiver ifFalse: [ ^ self ].

	parentCoderViewModel coderModel methodBehavior
		ifRealSubclassBehaviorSameAsRealBehaviorDo: [ :aBehavior | aSelectedBehavior := nil ]
		ifDifferentDo: [ :aSubclassBehavior | aSelectedBehavior := aSubclassBehavior ]
		ifAbsent: [ aSelectedBehavior := nil ].
		
	aSelectedBehavior ifNil: [
		(compiledMethod isSubclassResponsibility and: [ explicitProviderClass ~= compiledMethod methodClass ])
			ifTrue: [ aSelectedBehavior := explicitProviderClass ] ].

	aSelectedBehavior ifNil: [ ^ self ].

	(aSelectedBehavior inheritsFrom: compiledMethod methodClass)
		ifFalse: [ ^ self ].

	receiverSubclassBehavior := aSelectedBehavior
]

{ #category : #building }
GtPharoReceiverAndArgumentBindingsBuilder >> buildReceiver [
	"Inspired by {{gtMethod: GtPharoProgramNode class >> #typeOf:in:bindings:}}"

	| aGtPharoProgramNode |
	aGtPharoProgramNode := parentMessage parent receiver.
			
	(aGtPharoProgramNode isVariable and: [ aGtPharoProgramNode isSelf ])
		ifTrue: [ ^ receiverObjectHolder := parentSelfObjectHolder ].
	
	(aGtPharoProgramNode isVariable and: [ aGtPharoProgramNode isSuper ])
		ifTrue: [ ^ receiverObjectHolder := parentSelfObjectHolder ].
		
	(aGtPharoProgramNode isVariable and: [ aGtPharoProgramNode isThisContext ])
		ifTrue: [ ^ receiverObjectHolder := nil ].
		
	aGtPharoProgramNode isVariable
		ifTrue: [ | aVariableName |
			aVariableName := aGtPharoProgramNode name value asSymbol. 
			parentEvaluationContext
				variableValueOf: aVariableName
				ifPresent: [ :aValue | 
					^ receiverObjectHolder := GtCoderObject forValue: aValue  ]
				ifAbsent: [  "ignore" ] ].
				
	aGtPharoProgramNode isLiteral ifTrue: [ 
		^ receiverObjectHolder := GtCoderObject forValue: aGtPharoProgramNode literalValue ].
]

{ #category : #building }
GtPharoReceiverAndArgumentBindingsBuilder >> buildReceiverBehavior [
	parentMessage ifNil: [ ^ self ].

	receiverObjectHolder
		ifNotNil: [ receiverObjectHolder
				ifDefined: [ :aSelfObject | 
					receiverBehavior := aSelfObject class.
					^ self ]
				ifNone: [ "ignore" ] ].

	self isSelfReceiver
		ifTrue: [ receiverBehavior := parentEvaluationContext targetBehavior.
			^ self ].
	self isSuperReceiver
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

{ #category : #'private - testing' }
GtPharoReceiverAndArgumentBindingsBuilder >> isSelfOrSuperReceiver [
	| aReceiverNode |
	aReceiverNode := parentMessage parent receiver.
	^ aReceiverNode isVariable and: [ aReceiverNode isSelf or: [ aReceiverNode isSuper ] ]
]

{ #category : #'private - testing' }
GtPharoReceiverAndArgumentBindingsBuilder >> isSelfReceiver [
	| aReceiverNode |
	aReceiverNode := parentMessage parent receiver.
	^ aReceiverNode isVariable and: [ aReceiverNode isSelf ]
]

{ #category : #'private - testing' }
GtPharoReceiverAndArgumentBindingsBuilder >> isSuperReceiver [
	| aReceiverNode |
	aReceiverNode := parentMessage parent receiver.
	^ aReceiverNode isVariable and: [ aReceiverNode isSuper ]
]

{ #category : #'accessing - results' }
GtPharoReceiverAndArgumentBindingsBuilder >> localBindings [
	<return: #GtLocalVariablesBindings>
	^ localBindings
]

{ #category : #accessing }
GtPharoReceiverAndArgumentBindingsBuilder >> parentCoderViewModel [
	^ parentCoderViewModel
]

{ #category : #accessing }
GtPharoReceiverAndArgumentBindingsBuilder >> parentCoderViewModel: anObject [
	parentCoderViewModel := anObject
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
GtPharoReceiverAndArgumentBindingsBuilder >> parentExample [
	^ parentExample
]

{ #category : #accessing }
GtPharoReceiverAndArgumentBindingsBuilder >> parentExample: anExample [
	parentExample := anExample
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
GtPharoReceiverAndArgumentBindingsBuilder >> parentSelfObjectHolder [
	^ parentSelfObjectHolder ifNil: [ GtCoderUndefinedObject default ]
]

{ #category : #accessing }
GtPharoReceiverAndArgumentBindingsBuilder >> parentSelfObjectHolder: anObject [
	parentSelfObjectHolder := anObject
]

{ #category : #accessing }
GtPharoReceiverAndArgumentBindingsBuilder >> parentTestCase [
	^ parentTestCase
]

{ #category : #accessing }
GtPharoReceiverAndArgumentBindingsBuilder >> parentTestCase: anObject [
	parentTestCase := anObject
]

{ #category : #'accessing - results' }
GtPharoReceiverAndArgumentBindingsBuilder >> receiverBehavior [
	^ receiverBehavior
]

{ #category : #'accessing - results' }
GtPharoReceiverAndArgumentBindingsBuilder >> receiverObjectHolder [
	<return: #TGtCoderObject>
	^ receiverObjectHolder ifNil: [ GtCoderUndefinedObject default ]
]

{ #category : #'accessing - results' }
GtPharoReceiverAndArgumentBindingsBuilder >> receiverSubclassBehavior [
	^ receiverSubclassBehavior
]
