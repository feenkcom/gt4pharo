"
!! Generation
${class:TGtWithPharoBehaviorCoderModel}$ was automatically generated with the following code:
[[[
GtWithDomainModelTraitGenerator new
	modelName 'pharoBehaviorCoder';
	projectPrefix: 'Gt';
	packageName: 'GToolkit-Pharo-Coder-Coders';
	generate
]]] 

"
Trait {
	#name : #TGtWithPharoBehaviorCoderModel,
	#instVars : [
		'pharoBehaviorCoderModel'
	],
	#category : #'GToolkit-Pharo-Coder-Coders'
}

{ #category : #'api - pharo behavior coder model' }
TGtWithPharoBehaviorCoderModel >> hasPharoBehaviorCoder [
	"Return a true if pharoBehaviorCoder model is assigned to the receiver, false otherwise"
	<return: #Boolean>

	^ pharoBehaviorCoderModel notNil
]

{ #category : #'api - pharo behavior coder model' }
TGtWithPharoBehaviorCoderModel >> onPharoBehaviorCoderModelChanged [
	"Is sent when a new pharoBehaviorCoder model is assigned to the view model"
]

{ #category : #'api - pharo behavior coder model' }
TGtWithPharoBehaviorCoderModel >> pharoBehaviorCoderModel [
	"Return a not-null pharoBehaviorCoder model assigned to the receiver view model"
	<modelGetter>
	self
		assert: [ pharoBehaviorCoderModel notNil ]
		description: [ 'pharoBehaviorCoder model should be initialized' ].

	^ pharoBehaviorCoderModel
]

{ #category : #'api - pharo behavior coder model' }
TGtWithPharoBehaviorCoderModel >> pharoBehaviorCoderModel: aPharoBehaviorCoderModel [
	"Set a not-null pharoBehaviorCoder domain model assigned to the receiver view model"
	<modelSetter>
	self
		assert: [ aPharoBehaviorCoderModel notNil ]
		description: [ 'pharoBehaviorCoder model must not be nil' ].

	pharoBehaviorCoderModel == aPharoBehaviorCoderModel 
		ifTrue: [ ^ self ].

	pharoBehaviorCoderModel ifNotNil: [ self unsubscribeFromPharoBehaviorCoderModel ].
	pharoBehaviorCoderModel := aPharoBehaviorCoderModel.

	self onPharoBehaviorCoderModelChanged.
	self subscribeToPharoBehaviorCoderModel
]

{ #category : #'api - pharo behavior coder model' }
TGtWithPharoBehaviorCoderModel >> subscribeToPharoBehaviorCoderModel [
	"Is sent after a new pharoBehaviorCoder model is assigned to the view model.
	It is required to unsubscribe from the domain model by implementing
	#unsubscribeFromPharoBehaviorCoderModel if view model subscribes to them"
]

{ #category : #'api - pharo behavior coder model' }
TGtWithPharoBehaviorCoderModel >> unsubscribeFromPharoBehaviorCoderModel [
	"Is sent before a new pharoBehaviorCoder model is assigned to the view model.
	View models that subscribe to pharoBehaviorCoder model are required to implement this methods"
]
