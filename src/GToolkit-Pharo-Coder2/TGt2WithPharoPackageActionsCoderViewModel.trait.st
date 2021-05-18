Trait {
	#name : #TGt2WithPharoPackageActionsCoderViewModel,
	#instVars : [
		'pharoPackageActionsCoderViewModel'
	],
	#category : #'GToolkit-Pharo-Coder2-Package Coder - Support'
}

{ #category : #'api - pharo package actions coder view model' }
TGt2WithPharoPackageActionsCoderViewModel >> hasPharoPackageActionsCoderViewModel [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #packageActions>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ pharoPackageActionsCoderViewModel notNil
]

{ #category : #'api - pharo package actions coder view model' }
TGt2WithPharoPackageActionsCoderViewModel >> onPharoPackageActionsCoderViewModelChanged [
	"Is sent when a new pharoPackageActionsCoderViewModel is assigned to the receiver.
	Note: #onPharoPackageActionsCoderViewModelChanged is sent before #subscribeToPharoPackageActionsCoderViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoPackageActionsCoderViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - pharo package actions coder view model' }
TGt2WithPharoPackageActionsCoderViewModel >> onPostPharoPackageActionsCoderViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToPharoPackageActionsCoderViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - pharo package actions coder view model' }
TGt2WithPharoPackageActionsCoderViewModel >> pharoPackageActionsCoderViewModel [
	"Return a not-null pharoPackageActionsCoderViewModel assigned to the receiver"
	<modelGetter: #packageActions>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ pharoPackageActionsCoderViewModel notNil ]
		description: [ 'pharoPackageActionsCoderViewModel should be initialized' ].

	^ pharoPackageActionsCoderViewModel
]

{ #category : #'api - pharo package actions coder view model' }
TGt2WithPharoPackageActionsCoderViewModel >> pharoPackageActionsCoderViewModel: aPharoPackageActionsCoderViewModel [
	"Set a not-null pharoPackageActionsCoderViewModel assigned to the receiver"
	<modelSetter: #packageActions>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aPharoPackageActionsCoderViewModel notNil ]
		description: [ 'pharoPackageActionsCoderViewModel must not be nil' ].

	pharoPackageActionsCoderViewModel == aPharoPackageActionsCoderViewModel
		ifTrue: [ ^ self ].

	pharoPackageActionsCoderViewModel ifNotNil: [ self unsubscribeFromPharoPackageActionsCoderViewModel ].
	pharoPackageActionsCoderViewModel := aPharoPackageActionsCoderViewModel.

	self onPharoPackageActionsCoderViewModelChanged.
	self subscribeToPharoPackageActionsCoderViewModel.
	self onPostPharoPackageActionsCoderViewModelChanged
]

{ #category : #'api - pharo package actions coder view model' }
TGt2WithPharoPackageActionsCoderViewModel >> subscribeToPharoPackageActionsCoderViewModel [
	"Is sent after a new pharoPackageActionsCoderViewModel is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromPharoPackageActionsCoderViewModel if the receiver subscribes to them"
	<modelSubscriber: #packageActions>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - pharo package actions coder view model' }
TGt2WithPharoPackageActionsCoderViewModel >> unsubscribeFromPharoPackageActionsCoderViewModel [
	"Is sent before a new pharoPackageActionsCoderViewModel is assigned to the receiver.
	Objects that subscribe to pharoPackageActionsCoderViewModel are required to implement this method."
	<modelUnsubscriber: #packageActions>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
