Trait {
	#name : #TGtWithPharoFilteredStreamingMethodsCoder,
	#instVars : [
		'pharoFilteredStreamingMethodsCoder'
	],
	#category : #'GToolkit-Pharo-Coder-Coders'
}

{ #category : #'api - pharo filtered streaming methods coder' }
TGtWithPharoFilteredStreamingMethodsCoder >> hasPharoFilteredStreamingMethodsCoder [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #filteredStreamingMethodsCoder>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ pharoFilteredStreamingMethodsCoder notNil
]

{ #category : #'api - pharo filtered streaming methods coder' }
TGtWithPharoFilteredStreamingMethodsCoder >> onPharoFilteredStreamingMethodsCoderChanged [
	"Is sent when a new pharoFilteredStreamingMethodsCoder is assigned to the receiver.
	Note: #onPharoFilteredStreamingMethodsCoderChanged is sent before #subscribeToPharoFilteredStreamingMethodsCoder
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoFilteredStreamingMethodsCoderChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - pharo filtered streaming methods coder' }
TGtWithPharoFilteredStreamingMethodsCoder >> onPostPharoFilteredStreamingMethodsCoderChanged [
	"I am an optional hook method that is sent after #subscribeToPharoFilteredStreamingMethodsCoder.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - pharo filtered streaming methods coder' }
TGtWithPharoFilteredStreamingMethodsCoder >> pharoFilteredStreamingMethodsCoder [
	"Return a not-null pharoFilteredStreamingMethodsCoder assigned to the receiver"
	<modelGetter: #filteredStreamingMethodsCoder>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ pharoFilteredStreamingMethodsCoder notNil ]
		description: [ 'pharoFilteredStreamingMethodsCoder should be initialized' ].

	^ pharoFilteredStreamingMethodsCoder
]

{ #category : #'api - pharo filtered streaming methods coder' }
TGtWithPharoFilteredStreamingMethodsCoder >> pharoFilteredStreamingMethodsCoder: aPharoFilteredStreamingMethodsCoder [
	"Set a not-null pharoFilteredStreamingMethodsCoder assigned to the receiver"
	<modelSetter: #filteredStreamingMethodsCoder>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aPharoFilteredStreamingMethodsCoder notNil ]
		description: [ 'pharoFilteredStreamingMethodsCoder must not be nil' ].

	pharoFilteredStreamingMethodsCoder == aPharoFilteredStreamingMethodsCoder
		ifTrue: [ ^ self ].

	pharoFilteredStreamingMethodsCoder ifNotNil: [ self unsubscribeFromPharoFilteredStreamingMethodsCoder ].
	pharoFilteredStreamingMethodsCoder := aPharoFilteredStreamingMethodsCoder.

	self onPharoFilteredStreamingMethodsCoderChanged.
	self subscribeToPharoFilteredStreamingMethodsCoder.
	self onPostPharoFilteredStreamingMethodsCoderChanged
]

{ #category : #'api - pharo filtered streaming methods coder' }
TGtWithPharoFilteredStreamingMethodsCoder >> subscribeToPharoFilteredStreamingMethodsCoder [
	"Is sent after a new pharoFilteredStreamingMethodsCoder is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromPharoFilteredStreamingMethodsCoder if the receiver subscribes to them"
	<modelSubscriber: #filteredStreamingMethodsCoder>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - pharo filtered streaming methods coder' }
TGtWithPharoFilteredStreamingMethodsCoder >> unsubscribeFromPharoFilteredStreamingMethodsCoder [
	"Is sent before a new pharoFilteredStreamingMethodsCoder is assigned to the receiver.
	Objects that subscribe to pharoFilteredStreamingMethodsCoder are required to implement this method."
	<modelUnsubscriber: #filteredStreamingMethodsCoder>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
