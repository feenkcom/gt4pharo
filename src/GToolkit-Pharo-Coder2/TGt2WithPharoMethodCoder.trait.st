Trait {
	#name : #TGt2WithPharoMethodCoder,
	#instVars : [
		'pharoMethodCoder'
	],
	#category : #'GToolkit-Pharo-Coder2-Support'
}

{ #category : #'api - pharo method coder' }
TGt2WithPharoMethodCoder >> hasPharoMethodCoder [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #method>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ pharoMethodCoder notNil
]

{ #category : #'api - pharo method coder' }
TGt2WithPharoMethodCoder >> onPharoMethodCoderChanged [
	"Is sent when a new pharoMethodCoder is assigned to the receiver.
	Note: #onPharoMethodCoderChanged is sent before #subscribeToPharoMethodCoder
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoMethodCoderChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - pharo method coder' }
TGt2WithPharoMethodCoder >> onPostPharoMethodCoderChanged [
	"I am an optional hook method that is sent after #subscribeToPharoMethodCoder.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - pharo method coder' }
TGt2WithPharoMethodCoder >> pharoMethodCoder [
	"Return a not-null pharoMethodCoder assigned to the receiver"
	<modelGetter: #method>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ pharoMethodCoder notNil ]
		description: [ 'pharoMethodCoder should be initialized' ].

	^ pharoMethodCoder
]

{ #category : #'api - pharo method coder' }
TGt2WithPharoMethodCoder >> pharoMethodCoder: aPharoMethodCoder [
	"Set a not-null pharoMethodCoder assigned to the receiver"
	<modelSetter: #method>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aPharoMethodCoder notNil ]
		description: [ 'pharoMethodCoder must not be nil' ].

	pharoMethodCoder == aPharoMethodCoder
		ifTrue: [ ^ self ].

	pharoMethodCoder ifNotNil: [ self unsubscribeFromPharoMethodCoder ].
	pharoMethodCoder := aPharoMethodCoder.

	self onPharoMethodCoderChanged.
	self subscribeToPharoMethodCoder.
	self onPostPharoMethodCoderChanged
]

{ #category : #'api - pharo method coder' }
TGt2WithPharoMethodCoder >> subscribeToPharoMethodCoder [
	"Is sent after a new pharoMethodCoder is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromPharoMethodCoder if the receiver subscribes to them"
	<modelSubscriber: #method>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - pharo method coder' }
TGt2WithPharoMethodCoder >> unsubscribeFromPharoMethodCoder [
	"Is sent before a new pharoMethodCoder is assigned to the receiver.
	Objects that subscribe to pharoMethodCoder are required to implement this method."
	<modelUnsubscriber: #method>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
