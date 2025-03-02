Class {
	#name : #GtSendNotUsedAdvice,
	#superclass : #GtMethodAdvice,
	#category : #'GToolkit-Pharo-Coder-AddOns-MethodAdvices'
}

{ #category : #testing }
GtSendNotUsedAdvice class >> isAbstract [
	^ self = GtSendNotUsedAdvice
]

{ #category : #private }
GtSendNotUsedAdvice >> fixItActionsForNode: aNode coderModel: coderModel [
	^ {GtRemoveMessageFixItAction forCoder: coderModel node: aNode}
]

{ #category : #accessing }
GtSendNotUsedAdvice >> matches: aNode from: aCriticRunner [
	aNode isErrorNode ifTrue: [ ^ false ].
	aNode isMessage ifFalse: [ ^ false ].
	aNode isUsed ifTrue: [ ^ false ].
	^ self selectors includes: aNode selector
]

{ #category : #accessing }
GtSendNotUsedAdvice >> name [
	^ 'Message send is not used'
]

{ #category : #enumerating }
GtSendNotUsedAdvice >> potentialFilter [
	^ (self selectors
		inject: GtSearchNullFilter new
		into: [ :sum :each | sum | each gtReferences ]) asAsyncStream
]

{ #category : #accessing }
GtSendNotUsedAdvice >> selectors [
	self subclassResponsibility
]
