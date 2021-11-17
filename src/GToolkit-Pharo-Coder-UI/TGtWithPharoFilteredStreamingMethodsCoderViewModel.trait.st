Trait {
	#name : #TGtWithPharoFilteredStreamingMethodsCoderViewModel,
	#instVars : [
		'pharoFilteredStreamingMethodsCoderViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-! View Models'
}

{ #category : #'api - pharo filtered streaming methods coder view model' }
TGtWithPharoFilteredStreamingMethodsCoderViewModel >> hasPharoFilteredStreamingMethodsCoderViewModel [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #filteredStreamingMethodsCoderViewModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ pharoFilteredStreamingMethodsCoderViewModel notNil
]

{ #category : #'api - pharo filtered streaming methods coder view model' }
TGtWithPharoFilteredStreamingMethodsCoderViewModel >> onPharoFilteredStreamingMethodsCoderViewModelChanged [
	"Is sent when a new pharoFilteredStreamingMethodsCoderViewModel is assigned to the receiver.
	Note: #onPharoFilteredStreamingMethodsCoderViewModelChanged is sent before #subscribeToPharoFilteredStreamingMethodsCoderViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoFilteredStreamingMethodsCoderViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - pharo filtered streaming methods coder view model' }
TGtWithPharoFilteredStreamingMethodsCoderViewModel >> onPostPharoFilteredStreamingMethodsCoderViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToPharoFilteredStreamingMethodsCoderViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - pharo filtered streaming methods coder view model' }
TGtWithPharoFilteredStreamingMethodsCoderViewModel >> pharoFilteredStreamingMethodsCoderViewModel [
	"Return a not-null pharoFilteredStreamingMethodsCoderViewModel assigned to the receiver"
	<modelGetter: #filteredStreamingMethodsCoderViewModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ pharoFilteredStreamingMethodsCoderViewModel notNil ]
		description: [ 'pharoFilteredStreamingMethodsCoderViewModel should be initialized' ].

	^ pharoFilteredStreamingMethodsCoderViewModel
]

{ #category : #'api - pharo filtered streaming methods coder view model' }
TGtWithPharoFilteredStreamingMethodsCoderViewModel >> pharoFilteredStreamingMethodsCoderViewModel: aPharoFilteredStreamingMethodsCoderViewModel [
	"Set a not-null pharoFilteredStreamingMethodsCoderViewModel assigned to the receiver"
	<modelSetter: #filteredStreamingMethodsCoderViewModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aPharoFilteredStreamingMethodsCoderViewModel notNil ]
		description: [ 'pharoFilteredStreamingMethodsCoderViewModel must not be nil' ].

	pharoFilteredStreamingMethodsCoderViewModel == aPharoFilteredStreamingMethodsCoderViewModel
		ifTrue: [ ^ self ].

	pharoFilteredStreamingMethodsCoderViewModel ifNotNil: [ self unsubscribeFromPharoFilteredStreamingMethodsCoderViewModel ].
	pharoFilteredStreamingMethodsCoderViewModel := aPharoFilteredStreamingMethodsCoderViewModel.

	self onPharoFilteredStreamingMethodsCoderViewModelChanged.
	self subscribeToPharoFilteredStreamingMethodsCoderViewModel.
	self onPostPharoFilteredStreamingMethodsCoderViewModelChanged
]

{ #category : #'api - pharo filtered streaming methods coder view model' }
TGtWithPharoFilteredStreamingMethodsCoderViewModel >> subscribeToPharoFilteredStreamingMethodsCoderViewModel [
	"Is sent after a new pharoFilteredStreamingMethodsCoderViewModel is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromPharoFilteredStreamingMethodsCoderViewModel if the receiver subscribes to them"
	<modelSubscriber: #filteredStreamingMethodsCoderViewModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - pharo filtered streaming methods coder view model' }
TGtWithPharoFilteredStreamingMethodsCoderViewModel >> unsubscribeFromPharoFilteredStreamingMethodsCoderViewModel [
	"Is sent before a new pharoFilteredStreamingMethodsCoderViewModel is assigned to the receiver.
	Objects that subscribe to pharoFilteredStreamingMethodsCoderViewModel are required to implement this method."
	<modelUnsubscriber: #filteredStreamingMethodsCoderViewModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
