Class {
	#name : #GtHaltAdvice,
	#superclass : #GtMethodAdvice,
	#category : #'GToolkit-Pharo-Coder-AddOns-MethodAdvices'
}

{ #category : #accessing }
GtHaltAdvice >> description [
	^ 'Debugging code is in method and should be removed before it is released.'
]

{ #category : #accessing }
GtHaltAdvice >> haltSelectors [
	<gtIgnoreConstraint: #GtSendersOfHaltSelectorsInGtPackagesConstraint>
	
	^ #(halt haltOnce haltIf:)
]

{ #category : #accessing }
GtHaltAdvice >> highlightPositionsFor: aSmaCCNode [
	^ {aSmaCCNode sourceInterval}
]

{ #category : #testing }
GtHaltAdvice >> includeFixIt [
	^ false
]

{ #category : #accessing }
GtHaltAdvice >> matches: aNode from: aCriticRunner [
	aNode isMessage ifTrue: [ ^ self haltSelectors includes: aNode selector ].
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

{ #category : #accessing }
GtHaltAdvice >> name [
	^ 'Debugging code in method'
]

{ #category : #enumerating }
GtHaltAdvice >> potentialFilter [
	^ ((self haltSelectors
		inject: GtSearchNullFilter new
		into: [ :sum :each | sum | each gtReferences ]) | Halt gtReferences)
		asAsyncStream
]
