Trait {
	#name : #TGtWithPharoMethodCoderViewModel,
	#instVars : [
		'pharoMethodCoderViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-Method-UI-! View Models'
}

{ #category : #'api - pharo method coder view model' }
TGtWithPharoMethodCoderViewModel >> hasPharoMethodCoderViewModel [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #methodCoderViewModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ pharoMethodCoderViewModel notNil
]

{ #category : #'api - pharo method coder view model' }
TGtWithPharoMethodCoderViewModel >> onPharoMethodCoderViewModelChanged [
	"Is sent when a new pharoMethodCoderViewModel is assigned to the receiver.
	Note: #onPharoMethodCoderViewModelChanged is sent before #subscribeToPharoMethodCoderViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoMethodCoderViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - pharo method coder view model' }
TGtWithPharoMethodCoderViewModel >> onPostPharoMethodCoderViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToPharoMethodCoderViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - pharo method coder view model' }
TGtWithPharoMethodCoderViewModel >> pharoMethodCoderViewModel [
	"Return a not-null pharoMethodCoderViewModel assigned to the receiver"
	<modelGetter: #methodCoderViewModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ pharoMethodCoderViewModel notNil ]
		description: [ 'pharoMethodCoderViewModel should be initialized' ].

	^ pharoMethodCoderViewModel
]

{ #category : #'api - pharo method coder view model' }
TGtWithPharoMethodCoderViewModel >> pharoMethodCoderViewModel: aPharoMethodCoderViewModel [
	"Set a not-null pharoMethodCoderViewModel assigned to the receiver"
	<modelSetter: #methodCoderViewModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aPharoMethodCoderViewModel notNil ]
		description: [ 'pharoMethodCoderViewModel must not be nil' ].

	pharoMethodCoderViewModel == aPharoMethodCoderViewModel
		ifTrue: [ ^ self ].

	pharoMethodCoderViewModel ifNotNil: [ self unsubscribeFromPharoMethodCoderViewModel ].
	pharoMethodCoderViewModel := aPharoMethodCoderViewModel.

	self onPharoMethodCoderViewModelChanged.
	self subscribeToPharoMethodCoderViewModel.
	self onPostPharoMethodCoderViewModelChanged
]

{ #category : #'api - pharo method coder view model' }
TGtWithPharoMethodCoderViewModel >> subscribeToPharoMethodCoderViewModel [
	"Is sent after a new pharoMethodCoderViewModel is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromPharoMethodCoderViewModel if the receiver subscribes to them"
	<modelSubscriber: #methodCoderViewModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - pharo method coder view model' }
TGtWithPharoMethodCoderViewModel >> unsubscribeFromPharoMethodCoderViewModel [
	"Is sent before a new pharoMethodCoderViewModel is assigned to the receiver.
	Objects that subscribe to pharoMethodCoderViewModel are required to implement this method."
	<modelUnsubscriber: #methodCoderViewModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
