Trait {
	#name : #TGt2WithPharoTagsCoder,
	#instVars : [
		'pharoTagsCoder'
	],
	#category : #'GToolkit-Pharo-Coder2-Support'
}

{ #category : #'api - pharo tags coder' }
TGt2WithPharoTagsCoder >> hasPharoTagsCoder [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #tags>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ pharoTagsCoder notNil
]

{ #category : #'api - pharo tags coder' }
TGt2WithPharoTagsCoder >> onPharoTagsCoderChanged [
	"Is sent when a new pharoTagsCoder is assigned to the receiver.
	Note: #onPharoTagsCoderChanged is sent before #subscribeToPharoTagsCoder
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoTagsCoderChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - pharo tags coder' }
TGt2WithPharoTagsCoder >> onPostPharoTagsCoderChanged [
	"I am an optional hook method that is sent after #subscribeToPharoTagsCoder.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - pharo tags coder' }
TGt2WithPharoTagsCoder >> pharoTagsCoder [
	"Return a not-null pharoTagsCoder assigned to the receiver"
	<modelGetter: #tags>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ pharoTagsCoder notNil ]
		description: [ 'pharoTagsCoder should be initialized' ].

	^ pharoTagsCoder
]

{ #category : #'api - pharo tags coder' }
TGt2WithPharoTagsCoder >> pharoTagsCoder: aPharoTagsCoder [
	"Set a not-null pharoTagsCoder assigned to the receiver"
	<modelSetter: #tags>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aPharoTagsCoder notNil ]
		description: [ 'pharoTagsCoder must not be nil' ].

	pharoTagsCoder == aPharoTagsCoder
		ifTrue: [ ^ self ].

	pharoTagsCoder ifNotNil: [ self unsubscribeFromPharoTagsCoder ].
	pharoTagsCoder := aPharoTagsCoder.

	self onPharoTagsCoderChanged.
	self subscribeToPharoTagsCoder.
	self onPostPharoTagsCoderChanged
]

{ #category : #'api - pharo tags coder' }
TGt2WithPharoTagsCoder >> subscribeToPharoTagsCoder [
	"Is sent after a new pharoTagsCoder is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromPharoTagsCoder if the receiver subscribes to them"
	<modelSubscriber: #tags>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - pharo tags coder' }
TGt2WithPharoTagsCoder >> unsubscribeFromPharoTagsCoder [
	"Is sent before a new pharoTagsCoder is assigned to the receiver.
	Objects that subscribe to pharoTagsCoder are required to implement this method."
	<modelUnsubscriber: #tags>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
