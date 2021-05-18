Trait {
	#name : #TGt2WithPharoPackageActionCoderViewModel,
	#instVars : [
		'pharoPackageActionCoderViewModel'
	],
	#category : #'GToolkit-Pharo-Coder2-Package Coder - Support'
}

{ #category : #'api - pharo package action coder view model' }
TGt2WithPharoPackageActionCoderViewModel >> hasPharoPackageActionCoderViewModel [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #packageAction>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ pharoPackageActionCoderViewModel notNil
]

{ #category : #'api - pharo package action coder view model' }
TGt2WithPharoPackageActionCoderViewModel >> onPharoPackageActionCoderViewModelChanged [
	"Is sent when a new pharoPackageActionCoderViewModel is assigned to the receiver.
	Note: #onPharoPackageActionCoderViewModelChanged is sent before #subscribeToPharoPackageActionCoderViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoPackageActionCoderViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - pharo package action coder view model' }
TGt2WithPharoPackageActionCoderViewModel >> onPostPharoPackageActionCoderViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToPharoPackageActionCoderViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - pharo package action coder view model' }
TGt2WithPharoPackageActionCoderViewModel >> pharoPackageActionCoderViewModel [
	"Return a not-null pharoPackageActionCoderViewModel assigned to the receiver"
	<modelGetter: #packageAction>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ pharoPackageActionCoderViewModel notNil ]
		description: [ 'pharoPackageActionCoderViewModel should be initialized' ].

	^ pharoPackageActionCoderViewModel
]

{ #category : #'api - pharo package action coder view model' }
TGt2WithPharoPackageActionCoderViewModel >> pharoPackageActionCoderViewModel: aPharoPackageActionCoderViewModel [
	"Set a not-null pharoPackageActionCoderViewModel assigned to the receiver"
	<modelSetter: #packageAction>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aPharoPackageActionCoderViewModel notNil ]
		description: [ 'pharoPackageActionCoderViewModel must not be nil' ].

	pharoPackageActionCoderViewModel == aPharoPackageActionCoderViewModel
		ifTrue: [ ^ self ].

	pharoPackageActionCoderViewModel ifNotNil: [ self unsubscribeFromPharoPackageActionCoderViewModel ].
	pharoPackageActionCoderViewModel := aPharoPackageActionCoderViewModel.

	self onPharoPackageActionCoderViewModelChanged.
	self subscribeToPharoPackageActionCoderViewModel.
	self onPostPharoPackageActionCoderViewModelChanged
]

{ #category : #'api - pharo package action coder view model' }
TGt2WithPharoPackageActionCoderViewModel >> subscribeToPharoPackageActionCoderViewModel [
	"Is sent after a new pharoPackageActionCoderViewModel is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromPharoPackageActionCoderViewModel if the receiver subscribes to them"
	<modelSubscriber: #packageAction>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - pharo package action coder view model' }
TGt2WithPharoPackageActionCoderViewModel >> unsubscribeFromPharoPackageActionCoderViewModel [
	"Is sent before a new pharoPackageActionCoderViewModel is assigned to the receiver.
	Objects that subscribe to pharoPackageActionCoderViewModel are required to implement this method."
	<modelUnsubscriber: #packageAction>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
