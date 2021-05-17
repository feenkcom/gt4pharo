Trait {
	#name : #TGt2WithPharoTagCoder,
	#instVars : [
		'pharoTagCoder'
	],
	#category : #'GToolkit-Pharo-Coder2-Support'
}

{ #category : #'api - pharo tag coder' }
TGt2WithPharoTagCoder >> hasPharoTagCoder [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #tag>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ pharoTagCoder notNil
]

{ #category : #'api - pharo tag coder' }
TGt2WithPharoTagCoder >> onPharoTagCoderChanged [
	"Is sent when a new pharoTagCoder is assigned to the receiver.
	Note: #onPharoTagCoderChanged is sent before #subscribeToPharoTagCoder
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoTagCoderChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - pharo tag coder' }
TGt2WithPharoTagCoder >> onPostPharoTagCoderChanged [
	"I am an optional hook method that is sent after #subscribeToPharoTagCoder.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - pharo tag coder' }
TGt2WithPharoTagCoder >> pharoTagCoder [
	"Return a not-null pharoTagCoder assigned to the receiver"
	<modelGetter: #tag>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ pharoTagCoder notNil ]
		description: [ 'pharoTagCoder should be initialized' ].

	^ pharoTagCoder
]

{ #category : #'api - pharo tag coder' }
TGt2WithPharoTagCoder >> pharoTagCoder: aPharoTagCoder [
	"Set a not-null pharoTagCoder assigned to the receiver"
	<modelSetter: #tag>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aPharoTagCoder notNil ]
		description: [ 'pharoTagCoder must not be nil' ].

	pharoTagCoder == aPharoTagCoder
		ifTrue: [ ^ self ].

	pharoTagCoder ifNotNil: [ self unsubscribeFromPharoTagCoder ].
	pharoTagCoder := aPharoTagCoder.

	self onPharoTagCoderChanged.
	self subscribeToPharoTagCoder.
	self onPostPharoTagCoderChanged
]

{ #category : #'api - pharo tag coder' }
TGt2WithPharoTagCoder >> subscribeToPharoTagCoder [
	"Is sent after a new pharoTagCoder is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromPharoTagCoder if the receiver subscribes to them"
	<modelSubscriber: #tag>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - pharo tag coder' }
TGt2WithPharoTagCoder >> unsubscribeFromPharoTagCoder [
	"Is sent before a new pharoTagCoder is assigned to the receiver.
	Objects that subscribe to pharoTagCoder are required to implement this method."
	<modelUnsubscriber: #tag>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
