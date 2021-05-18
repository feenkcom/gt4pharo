Trait {
	#name : #TGt2WithPharoBehaviorCoderNavigationViewModel,
	#instVars : [
		'pharoBehaviorCoderNavigationViewModel'
	],
	#category : #'GToolkit-Pharo-Coder2-Navigation - Support'
}

{ #category : #'api - pharo behavior coder navigation view model' }
TGt2WithPharoBehaviorCoderNavigationViewModel >> hasPharoBehaviorCoderNavigationViewModel [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #behavior>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ pharoBehaviorCoderNavigationViewModel notNil
]

{ #category : #'api - pharo behavior coder navigation view model' }
TGt2WithPharoBehaviorCoderNavigationViewModel >> onPharoBehaviorCoderNavigationViewModelChanged [
	"Is sent when a new pharoBehaviorCoderNavigationViewModel is assigned to the receiver.
	Note: #onPharoBehaviorCoderNavigationViewModelChanged is sent before #subscribeToPharoBehaviorCoderNavigationViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoBehaviorCoderNavigationViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - pharo behavior coder navigation view model' }
TGt2WithPharoBehaviorCoderNavigationViewModel >> onPostPharoBehaviorCoderNavigationViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToPharoBehaviorCoderNavigationViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - pharo behavior coder navigation view model' }
TGt2WithPharoBehaviorCoderNavigationViewModel >> pharoBehaviorCoderNavigationViewModel [
	"Return a not-null pharoBehaviorCoderNavigationViewModel assigned to the receiver"
	<modelGetter: #behavior>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ pharoBehaviorCoderNavigationViewModel notNil ]
		description: [ 'pharoBehaviorCoderNavigationViewModel should be initialized' ].

	^ pharoBehaviorCoderNavigationViewModel
]

{ #category : #'api - pharo behavior coder navigation view model' }
TGt2WithPharoBehaviorCoderNavigationViewModel >> pharoBehaviorCoderNavigationViewModel: aPharoBehaviorCoderNavigationViewModel [
	"Set a not-null pharoBehaviorCoderNavigationViewModel assigned to the receiver"
	<modelSetter: #behavior>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aPharoBehaviorCoderNavigationViewModel notNil ]
		description: [ 'pharoBehaviorCoderNavigationViewModel must not be nil' ].

	pharoBehaviorCoderNavigationViewModel == aPharoBehaviorCoderNavigationViewModel
		ifTrue: [ ^ self ].

	pharoBehaviorCoderNavigationViewModel ifNotNil: [ self unsubscribeFromPharoBehaviorCoderNavigationViewModel ].
	pharoBehaviorCoderNavigationViewModel := aPharoBehaviorCoderNavigationViewModel.

	self onPharoBehaviorCoderNavigationViewModelChanged.
	self subscribeToPharoBehaviorCoderNavigationViewModel.
	self onPostPharoBehaviorCoderNavigationViewModelChanged
]

{ #category : #'api - pharo behavior coder navigation view model' }
TGt2WithPharoBehaviorCoderNavigationViewModel >> subscribeToPharoBehaviorCoderNavigationViewModel [
	"Is sent after a new pharoBehaviorCoderNavigationViewModel is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromPharoBehaviorCoderNavigationViewModel if the receiver subscribes to them"
	<modelSubscriber: #behavior>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - pharo behavior coder navigation view model' }
TGt2WithPharoBehaviorCoderNavigationViewModel >> unsubscribeFromPharoBehaviorCoderNavigationViewModel [
	"Is sent before a new pharoBehaviorCoderNavigationViewModel is assigned to the receiver.
	Objects that subscribe to pharoBehaviorCoderNavigationViewModel are required to implement this method."
	<modelUnsubscriber: #behavior>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
