Class {
	#name : 'GtPharoMessageSendNode',
	#superclass : 'GtPharoValueNode',
	#instVars : [
		'receiver',
		'message'
	],
	#category : 'GToolkit-Pharo-Parser-Parser'
}

{ #category : 'generated' }
GtPharoMessageSendNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitMessageSend: self
]

{ #category : 'accessing' }
GtPharoMessageSendNode >> arguments [
	^ self message arguments
]

{ #category : 'testing' }
GtPharoMessageSendNode >> isMessageSend [
	^ true
]

{ #category : 'generated' }
GtPharoMessageSendNode >> message [
	^ message
]

{ #category : 'generated' }
GtPharoMessageSendNode >> message: aGtPharoMessageNode [
	self message notNil ifTrue: [ self message parent: nil ].
	message := aGtPharoMessageNode.
	self message notNil ifTrue: [ self message parent: self ]
]

{ #category : 'accessing' }
GtPharoMessageSendNode >> messageReceiver [
	leftParens notEmpty
		ifTrue: [ ^ self ].
	^ message messageReceiver
]

{ #category : 'testing' }
GtPharoMessageSendNode >> needsParenthesisForKeyword [
	^ true
]

{ #category : 'generated' }
GtPharoMessageSendNode >> nodeVariables [
	^ #(#receiver #message)
]

{ #category : 'generated' }
GtPharoMessageSendNode >> receiver [
	^ receiver
]

{ #category : 'generated' }
GtPharoMessageSendNode >> receiver: aGtPharoValueNode [
	self receiver notNil ifTrue: [ self receiver parent: nil ].
	receiver := aGtPharoValueNode.
	self receiver notNil ifTrue: [ self receiver parent: self ]
]

{ #category : 'accessing' }
GtPharoMessageSendNode >> selector [
	^ self message selector
]

{ #category : 'accessing' }
GtPharoMessageSendNode >> selectorParts [
	^ self message selectorParts
]
