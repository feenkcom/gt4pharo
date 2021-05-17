Trait {
	#name : #TGt2WithPharoPackageCoderNavigationViewModel,
	#instVars : [
		'pharoPackageCoderNavigationViewModel'
	],
	#category : #'GToolkit-Pharo-Coder2-Navigation - Support'
}

{ #category : #'api - pharo package coder navigation view model' }
TGt2WithPharoPackageCoderNavigationViewModel >> hasPharoPackageCoderNavigationViewModel [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #package>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ pharoPackageCoderNavigationViewModel notNil
]

{ #category : #'api - pharo package coder navigation view model' }
TGt2WithPharoPackageCoderNavigationViewModel >> onPharoPackageCoderNavigationViewModelChanged [
	"Is sent when a new pharoPackageCoderNavigationViewModel is assigned to the receiver.
	Note: #onPharoPackageCoderNavigationViewModelChanged is sent before #subscribeToPharoPackageCoderNavigationViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoPackageCoderNavigationViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - pharo package coder navigation view model' }
TGt2WithPharoPackageCoderNavigationViewModel >> onPostPharoPackageCoderNavigationViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToPharoPackageCoderNavigationViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - pharo package coder navigation view model' }
TGt2WithPharoPackageCoderNavigationViewModel >> pharoPackageCoderNavigationViewModel [
	"Return a not-null pharoPackageCoderNavigationViewModel assigned to the receiver"
	<modelGetter: #package>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ pharoPackageCoderNavigationViewModel notNil ]
		description: [ 'pharoPackageCoderNavigationViewModel should be initialized' ].

	^ pharoPackageCoderNavigationViewModel
]

{ #category : #'api - pharo package coder navigation view model' }
TGt2WithPharoPackageCoderNavigationViewModel >> pharoPackageCoderNavigationViewModel: aPharoPackageCoderNavigationViewModel [
	"Set a not-null pharoPackageCoderNavigationViewModel assigned to the receiver"
	<modelSetter: #package>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aPharoPackageCoderNavigationViewModel notNil ]
		description: [ 'pharoPackageCoderNavigationViewModel must not be nil' ].

	pharoPackageCoderNavigationViewModel == aPharoPackageCoderNavigationViewModel
		ifTrue: [ ^ self ].

	pharoPackageCoderNavigationViewModel ifNotNil: [ self unsubscribeFromPharoPackageCoderNavigationViewModel ].
	pharoPackageCoderNavigationViewModel := aPharoPackageCoderNavigationViewModel.

	self onPharoPackageCoderNavigationViewModelChanged.
	self subscribeToPharoPackageCoderNavigationViewModel.
	self onPostPharoPackageCoderNavigationViewModelChanged
]

{ #category : #'api - pharo package coder navigation view model' }
TGt2WithPharoPackageCoderNavigationViewModel >> subscribeToPharoPackageCoderNavigationViewModel [
	"Is sent after a new pharoPackageCoderNavigationViewModel is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromPharoPackageCoderNavigationViewModel if the receiver subscribes to them"
	<modelSubscriber: #package>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - pharo package coder navigation view model' }
TGt2WithPharoPackageCoderNavigationViewModel >> unsubscribeFromPharoPackageCoderNavigationViewModel [
	"Is sent before a new pharoPackageCoderNavigationViewModel is assigned to the receiver.
	Objects that subscribe to pharoPackageCoderNavigationViewModel are required to implement this method."
	<modelUnsubscriber: #package>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
