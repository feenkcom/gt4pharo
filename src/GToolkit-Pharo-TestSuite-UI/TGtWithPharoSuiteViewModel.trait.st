Trait {
	#name : #TGtWithPharoSuiteViewModel,
	#instVars : [
		'suiteViewModel'
	],
	#category : 'GToolkit-Pharo-TestSuite-UI-! View Models'
}

{ #category : #'api - suite view model' }
TGtWithPharoSuiteViewModel >> hasSuiteViewModel [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<objectTester: #suiteViewModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ suiteViewModel notNil
]

{ #category : #'api - suite view model' }
TGtWithPharoSuiteViewModel >> onPostSuiteViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToSuiteViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - suite view model' }
TGtWithPharoSuiteViewModel >> onSuiteViewModelChanged [
	"Is sent when a new suiteViewModel is assigned to the receiver.
	Note: #onSuiteViewModelChanged is sent before #subscribeToSuiteViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostSuiteViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - suite view model' }
TGtWithPharoSuiteViewModel >> subscribeToSuiteViewModel [
	"Is sent after a new suiteViewModel is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromSuiteViewModel if the receiver subscribes to them"
	<objectSubscriber: #suiteViewModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - suite view model' }
TGtWithPharoSuiteViewModel >> suiteViewModel [
	"Return a not-null suiteViewModel assigned to the receiver"
	<objectGetter: #suiteViewModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ suiteViewModel notNil ]
		description: [ 'suiteViewModel should be initialized' ].

	^ suiteViewModel
]

{ #category : #'api - suite view model' }
TGtWithPharoSuiteViewModel >> suiteViewModel: aSuiteViewModel [
	"Set a not-null suiteViewModel assigned to the receiver"
	<objectSetter: #suiteViewModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aSuiteViewModel notNil ]
		description: [ 'suiteViewModel must not be nil' ].

	suiteViewModel == aSuiteViewModel
		ifTrue: [ ^ self ].

	suiteViewModel ifNotNil: [ self unsubscribeFromSuiteViewModel ].
	suiteViewModel := aSuiteViewModel.

	self onSuiteViewModelChanged.
	self subscribeToSuiteViewModel.
	self onPostSuiteViewModelChanged
]

{ #category : #'api - suite view model' }
TGtWithPharoSuiteViewModel >> unsubscribeFromSuiteViewModel [
	"Is sent before a new suiteViewModel is assigned to the receiver.
	Objects that subscribe to suiteViewModel are required to implement this method."
	<objectUnsubscriber: #suiteViewModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
