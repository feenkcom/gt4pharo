Trait {
	#name : #TGt2WithPharoProtocolsCoder,
	#instVars : [
		'pharoProtocolsCoder'
	],
	#category : #'GToolkit-Pharo-Coder2-Support'
}

{ #category : #'api - pharo protocols coder' }
TGt2WithPharoProtocolsCoder >> hasPharoProtocolsCoder [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #protocols>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ pharoProtocolsCoder notNil
]

{ #category : #'api - pharo protocols coder' }
TGt2WithPharoProtocolsCoder >> onPharoProtocolsCoderChanged [
	"Is sent when a new pharoProtocolsCoder is assigned to the receiver.
	Note: #onPharoProtocolsCoderChanged is sent before #subscribeToPharoProtocolsCoder
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoProtocolsCoderChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - pharo protocols coder' }
TGt2WithPharoProtocolsCoder >> onPostPharoProtocolsCoderChanged [
	"I am an optional hook method that is sent after #subscribeToPharoProtocolsCoder.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - pharo protocols coder' }
TGt2WithPharoProtocolsCoder >> pharoProtocolsCoder [
	"Return a not-null pharoProtocolsCoder assigned to the receiver"
	<modelGetter: #protocols>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ pharoProtocolsCoder notNil ]
		description: [ 'pharoProtocolsCoder should be initialized' ].

	^ pharoProtocolsCoder
]

{ #category : #'api - pharo protocols coder' }
TGt2WithPharoProtocolsCoder >> pharoProtocolsCoder: aPharoProtocolsCoder [
	"Set a not-null pharoProtocolsCoder assigned to the receiver"
	<modelSetter: #protocols>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aPharoProtocolsCoder notNil ]
		description: [ 'pharoProtocolsCoder must not be nil' ].

	pharoProtocolsCoder == aPharoProtocolsCoder
		ifTrue: [ ^ self ].

	pharoProtocolsCoder ifNotNil: [ self unsubscribeFromPharoProtocolsCoder ].
	pharoProtocolsCoder := aPharoProtocolsCoder.

	self onPharoProtocolsCoderChanged.
	self subscribeToPharoProtocolsCoder.
	self onPostPharoProtocolsCoderChanged
]

{ #category : #'api - pharo protocols coder' }
TGt2WithPharoProtocolsCoder >> subscribeToPharoProtocolsCoder [
	"Is sent after a new pharoProtocolsCoder is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromPharoProtocolsCoder if the receiver subscribes to them"
	<modelSubscriber: #protocols>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - pharo protocols coder' }
TGt2WithPharoProtocolsCoder >> unsubscribeFromPharoProtocolsCoder [
	"Is sent before a new pharoProtocolsCoder is assigned to the receiver.
	Objects that subscribe to pharoProtocolsCoder are required to implement this method."
	<modelUnsubscriber: #protocols>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
