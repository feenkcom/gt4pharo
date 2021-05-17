Trait {
	#name : #TGt2WithPharoPackageCoder,
	#instVars : [
		'pharoPackageCoder'
	],
	#category : #'GToolkit-Pharo-Coder2-Support'
}

{ #category : #'api - pharo package coder' }
TGt2WithPharoPackageCoder >> hasPharoPackageCoder [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #package>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ pharoPackageCoder notNil
]

{ #category : #'api - pharo package coder' }
TGt2WithPharoPackageCoder >> onPharoPackageCoderChanged [
	"Is sent when a new pharoPackageCoder is assigned to the receiver.
	Note: #onPharoPackageCoderChanged is sent before #subscribeToPharoPackageCoder
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoPackageCoderChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - pharo package coder' }
TGt2WithPharoPackageCoder >> onPostPharoPackageCoderChanged [
	"I am an optional hook method that is sent after #subscribeToPharoPackageCoder.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - pharo package coder' }
TGt2WithPharoPackageCoder >> pharoPackageCoder [
	"Return a not-null pharoPackageCoder assigned to the receiver"
	<modelGetter: #package>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ pharoPackageCoder notNil ]
		description: [ 'pharoPackageCoder should be initialized' ].

	^ pharoPackageCoder
]

{ #category : #'api - pharo package coder' }
TGt2WithPharoPackageCoder >> pharoPackageCoder: aPharoPackageCoder [
	"Set a not-null pharoPackageCoder assigned to the receiver"
	<modelSetter: #package>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aPharoPackageCoder notNil ]
		description: [ 'pharoPackageCoder must not be nil' ].

	pharoPackageCoder == aPharoPackageCoder
		ifTrue: [ ^ self ].

	pharoPackageCoder ifNotNil: [ self unsubscribeFromPharoPackageCoder ].
	pharoPackageCoder := aPharoPackageCoder.

	self onPharoPackageCoderChanged.
	self subscribeToPharoPackageCoder.
	self onPostPharoPackageCoderChanged
]

{ #category : #'api - pharo package coder' }
TGt2WithPharoPackageCoder >> subscribeToPharoPackageCoder [
	"Is sent after a new pharoPackageCoder is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromPharoPackageCoder if the receiver subscribes to them"
	<modelSubscriber: #package>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - pharo package coder' }
TGt2WithPharoPackageCoder >> unsubscribeFromPharoPackageCoder [
	"Is sent before a new pharoPackageCoder is assigned to the receiver.
	Objects that subscribe to pharoPackageCoder are required to implement this method."
	<modelUnsubscriber: #package>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
