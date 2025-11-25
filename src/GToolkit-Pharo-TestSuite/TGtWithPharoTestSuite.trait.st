Trait {
	#name : #TGtWithPharoTestSuite,
	#instVars : [
		'pharoTestSuite'
	],
	#category : 'GToolkit-Pharo-TestSuite-Base'
}

{ #category : #'api - pharo test suite' }
TGtWithPharoTestSuite >> hasPharoTestSuite [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #testSuite>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ pharoTestSuite notNil
]

{ #category : #'api - pharo test suite' }
TGtWithPharoTestSuite >> onPharoTestSuiteChanged [
	"Is sent when a new pharoTestSuite is assigned to the receiver.
	Note: #onPharoTestSuiteChanged is sent before #subscribeToPharoTestSuite
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoTestSuiteChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - pharo test suite' }
TGtWithPharoTestSuite >> onPostPharoTestSuiteChanged [
	"I am an optional hook method that is sent after #subscribeToPharoTestSuite.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - pharo test suite' }
TGtWithPharoTestSuite >> pharoTestSuite [
	"Return a not-null pharoTestSuite assigned to the receiver"
	<modelGetter: #testSuite>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ pharoTestSuite notNil ]
		description: [ 'pharoTestSuite should be initialized' ].

	^ pharoTestSuite
]

{ #category : #'api - pharo test suite' }
TGtWithPharoTestSuite >> pharoTestSuite: aPharoTestSuite [
	"Set a not-null pharoTestSuite assigned to the receiver"
	<modelSetter: #testSuite>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aPharoTestSuite notNil ]
		description: [ 'pharoTestSuite must not be nil' ].

	pharoTestSuite == aPharoTestSuite
		ifTrue: [ ^ self ].

	pharoTestSuite ifNotNil: [ self unsubscribeFromPharoTestSuite ].
	pharoTestSuite := aPharoTestSuite.

	self onPharoTestSuiteChanged.
	self subscribeToPharoTestSuite.
	self onPostPharoTestSuiteChanged
]

{ #category : #'api - pharo test suite' }
TGtWithPharoTestSuite >> subscribeToPharoTestSuite [
	"Is sent after a new pharoTestSuite is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromPharoTestSuite if the receiver subscribes to them"
	<modelSubscriber: #testSuite>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - pharo test suite' }
TGtWithPharoTestSuite >> unsubscribeFromPharoTestSuite [
	"Is sent before a new pharoTestSuite is assigned to the receiver.
	Objects that subscribe to pharoTestSuite are required to implement this method."
	<modelUnsubscriber: #testSuite>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
