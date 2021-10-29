Trait {
	#name : #TGtPharoWithMethodsCoderModel,
	#instVars : [
		'methodsCoderModel'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Test Case'
}

{ #category : #'api - methods coder model' }
TGtPharoWithMethodsCoderModel >> hasMethodsCoderModel [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<objectTester: #methodsCoderModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ methodsCoderModel notNil
]

{ #category : #'api - methods coder model' }
TGtPharoWithMethodsCoderModel >> methodsCoderModel [
	"Return a not-null methodsCoderModel assigned to the receiver"
	<objectGetter: #methodsCoderModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ methodsCoderModel notNil ]
		description: [ 'methodsCoderModel should be initialized' ].

	^ methodsCoderModel
]

{ #category : #'api - methods coder model' }
TGtPharoWithMethodsCoderModel >> methodsCoderModel: aMethodsCoderModel [
	"Set a not-null methodsCoderModel assigned to the receiver"
	<objectSetter: #methodsCoderModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aMethodsCoderModel notNil ]
		description: [ 'methodsCoderModel must not be nil' ].

	methodsCoderModel == aMethodsCoderModel
		ifTrue: [ ^ self ].

	methodsCoderModel ifNotNil: [ self unsubscribeFromMethodsCoderModel ].
	methodsCoderModel := aMethodsCoderModel.

	self onMethodsCoderModelChanged.
	self subscribeToMethodsCoderModel.
	self onPostMethodsCoderModelChanged
]

{ #category : #'api - methods coder model' }
TGtPharoWithMethodsCoderModel >> onMethodsCoderModelChanged [
	"Is sent when a new methodsCoderModel is assigned to the receiver.
	Note: #onMethodsCoderModelChanged is sent before #subscribeToMethodsCoderModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostMethodsCoderModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - methods coder model' }
TGtPharoWithMethodsCoderModel >> onPostMethodsCoderModelChanged [
	"I am an optional hook method that is sent after #subscribeToMethodsCoderModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - methods coder model' }
TGtPharoWithMethodsCoderModel >> subscribeToMethodsCoderModel [
	"Is sent after a new methodsCoderModel is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromMethodsCoderModel if the receiver subscribes to them"
	<objectSubscriber: #methodsCoderModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - methods coder model' }
TGtPharoWithMethodsCoderModel >> unsubscribeFromMethodsCoderModel [
	"Is sent before a new methodsCoderModel is assigned to the receiver.
	Objects that subscribe to methodsCoderModel are required to implement this method."
	<objectUnsubscriber: #methodsCoderModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
