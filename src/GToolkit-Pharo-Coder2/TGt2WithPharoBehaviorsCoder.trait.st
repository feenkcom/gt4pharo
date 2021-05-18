Trait {
	#name : #TGt2WithPharoBehaviorsCoder,
	#instVars : [
		'pharoBehaviorsCoder'
	],
	#category : #'GToolkit-Pharo-Coder2-Support'
}

{ #category : #'api - pharo behaviors coder' }
TGt2WithPharoBehaviorsCoder >> hasPharoBehaviorsCoder [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #behaviors>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ pharoBehaviorsCoder notNil
]

{ #category : #'api - pharo behaviors coder' }
TGt2WithPharoBehaviorsCoder >> onPharoBehaviorsCoderChanged [
	"Is sent when a new pharoBehaviorsCoder is assigned to the receiver.
	Note: #onPharoBehaviorsCoderChanged is sent before #subscribeToPharoBehaviorsCoder
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoBehaviorsCoderChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - pharo behaviors coder' }
TGt2WithPharoBehaviorsCoder >> onPostPharoBehaviorsCoderChanged [
	"I am an optional hook method that is sent after #subscribeToPharoBehaviorsCoder.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - pharo behaviors coder' }
TGt2WithPharoBehaviorsCoder >> pharoBehaviorsCoder [
	"Return a not-null pharoBehaviorsCoder assigned to the receiver"
	<modelGetter: #behaviors>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ pharoBehaviorsCoder notNil ]
		description: [ 'pharoBehaviorsCoder should be initialized' ].

	^ pharoBehaviorsCoder
]

{ #category : #'api - pharo behaviors coder' }
TGt2WithPharoBehaviorsCoder >> pharoBehaviorsCoder: aPharoBehaviorsCoder [
	"Set a not-null pharoBehaviorsCoder assigned to the receiver"
	<modelSetter: #behaviors>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aPharoBehaviorsCoder notNil ]
		description: [ 'pharoBehaviorsCoder must not be nil' ].

	pharoBehaviorsCoder == aPharoBehaviorsCoder
		ifTrue: [ ^ self ].

	pharoBehaviorsCoder ifNotNil: [ self unsubscribeFromPharoBehaviorsCoder ].
	pharoBehaviorsCoder := aPharoBehaviorsCoder.

	self onPharoBehaviorsCoderChanged.
	self subscribeToPharoBehaviorsCoder.
	self onPostPharoBehaviorsCoderChanged
]

{ #category : #'api - pharo behaviors coder' }
TGt2WithPharoBehaviorsCoder >> subscribeToPharoBehaviorsCoder [
	"Is sent after a new pharoBehaviorsCoder is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromPharoBehaviorsCoder if the receiver subscribes to them"
	<modelSubscriber: #behaviors>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - pharo behaviors coder' }
TGt2WithPharoBehaviorsCoder >> unsubscribeFromPharoBehaviorsCoder [
	"Is sent before a new pharoBehaviorsCoder is assigned to the receiver.
	Objects that subscribe to pharoBehaviorsCoder are required to implement this method."
	<modelUnsubscriber: #behaviors>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
