Trait {
	#name : #TGt2WithPharoProtocolCoder,
	#instVars : [
		'pharoProtocolCoder'
	],
	#category : #'GToolkit-Pharo-Coder2-Support'
}

{ #category : #'api - pharo protocol coder' }
TGt2WithPharoProtocolCoder >> hasPharoProtocolCoder [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #protocol>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ pharoProtocolCoder notNil
]

{ #category : #'api - pharo protocol coder' }
TGt2WithPharoProtocolCoder >> onPharoProtocolCoderChanged [
	"Is sent when a new pharoProtocolCoder is assigned to the receiver.
	Note: #onPharoProtocolCoderChanged is sent before #subscribeToPharoProtocolCoder
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoProtocolCoderChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - pharo protocol coder' }
TGt2WithPharoProtocolCoder >> onPostPharoProtocolCoderChanged [
	"I am an optional hook method that is sent after #subscribeToPharoProtocolCoder.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - pharo protocol coder' }
TGt2WithPharoProtocolCoder >> pharoProtocolCoder [
	"Return a not-null pharoProtocolCoder assigned to the receiver"
	<modelGetter: #protocol>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ pharoProtocolCoder notNil ]
		description: [ 'pharoProtocolCoder should be initialized' ].

	^ pharoProtocolCoder
]

{ #category : #'api - pharo protocol coder' }
TGt2WithPharoProtocolCoder >> pharoProtocolCoder: aPharoProtocolCoder [
	"Set a not-null pharoProtocolCoder assigned to the receiver"
	<modelSetter: #protocol>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aPharoProtocolCoder notNil ]
		description: [ 'pharoProtocolCoder must not be nil' ].

	pharoProtocolCoder == aPharoProtocolCoder
		ifTrue: [ ^ self ].

	pharoProtocolCoder ifNotNil: [ self unsubscribeFromPharoProtocolCoder ].
	pharoProtocolCoder := aPharoProtocolCoder.

	self onPharoProtocolCoderChanged.
	self subscribeToPharoProtocolCoder.
	self onPostPharoProtocolCoderChanged
]

{ #category : #'api - pharo protocol coder' }
TGt2WithPharoProtocolCoder >> subscribeToPharoProtocolCoder [
	"Is sent after a new pharoProtocolCoder is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromPharoProtocolCoder if the receiver subscribes to them"
	<modelSubscriber: #protocol>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - pharo protocol coder' }
TGt2WithPharoProtocolCoder >> unsubscribeFromPharoProtocolCoder [
	"Is sent before a new pharoProtocolCoder is assigned to the receiver.
	Objects that subscribe to pharoProtocolCoder are required to implement this method."
	<modelUnsubscriber: #protocol>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
