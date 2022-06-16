Class {
	#name : #GtHaltCritic,
	#superclass : #GtMethodCritic,
	#category : #'GToolkit-Pharo-Coder-AddOns-Critics'
}

{ #category : #accessing }
GtHaltCritic >> description [
	^ 'Debugging code is in method and should be removed before it is released.'
]

{ #category : #testing }
GtHaltCritic >> includeFixIt [
	^ false
]

{ #category : #accessing }
GtHaltCritic >> matches: aNode from: aCriticRunner [
	aNode isMessage ifTrue: [ ^ #(halt haltOnce haltIf:) includes: aNode selector ].
	aNode isMessageSend
		ifTrue: [ | receiver method |
			receiver := aNode receiver.
			receiver isVariable ifFalse: [ ^ false ].
			receiver variableName = #Halt ifFalse: [ ^ false ].
			method := Halt class compiledMethodAt: aNode selector ifAbsent: [ ^ false ].
			^ method pragmas
				anySatisfy: [ :each | each selector = #debuggerCompleteToSender ] ].
	^ false
]
