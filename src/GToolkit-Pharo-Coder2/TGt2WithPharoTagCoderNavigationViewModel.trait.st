Trait {
	#name : #TGt2WithPharoTagCoderNavigationViewModel,
	#instVars : [
		'pharoTagCoderNavigationViewModel'
	],
	#category : #'GToolkit-Pharo-Coder2-Navigation - Support'
}

{ #category : #'api - pharo tag coder navigation view model' }
TGt2WithPharoTagCoderNavigationViewModel >> hasPharoTagCoderNavigationViewModel [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #tag>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ pharoTagCoderNavigationViewModel notNil
]

{ #category : #'api - pharo tag coder navigation view model' }
TGt2WithPharoTagCoderNavigationViewModel >> onPharoTagCoderNavigationViewModelChanged [
	"Is sent when a new pharoTagCoderNavigationViewModel is assigned to the receiver.
	Note: #onPharoTagCoderNavigationViewModelChanged is sent before #subscribeToPharoTagCoderNavigationViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoTagCoderNavigationViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - pharo tag coder navigation view model' }
TGt2WithPharoTagCoderNavigationViewModel >> onPostPharoTagCoderNavigationViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToPharoTagCoderNavigationViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - pharo tag coder navigation view model' }
TGt2WithPharoTagCoderNavigationViewModel >> pharoTagCoderNavigationViewModel [
	"Return a not-null pharoTagCoderNavigationViewModel assigned to the receiver"
	<modelGetter: #tag>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ pharoTagCoderNavigationViewModel notNil ]
		description: [ 'pharoTagCoderNavigationViewModel should be initialized' ].

	^ pharoTagCoderNavigationViewModel
]

{ #category : #'api - pharo tag coder navigation view model' }
TGt2WithPharoTagCoderNavigationViewModel >> pharoTagCoderNavigationViewModel: aPharoTagCoderNavigationViewModel [
	"Set a not-null pharoTagCoderNavigationViewModel assigned to the receiver"
	<modelSetter: #tag>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aPharoTagCoderNavigationViewModel notNil ]
		description: [ 'pharoTagCoderNavigationViewModel must not be nil' ].

	pharoTagCoderNavigationViewModel == aPharoTagCoderNavigationViewModel
		ifTrue: [ ^ self ].

	pharoTagCoderNavigationViewModel ifNotNil: [ self unsubscribeFromPharoTagCoderNavigationViewModel ].
	pharoTagCoderNavigationViewModel := aPharoTagCoderNavigationViewModel.

	self onPharoTagCoderNavigationViewModelChanged.
	self subscribeToPharoTagCoderNavigationViewModel.
	self onPostPharoTagCoderNavigationViewModelChanged
]

{ #category : #'api - pharo tag coder navigation view model' }
TGt2WithPharoTagCoderNavigationViewModel >> subscribeToPharoTagCoderNavigationViewModel [
	"Is sent after a new pharoTagCoderNavigationViewModel is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromPharoTagCoderNavigationViewModel if the receiver subscribes to them"
	<modelSubscriber: #tag>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - pharo tag coder navigation view model' }
TGt2WithPharoTagCoderNavigationViewModel >> unsubscribeFromPharoTagCoderNavigationViewModel [
	"Is sent before a new pharoTagCoderNavigationViewModel is assigned to the receiver.
	Objects that subscribe to pharoTagCoderNavigationViewModel are required to implement this method."
	<modelUnsubscriber: #tag>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
