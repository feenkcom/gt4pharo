Trait {
	#name : #TGt2WithPharoTagsCoderNavigationViewModel,
	#instVars : [
		'pharoTagsCoderNavigationViewModel'
	],
	#category : #'GToolkit-Pharo-Coder2-Navigation - Support'
}

{ #category : #'api - pharo tags coder navigation view model' }
TGt2WithPharoTagsCoderNavigationViewModel >> hasPharoTagsCoderNavigationViewModel [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #tags>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ pharoTagsCoderNavigationViewModel notNil
]

{ #category : #'api - pharo tags coder navigation view model' }
TGt2WithPharoTagsCoderNavigationViewModel >> onPharoTagsCoderNavigationViewModelChanged [
	"Is sent when a new pharoTagsCoderNavigationViewModel is assigned to the receiver.
	Note: #onPharoTagsCoderNavigationViewModelChanged is sent before #subscribeToPharoTagsCoderNavigationViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoTagsCoderNavigationViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - pharo tags coder navigation view model' }
TGt2WithPharoTagsCoderNavigationViewModel >> onPostPharoTagsCoderNavigationViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToPharoTagsCoderNavigationViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - pharo tags coder navigation view model' }
TGt2WithPharoTagsCoderNavigationViewModel >> pharoTagsCoderNavigationViewModel [
	"Return a not-null pharoTagsCoderNavigationViewModel assigned to the receiver"
	<modelGetter: #tags>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ pharoTagsCoderNavigationViewModel notNil ]
		description: [ 'pharoTagsCoderNavigationViewModel should be initialized' ].

	^ pharoTagsCoderNavigationViewModel
]

{ #category : #'api - pharo tags coder navigation view model' }
TGt2WithPharoTagsCoderNavigationViewModel >> pharoTagsCoderNavigationViewModel: aPharoTagsCoderNavigationViewModel [
	"Set a not-null pharoTagsCoderNavigationViewModel assigned to the receiver"
	<modelSetter: #tags>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aPharoTagsCoderNavigationViewModel notNil ]
		description: [ 'pharoTagsCoderNavigationViewModel must not be nil' ].

	pharoTagsCoderNavigationViewModel == aPharoTagsCoderNavigationViewModel
		ifTrue: [ ^ self ].

	pharoTagsCoderNavigationViewModel ifNotNil: [ self unsubscribeFromPharoTagsCoderNavigationViewModel ].
	pharoTagsCoderNavigationViewModel := aPharoTagsCoderNavigationViewModel.

	self onPharoTagsCoderNavigationViewModelChanged.
	self subscribeToPharoTagsCoderNavigationViewModel.
	self onPostPharoTagsCoderNavigationViewModelChanged
]

{ #category : #'api - pharo tags coder navigation view model' }
TGt2WithPharoTagsCoderNavigationViewModel >> subscribeToPharoTagsCoderNavigationViewModel [
	"Is sent after a new pharoTagsCoderNavigationViewModel is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromPharoTagsCoderNavigationViewModel if the receiver subscribes to them"
	<modelSubscriber: #tags>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - pharo tags coder navigation view model' }
TGt2WithPharoTagsCoderNavigationViewModel >> unsubscribeFromPharoTagsCoderNavigationViewModel [
	"Is sent before a new pharoTagsCoderNavigationViewModel is assigned to the receiver.
	Objects that subscribe to pharoTagsCoderNavigationViewModel are required to implement this method."
	<modelUnsubscriber: #tags>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
