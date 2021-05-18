Trait {
	#name : #TGt2WithPharoPackageViewsCoderViewModel,
	#instVars : [
		'pharoPackageViewsCoderViewModel'
	],
	#category : #'GToolkit-Pharo-Coder2-Package Coder - Support'
}

{ #category : #'api - pharo package views coder view model' }
TGt2WithPharoPackageViewsCoderViewModel >> hasPharoPackageViewsCoderViewModel [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #packageViews>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ pharoPackageViewsCoderViewModel notNil
]

{ #category : #'api - pharo package views coder view model' }
TGt2WithPharoPackageViewsCoderViewModel >> onPharoPackageViewsCoderViewModelChanged [
	"Is sent when a new pharoPackageViewsCoderViewModel is assigned to the receiver.
	Note: #onPharoPackageViewsCoderViewModelChanged is sent before #subscribeToPharoPackageViewsCoderViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoPackageViewsCoderViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - pharo package views coder view model' }
TGt2WithPharoPackageViewsCoderViewModel >> onPostPharoPackageViewsCoderViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToPharoPackageViewsCoderViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - pharo package views coder view model' }
TGt2WithPharoPackageViewsCoderViewModel >> pharoPackageViewsCoderViewModel [
	"Return a not-null pharoPackageViewsCoderViewModel assigned to the receiver"
	<modelGetter: #packageViews>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ pharoPackageViewsCoderViewModel notNil ]
		description: [ 'pharoPackageViewsCoderViewModel should be initialized' ].

	^ pharoPackageViewsCoderViewModel
]

{ #category : #'api - pharo package views coder view model' }
TGt2WithPharoPackageViewsCoderViewModel >> pharoPackageViewsCoderViewModel: aPharoPackageViewsCoderViewModel [
	"Set a not-null pharoPackageViewsCoderViewModel assigned to the receiver"
	<modelSetter: #packageViews>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aPharoPackageViewsCoderViewModel notNil ]
		description: [ 'pharoPackageViewsCoderViewModel must not be nil' ].

	pharoPackageViewsCoderViewModel == aPharoPackageViewsCoderViewModel
		ifTrue: [ ^ self ].

	pharoPackageViewsCoderViewModel ifNotNil: [ self unsubscribeFromPharoPackageViewsCoderViewModel ].
	pharoPackageViewsCoderViewModel := aPharoPackageViewsCoderViewModel.

	self onPharoPackageViewsCoderViewModelChanged.
	self subscribeToPharoPackageViewsCoderViewModel.
	self onPostPharoPackageViewsCoderViewModelChanged
]

{ #category : #'api - pharo package views coder view model' }
TGt2WithPharoPackageViewsCoderViewModel >> subscribeToPharoPackageViewsCoderViewModel [
	"Is sent after a new pharoPackageViewsCoderViewModel is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromPharoPackageViewsCoderViewModel if the receiver subscribes to them"
	<modelSubscriber: #packageViews>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - pharo package views coder view model' }
TGt2WithPharoPackageViewsCoderViewModel >> unsubscribeFromPharoPackageViewsCoderViewModel [
	"Is sent before a new pharoPackageViewsCoderViewModel is assigned to the receiver.
	Objects that subscribe to pharoPackageViewsCoderViewModel are required to implement this method."
	<modelUnsubscriber: #packageViews>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
