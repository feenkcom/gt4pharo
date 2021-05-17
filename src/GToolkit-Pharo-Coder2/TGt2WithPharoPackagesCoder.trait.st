Trait {
	#name : #TGt2WithPharoPackagesCoder,
	#instVars : [
		'pharoPackagesCoder'
	],
	#category : #'GToolkit-Pharo-Coder2-Support'
}

{ #category : #'api - pharo packages coder' }
TGt2WithPharoPackagesCoder >> hasPharoPackagesCoder [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #packages>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ pharoPackagesCoder notNil
]

{ #category : #'api - pharo packages coder' }
TGt2WithPharoPackagesCoder >> onPharoPackagesCoderChanged [
	"Is sent when a new pharoPackagesCoder is assigned to the receiver.
	Note: #onPharoPackagesCoderChanged is sent before #subscribeToPharoPackagesCoder
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoPackagesCoderChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - pharo packages coder' }
TGt2WithPharoPackagesCoder >> onPostPharoPackagesCoderChanged [
	"I am an optional hook method that is sent after #subscribeToPharoPackagesCoder.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - pharo packages coder' }
TGt2WithPharoPackagesCoder >> pharoPackagesCoder [
	"Return a not-null pharoPackagesCoder assigned to the receiver"
	<modelGetter: #packages>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ pharoPackagesCoder notNil ]
		description: [ 'pharoPackagesCoder should be initialized' ].

	^ pharoPackagesCoder
]

{ #category : #'api - pharo packages coder' }
TGt2WithPharoPackagesCoder >> pharoPackagesCoder: aPharoPackagesCoder [
	"Set a not-null pharoPackagesCoder assigned to the receiver"
	<modelSetter: #packages>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aPharoPackagesCoder notNil ]
		description: [ 'pharoPackagesCoder must not be nil' ].

	pharoPackagesCoder == aPharoPackagesCoder
		ifTrue: [ ^ self ].

	pharoPackagesCoder ifNotNil: [ self unsubscribeFromPharoPackagesCoder ].
	pharoPackagesCoder := aPharoPackagesCoder.

	self onPharoPackagesCoderChanged.
	self subscribeToPharoPackagesCoder.
	self onPostPharoPackagesCoderChanged
]

{ #category : #'api - pharo packages coder' }
TGt2WithPharoPackagesCoder >> subscribeToPharoPackagesCoder [
	"Is sent after a new pharoPackagesCoder is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromPharoPackagesCoder if the receiver subscribes to them"
	<modelSubscriber: #packages>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - pharo packages coder' }
TGt2WithPharoPackagesCoder >> unsubscribeFromPharoPackagesCoder [
	"Is sent before a new pharoPackagesCoder is assigned to the receiver.
	Objects that subscribe to pharoPackagesCoder are required to implement this method."
	<modelUnsubscriber: #packages>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
