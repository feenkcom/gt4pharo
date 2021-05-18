Trait {
	#name : #TGt2WithPharoBehaviorCoder,
	#instVars : [
		'pharoBehaviorCoder'
	],
	#category : #'GToolkit-Pharo-Coder2-Support'
}

{ #category : #'api - pharo behavior coder' }
TGt2WithPharoBehaviorCoder >> hasPharoBehaviorCoder [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #behavior>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ pharoBehaviorCoder notNil
]

{ #category : #'api - pharo behavior coder' }
TGt2WithPharoBehaviorCoder >> onPharoBehaviorCoderChanged [
	"Is sent when a new pharoBehaviorCoder is assigned to the receiver.
	Note: #onPharoBehaviorCoderChanged is sent before #subscribeToPharoBehaviorCoder
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoBehaviorCoderChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - pharo behavior coder' }
TGt2WithPharoBehaviorCoder >> onPostPharoBehaviorCoderChanged [
	"I am an optional hook method that is sent after #subscribeToPharoBehaviorCoder.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - pharo behavior coder' }
TGt2WithPharoBehaviorCoder >> pharoBehaviorCoder [
	"Return a not-null pharoBehaviorCoder assigned to the receiver"
	<modelGetter: #behavior>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ pharoBehaviorCoder notNil ]
		description: [ 'pharoBehaviorCoder should be initialized' ].

	^ pharoBehaviorCoder
]

{ #category : #'api - pharo behavior coder' }
TGt2WithPharoBehaviorCoder >> pharoBehaviorCoder: aPharoBehaviorCoder [
	"Set a not-null pharoBehaviorCoder assigned to the receiver"
	<modelSetter: #behavior>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aPharoBehaviorCoder notNil ]
		description: [ 'pharoBehaviorCoder must not be nil' ].

	pharoBehaviorCoder == aPharoBehaviorCoder
		ifTrue: [ ^ self ].

	pharoBehaviorCoder ifNotNil: [ self unsubscribeFromPharoBehaviorCoder ].
	pharoBehaviorCoder := aPharoBehaviorCoder.

	self onPharoBehaviorCoderChanged.
	self subscribeToPharoBehaviorCoder.
	self onPostPharoBehaviorCoderChanged
]

{ #category : #'api - pharo behavior coder' }
TGt2WithPharoBehaviorCoder >> subscribeToPharoBehaviorCoder [
	"Is sent after a new pharoBehaviorCoder is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromPharoBehaviorCoder if the receiver subscribes to them"
	<modelSubscriber: #behavior>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - pharo behavior coder' }
TGt2WithPharoBehaviorCoder >> unsubscribeFromPharoBehaviorCoder [
	"Is sent before a new pharoBehaviorCoder is assigned to the receiver.
	Objects that subscribe to pharoBehaviorCoder are required to implement this method."
	<modelUnsubscriber: #behavior>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
