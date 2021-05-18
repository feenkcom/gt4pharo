Trait {
	#name : #TGt2WithPharoPackageViewCoderViewModel,
	#instVars : [
		'pharoPackageViewCoderViewModel'
	],
	#category : #'GToolkit-Pharo-Coder2-Package Coder - Support'
}

{ #category : #'api - pharo package view coder view model' }
TGt2WithPharoPackageViewCoderViewModel >> hasPharoPackageViewCoderViewModel [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #packageView>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ pharoPackageViewCoderViewModel notNil
]

{ #category : #'api - pharo package view coder view model' }
TGt2WithPharoPackageViewCoderViewModel >> onPharoPackageViewCoderViewModelChanged [
	"Is sent when a new pharoPackageViewCoderViewModel is assigned to the receiver.
	Note: #onPharoPackageViewCoderViewModelChanged is sent before #subscribeToPharoPackageViewCoderViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoPackageViewCoderViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - pharo package view coder view model' }
TGt2WithPharoPackageViewCoderViewModel >> onPostPharoPackageViewCoderViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToPharoPackageViewCoderViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - pharo package view coder view model' }
TGt2WithPharoPackageViewCoderViewModel >> pharoPackageViewCoderViewModel [
	"Return a not-null pharoPackageViewCoderViewModel assigned to the receiver"
	<modelGetter: #packageView>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ pharoPackageViewCoderViewModel notNil ]
		description: [ 'pharoPackageViewCoderViewModel should be initialized' ].

	^ pharoPackageViewCoderViewModel
]

{ #category : #'api - pharo package view coder view model' }
TGt2WithPharoPackageViewCoderViewModel >> pharoPackageViewCoderViewModel: aPharoPackageViewCoderViewModel [
	"Set a not-null pharoPackageViewCoderViewModel assigned to the receiver"
	<modelSetter: #packageView>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aPharoPackageViewCoderViewModel notNil ]
		description: [ 'pharoPackageViewCoderViewModel must not be nil' ].

	pharoPackageViewCoderViewModel == aPharoPackageViewCoderViewModel
		ifTrue: [ ^ self ].

	pharoPackageViewCoderViewModel ifNotNil: [ self unsubscribeFromPharoPackageViewCoderViewModel ].
	pharoPackageViewCoderViewModel := aPharoPackageViewCoderViewModel.

	self onPharoPackageViewCoderViewModelChanged.
	self subscribeToPharoPackageViewCoderViewModel.
	self onPostPharoPackageViewCoderViewModelChanged
]

{ #category : #'api - pharo package view coder view model' }
TGt2WithPharoPackageViewCoderViewModel >> subscribeToPharoPackageViewCoderViewModel [
	"Is sent after a new pharoPackageViewCoderViewModel is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromPharoPackageViewCoderViewModel if the receiver subscribes to them"
	<modelSubscriber: #packageView>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - pharo package view coder view model' }
TGt2WithPharoPackageViewCoderViewModel >> unsubscribeFromPharoPackageViewCoderViewModel [
	"Is sent before a new pharoPackageViewCoderViewModel is assigned to the receiver.
	Objects that subscribe to pharoPackageViewCoderViewModel are required to implement this method."
	<modelUnsubscriber: #packageView>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
