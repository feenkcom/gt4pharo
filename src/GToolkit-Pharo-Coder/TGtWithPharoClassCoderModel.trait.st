"
## Generation
{{gtClass:TGtWithPharoClassCoderModel}} was automatically generated with the following code:
```
GtWithDomainModelTraitGenerator new
	modelName: 'pharoClassCoder';
	projectPrefix: 'Gt';
	packageName: 'GToolkit-Pharo-Coder-Coders';
	generate
]```

"
Trait {
	#name : #TGtWithPharoClassCoderModel,
	#instVars : [
		'pharoClassCoderModel'
	],
	#category : #'GToolkit-Pharo-Coder-Coders'
}

{ #category : #'api - pharo class coder model' }
TGtWithPharoClassCoderModel >> hasPharoClassCoder [
	"Return a true if pharoClassCoder model is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester>

	^ pharoClassCoderModel notNil
]

{ #category : #'api - pharo class coder model' }
TGtWithPharoClassCoderModel >> onPharoClassCoderModelChanged [
	"Is sent when a new pharoClassCoder model is assigned to the view model"
]

{ #category : #'api - pharo class coder model' }
TGtWithPharoClassCoderModel >> pharoClassCoderModel [
	"Return a not-null pharoClassCoder model assigned to the receiver view model"
	<modelGetter>
	self
		assert: [ pharoClassCoderModel notNil ]
		description: [ 'pharoClassCoder model should be initialized' ].

	^ pharoClassCoderModel
]

{ #category : #'api - pharo class coder model' }
TGtWithPharoClassCoderModel >> pharoClassCoderModel: aPharoClassCoderModel [
	"Set a not-null pharoClassCoder domain model assigned to the receiver view model"
	<modelSetter>
	self
		assert: [ aPharoClassCoderModel notNil ]
		description: [ 'pharoClassCoder model must not be nil' ].

	pharoClassCoderModel == aPharoClassCoderModel 
		ifTrue: [ ^ self ].

	pharoClassCoderModel ifNotNil: [ self unsubscribeFromPharoClassCoderModel ].
	pharoClassCoderModel := aPharoClassCoderModel.

	self onPharoClassCoderModelChanged.
	self subscribeToPharoClassCoderModel
]

{ #category : #'api - pharo class coder model' }
TGtWithPharoClassCoderModel >> subscribeToPharoClassCoderModel [
	"Is sent after a new pharoClassCoder model is assigned to the view model.
	It is required to unsubscribe from the domain model by implementing
	#unsubscribeFromPharoClassCoderModel if view model subscribes to them"
]

{ #category : #'api - pharo class coder model' }
TGtWithPharoClassCoderModel >> unsubscribeFromPharoClassCoderModel [
	"Is sent before a new pharoClassCoder model is assigned to the view model.
	View models that subscribe to pharoClassCoder model are required to implement this methods"
]
