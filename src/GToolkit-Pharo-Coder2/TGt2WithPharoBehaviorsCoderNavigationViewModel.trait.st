Trait {
	#name : #TGt2WithPharoBehaviorsCoderNavigationViewModel,
	#instVars : [
		'pharoBehaviorsCoderNavigationViewModel'
	],
	#category : #'GToolkit-Pharo-Coder2-Navigation - Support'
}

{ #category : #'api - pharo behaviors coder navigation view model' }
TGt2WithPharoBehaviorsCoderNavigationViewModel >> hasPharoBehaviorsCoderNavigationViewModel [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #behaviors>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ pharoBehaviorsCoderNavigationViewModel notNil
]

{ #category : #'api - pharo behaviors coder navigation view model' }
TGt2WithPharoBehaviorsCoderNavigationViewModel >> onPharoBehaviorsCoderNavigationViewModelChanged [
	"Is sent when a new pharoBehaviorsCoderNavigationViewModel is assigned to the receiver.
	Note: #onPharoBehaviorsCoderNavigationViewModelChanged is sent before #subscribeToPharoBehaviorsCoderNavigationViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoBehaviorsCoderNavigationViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - pharo behaviors coder navigation view model' }
TGt2WithPharoBehaviorsCoderNavigationViewModel >> onPostPharoBehaviorsCoderNavigationViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToPharoBehaviorsCoderNavigationViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - pharo behaviors coder navigation view model' }
TGt2WithPharoBehaviorsCoderNavigationViewModel >> pharoBehaviorsCoderNavigationViewModel [
	"Return a not-null pharoBehaviorsCoderNavigationViewModel assigned to the receiver"
	<modelGetter: #behaviors>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ pharoBehaviorsCoderNavigationViewModel notNil ]
		description: [ 'pharoBehaviorsCoderNavigationViewModel should be initialized' ].

	^ pharoBehaviorsCoderNavigationViewModel
]

{ #category : #'api - pharo behaviors coder navigation view model' }
TGt2WithPharoBehaviorsCoderNavigationViewModel >> pharoBehaviorsCoderNavigationViewModel: aPharoBehaviorsCoderNavigationViewModel [
	"Set a not-null pharoBehaviorsCoderNavigationViewModel assigned to the receiver"
	<modelSetter: #behaviors>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aPharoBehaviorsCoderNavigationViewModel notNil ]
		description: [ 'pharoBehaviorsCoderNavigationViewModel must not be nil' ].

	pharoBehaviorsCoderNavigationViewModel == aPharoBehaviorsCoderNavigationViewModel
		ifTrue: [ ^ self ].

	pharoBehaviorsCoderNavigationViewModel ifNotNil: [ self unsubscribeFromPharoBehaviorsCoderNavigationViewModel ].
	pharoBehaviorsCoderNavigationViewModel := aPharoBehaviorsCoderNavigationViewModel.

	self onPharoBehaviorsCoderNavigationViewModelChanged.
	self subscribeToPharoBehaviorsCoderNavigationViewModel.
	self onPostPharoBehaviorsCoderNavigationViewModelChanged
]

{ #category : #'api - pharo behaviors coder navigation view model' }
TGt2WithPharoBehaviorsCoderNavigationViewModel >> subscribeToPharoBehaviorsCoderNavigationViewModel [
	"Is sent after a new pharoBehaviorsCoderNavigationViewModel is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromPharoBehaviorsCoderNavigationViewModel if the receiver subscribes to them"
	<modelSubscriber: #behaviors>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - pharo behaviors coder navigation view model' }
TGt2WithPharoBehaviorsCoderNavigationViewModel >> unsubscribeFromPharoBehaviorsCoderNavigationViewModel [
	"Is sent before a new pharoBehaviorsCoderNavigationViewModel is assigned to the receiver.
	Objects that subscribe to pharoBehaviorsCoderNavigationViewModel are required to implement this method."
	<modelUnsubscriber: #behaviors>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
