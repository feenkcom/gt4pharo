Trait {
	#name : #TGt2WithPharoMethodsCoder,
	#instVars : [
		'pharoMethodsCoder'
	],
	#category : #'GToolkit-Pharo-Coder2-Support'
}

{ #category : #'api - pharo methods coder' }
TGt2WithPharoMethodsCoder >> hasPharoMethodsCoder [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #methods>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ pharoMethodsCoder notNil
]

{ #category : #'api - pharo methods coder' }
TGt2WithPharoMethodsCoder >> onPharoMethodsCoderChanged [
	"Is sent when a new pharoMethodsCoder is assigned to the receiver.
	Note: #onPharoMethodsCoderChanged is sent before #subscribeToPharoMethodsCoder
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoMethodsCoderChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - pharo methods coder' }
TGt2WithPharoMethodsCoder >> onPostPharoMethodsCoderChanged [
	"I am an optional hook method that is sent after #subscribeToPharoMethodsCoder.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - pharo methods coder' }
TGt2WithPharoMethodsCoder >> pharoMethodsCoder [
	"Return a not-null pharoMethodsCoder assigned to the receiver"
	<modelGetter: #methods>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ pharoMethodsCoder notNil ]
		description: [ 'pharoMethodsCoder should be initialized' ].

	^ pharoMethodsCoder
]

{ #category : #'api - pharo methods coder' }
TGt2WithPharoMethodsCoder >> pharoMethodsCoder: aPharoMethodsCoder [
	"Set a not-null pharoMethodsCoder assigned to the receiver"
	<modelSetter: #methods>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aPharoMethodsCoder notNil ]
		description: [ 'pharoMethodsCoder must not be nil' ].

	pharoMethodsCoder == aPharoMethodsCoder
		ifTrue: [ ^ self ].

	pharoMethodsCoder ifNotNil: [ self unsubscribeFromPharoMethodsCoder ].
	pharoMethodsCoder := aPharoMethodsCoder.

	self onPharoMethodsCoderChanged.
	self subscribeToPharoMethodsCoder.
	self onPostPharoMethodsCoderChanged
]

{ #category : #'api - pharo methods coder' }
TGt2WithPharoMethodsCoder >> subscribeToPharoMethodsCoder [
	"Is sent after a new pharoMethodsCoder is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromPharoMethodsCoder if the receiver subscribes to them"
	<modelSubscriber: #methods>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - pharo methods coder' }
TGt2WithPharoMethodsCoder >> unsubscribeFromPharoMethodsCoder [
	"Is sent before a new pharoMethodsCoder is assigned to the receiver.
	Objects that subscribe to pharoMethodsCoder are required to implement this method."
	<modelUnsubscriber: #methods>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
