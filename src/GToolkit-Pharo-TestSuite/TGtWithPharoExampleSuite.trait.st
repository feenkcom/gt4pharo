Trait {
	#name : #TGtWithPharoExampleSuite,
	#instVars : [
		'pharoExampleSuite'
	],
	#category : 'GToolkit-Pharo-TestSuite-Base'
}

{ #category : #'api - pharo example suite' }
TGtWithPharoExampleSuite >> hasPharoExampleSuite [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #exampleSuite>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ pharoExampleSuite notNil
]

{ #category : #'api - pharo example suite' }
TGtWithPharoExampleSuite >> onPharoExampleSuiteChanged [
	"Is sent when a new pharoExampleSuite is assigned to the receiver.
	Note: #onPharoExampleSuiteChanged is sent before #subscribeToPharoExampleSuite
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoExampleSuiteChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - pharo example suite' }
TGtWithPharoExampleSuite >> onPostPharoExampleSuiteChanged [
	"I am an optional hook method that is sent after #subscribeToPharoExampleSuite.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - pharo example suite' }
TGtWithPharoExampleSuite >> pharoExampleSuite [
	"Return a not-null pharoExampleSuite assigned to the receiver"
	<modelGetter: #exampleSuite>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ pharoExampleSuite notNil ]
		description: [ 'pharoExampleSuite should be initialized' ].

	^ pharoExampleSuite
]

{ #category : #'api - pharo example suite' }
TGtWithPharoExampleSuite >> pharoExampleSuite: aPharoExampleSuite [
	"Set a not-null pharoExampleSuite assigned to the receiver"
	<modelSetter: #exampleSuite>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aPharoExampleSuite notNil ]
		description: [ 'pharoExampleSuite must not be nil' ].

	pharoExampleSuite == aPharoExampleSuite
		ifTrue: [ ^ self ].

	pharoExampleSuite ifNotNil: [ self unsubscribeFromPharoExampleSuite ].
	pharoExampleSuite := aPharoExampleSuite.

	self onPharoExampleSuiteChanged.
	self subscribeToPharoExampleSuite.
	self onPostPharoExampleSuiteChanged
]

{ #category : #'api - pharo example suite' }
TGtWithPharoExampleSuite >> subscribeToPharoExampleSuite [
	"Is sent after a new pharoExampleSuite is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromPharoExampleSuite if the receiver subscribes to them"
	<modelSubscriber: #exampleSuite>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - pharo example suite' }
TGtWithPharoExampleSuite >> unsubscribeFromPharoExampleSuite [
	"Is sent before a new pharoExampleSuite is assigned to the receiver.
	Objects that subscribe to pharoExampleSuite are required to implement this method."
	<modelUnsubscriber: #exampleSuite>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
