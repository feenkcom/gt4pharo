Trait {
	#name : #TGt2WithPharoPackagesCoderViewModel,
	#instVars : [
		'pharoPackagesCoderViewModel'
	],
	#category : #'GToolkit-Pharo-Coder2-Package Coder - Support'
}

{ #category : #'api - pharo packages coder view model' }
TGt2WithPharoPackagesCoderViewModel >> hasPharoPackagesCoderViewModel [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #packages>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ pharoPackagesCoderViewModel notNil
]

{ #category : #'api - pharo packages coder view model' }
TGt2WithPharoPackagesCoderViewModel >> onPharoPackagesCoderViewModelChanged [
	"Is sent when a new pharoPackagesCoderViewModel is assigned to the receiver.
	Note: #onPharoPackagesCoderViewModelChanged is sent before #subscribeToPharoPackagesCoderViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoPackagesCoderViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - pharo packages coder view model' }
TGt2WithPharoPackagesCoderViewModel >> onPostPharoPackagesCoderViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToPharoPackagesCoderViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - pharo packages coder view model' }
TGt2WithPharoPackagesCoderViewModel >> pharoPackagesCoderViewModel [
	"Return a not-null pharoPackagesCoderViewModel assigned to the receiver"
	<modelGetter: #packages>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ pharoPackagesCoderViewModel notNil ]
		description: [ 'pharoPackagesCoderViewModel should be initialized' ].

	^ pharoPackagesCoderViewModel
]

{ #category : #'api - pharo packages coder view model' }
TGt2WithPharoPackagesCoderViewModel >> pharoPackagesCoderViewModel: aPharoPackagesCoderViewModel [
	"Set a not-null pharoPackagesCoderViewModel assigned to the receiver"
	<modelSetter: #packages>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aPharoPackagesCoderViewModel notNil ]
		description: [ 'pharoPackagesCoderViewModel must not be nil' ].

	pharoPackagesCoderViewModel == aPharoPackagesCoderViewModel
		ifTrue: [ ^ self ].

	pharoPackagesCoderViewModel ifNotNil: [ self unsubscribeFromPharoPackagesCoderViewModel ].
	pharoPackagesCoderViewModel := aPharoPackagesCoderViewModel.

	self onPharoPackagesCoderViewModelChanged.
	self subscribeToPharoPackagesCoderViewModel.
	self onPostPharoPackagesCoderViewModelChanged
]

{ #category : #'api - pharo packages coder view model' }
TGt2WithPharoPackagesCoderViewModel >> subscribeToPharoPackagesCoderViewModel [
	"Is sent after a new pharoPackagesCoderViewModel is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromPharoPackagesCoderViewModel if the receiver subscribes to them"
	<modelSubscriber: #packages>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - pharo packages coder view model' }
TGt2WithPharoPackagesCoderViewModel >> unsubscribeFromPharoPackagesCoderViewModel [
	"Is sent before a new pharoPackagesCoderViewModel is assigned to the receiver.
	Objects that subscribe to pharoPackagesCoderViewModel are required to implement this method."
	<modelUnsubscriber: #packages>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
