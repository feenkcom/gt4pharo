Trait {
	#name : #TGt2WithPharoPackageCoderViewModel,
	#instVars : [
		'pharoPackageCoderViewModel'
	],
	#category : #'GToolkit-Pharo-Coder2-Package Coder - Support'
}

{ #category : #'api - pharo package coder view model' }
TGt2WithPharoPackageCoderViewModel >> hasPharoPackageCoderViewModel [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #package>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ pharoPackageCoderViewModel notNil
]

{ #category : #'api - pharo package coder view model' }
TGt2WithPharoPackageCoderViewModel >> onPharoPackageCoderViewModelChanged [
	"Is sent when a new pharoPackageCoderViewModel is assigned to the receiver.
	Note: #onPharoPackageCoderViewModelChanged is sent before #subscribeToPharoPackageCoderViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoPackageCoderViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - pharo package coder view model' }
TGt2WithPharoPackageCoderViewModel >> onPostPharoPackageCoderViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToPharoPackageCoderViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - pharo package coder view model' }
TGt2WithPharoPackageCoderViewModel >> pharoPackageCoderViewModel [
	"Return a not-null pharoPackageCoderViewModel assigned to the receiver"
	<modelGetter: #package>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ pharoPackageCoderViewModel notNil ]
		description: [ 'pharoPackageCoderViewModel should be initialized' ].

	^ pharoPackageCoderViewModel
]

{ #category : #'api - pharo package coder view model' }
TGt2WithPharoPackageCoderViewModel >> pharoPackageCoderViewModel: aPharoPackageCoderViewModel [
	"Set a not-null pharoPackageCoderViewModel assigned to the receiver"
	<modelSetter: #package>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aPharoPackageCoderViewModel notNil ]
		description: [ 'pharoPackageCoderViewModel must not be nil' ].

	pharoPackageCoderViewModel == aPharoPackageCoderViewModel
		ifTrue: [ ^ self ].

	pharoPackageCoderViewModel ifNotNil: [ self unsubscribeFromPharoPackageCoderViewModel ].
	pharoPackageCoderViewModel := aPharoPackageCoderViewModel.

	self onPharoPackageCoderViewModelChanged.
	self subscribeToPharoPackageCoderViewModel.
	self onPostPharoPackageCoderViewModelChanged
]

{ #category : #'api - pharo package coder view model' }
TGt2WithPharoPackageCoderViewModel >> subscribeToPharoPackageCoderViewModel [
	"Is sent after a new pharoPackageCoderViewModel is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromPharoPackageCoderViewModel if the receiver subscribes to them"
	<modelSubscriber: #package>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - pharo package coder view model' }
TGt2WithPharoPackageCoderViewModel >> unsubscribeFromPharoPackageCoderViewModel [
	"Is sent before a new pharoPackageCoderViewModel is assigned to the receiver.
	Objects that subscribe to pharoPackageCoderViewModel are required to implement this method."
	<modelUnsubscriber: #package>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
