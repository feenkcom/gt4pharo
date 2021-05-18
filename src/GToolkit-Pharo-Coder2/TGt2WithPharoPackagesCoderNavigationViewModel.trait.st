Trait {
	#name : #TGt2WithPharoPackagesCoderNavigationViewModel,
	#instVars : [
		'pharoPackagesCoderNavigationViewModel'
	],
	#category : #'GToolkit-Pharo-Coder2-Navigation - Support'
}

{ #category : #'api - pharo packages coder navigation view model' }
TGt2WithPharoPackagesCoderNavigationViewModel >> hasPharoPackagesCoderNavigationViewModel [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #packages>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ pharoPackagesCoderNavigationViewModel notNil
]

{ #category : #'api - pharo packages coder navigation view model' }
TGt2WithPharoPackagesCoderNavigationViewModel >> onPharoPackagesCoderNavigationViewModelChanged [
	"Is sent when a new pharoPackagesCoderNavigationViewModel is assigned to the receiver.
	Note: #onPharoPackagesCoderNavigationViewModelChanged is sent before #subscribeToPharoPackagesCoderNavigationViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoPackagesCoderNavigationViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - pharo packages coder navigation view model' }
TGt2WithPharoPackagesCoderNavigationViewModel >> onPostPharoPackagesCoderNavigationViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToPharoPackagesCoderNavigationViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - pharo packages coder navigation view model' }
TGt2WithPharoPackagesCoderNavigationViewModel >> pharoPackagesCoderNavigationViewModel [
	"Return a not-null pharoPackagesCoderNavigationViewModel assigned to the receiver"
	<modelGetter: #packages>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ pharoPackagesCoderNavigationViewModel notNil ]
		description: [ 'pharoPackagesCoderNavigationViewModel should be initialized' ].

	^ pharoPackagesCoderNavigationViewModel
]

{ #category : #'api - pharo packages coder navigation view model' }
TGt2WithPharoPackagesCoderNavigationViewModel >> pharoPackagesCoderNavigationViewModel: aPharoPackagesCoderNavigationViewModel [
	"Set a not-null pharoPackagesCoderNavigationViewModel assigned to the receiver"
	<modelSetter: #packages>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aPharoPackagesCoderNavigationViewModel notNil ]
		description: [ 'pharoPackagesCoderNavigationViewModel must not be nil' ].

	pharoPackagesCoderNavigationViewModel == aPharoPackagesCoderNavigationViewModel
		ifTrue: [ ^ self ].

	pharoPackagesCoderNavigationViewModel ifNotNil: [ self unsubscribeFromPharoPackagesCoderNavigationViewModel ].
	pharoPackagesCoderNavigationViewModel := aPharoPackagesCoderNavigationViewModel.

	self onPharoPackagesCoderNavigationViewModelChanged.
	self subscribeToPharoPackagesCoderNavigationViewModel.
	self onPostPharoPackagesCoderNavigationViewModelChanged
]

{ #category : #'api - pharo packages coder navigation view model' }
TGt2WithPharoPackagesCoderNavigationViewModel >> subscribeToPharoPackagesCoderNavigationViewModel [
	"Is sent after a new pharoPackagesCoderNavigationViewModel is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromPharoPackagesCoderNavigationViewModel if the receiver subscribes to them"
	<modelSubscriber: #packages>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - pharo packages coder navigation view model' }
TGt2WithPharoPackagesCoderNavigationViewModel >> unsubscribeFromPharoPackagesCoderNavigationViewModel [
	"Is sent before a new pharoPackagesCoderNavigationViewModel is assigned to the receiver.
	Objects that subscribe to pharoPackagesCoderNavigationViewModel are required to implement this method."
	<modelUnsubscriber: #packages>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
