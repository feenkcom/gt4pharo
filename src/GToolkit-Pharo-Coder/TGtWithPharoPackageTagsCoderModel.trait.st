"
## Generation
{{gtClass:TGtWithPharoPackageTagsCoderModel}} was automatically generated with the following code:
```
GtWithDomainModelTraitGenerator new
	modelName: 'pharoPackageTagsCoder';
	projectPrefix: 'Gt';
	packageName: 'GToolkit-Pharo-Coder-Coders';
	generate
]```

"
Trait {
	#name : #TGtWithPharoPackageTagsCoderModel,
	#instVars : [
		'pharoPackageTagsCoderModel'
	],
	#category : #'GToolkit-Pharo-Coder-Coders'
}

{ #category : #'api - pharo package tags coder model' }
TGtWithPharoPackageTagsCoderModel >> hasPharoPackageTagsCoder [
	"Return a true if pharoPackageTagsCoder model is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester>

	^ pharoPackageTagsCoderModel notNil
]

{ #category : #'api - pharo package tags coder model' }
TGtWithPharoPackageTagsCoderModel >> onPharoPackageTagsCoderModelChanged [
	"Is sent when a new pharoPackageTagsCoder model is assigned to the view model"
]

{ #category : #'api - pharo package tags coder model' }
TGtWithPharoPackageTagsCoderModel >> pharoPackageTagsCoderModel [
	"Return a not-null pharoPackageTagsCoder model assigned to the receiver view model"
	<modelGetter>
	self
		assert: [ pharoPackageTagsCoderModel notNil ]
		description: [ 'pharoPackageTagsCoder model should be initialized' ].

	^ pharoPackageTagsCoderModel
]

{ #category : #'api - pharo package tags coder model' }
TGtWithPharoPackageTagsCoderModel >> pharoPackageTagsCoderModel: aPharoPackageTagsCoderModel [
	"Set a not-null pharoPackageTagsCoder domain model assigned to the receiver view model"
	<modelSetter>
	self
		assert: [ aPharoPackageTagsCoderModel notNil ]
		description: [ 'pharoPackageTagsCoder model must not be nil' ].

	pharoPackageTagsCoderModel == aPharoPackageTagsCoderModel 
		ifTrue: [ ^ self ].

	pharoPackageTagsCoderModel ifNotNil: [ self unsubscribeFromPharoPackageTagsCoderModel ].
	pharoPackageTagsCoderModel := aPharoPackageTagsCoderModel.

	self onPharoPackageTagsCoderModelChanged.
	self subscribeToPharoPackageTagsCoderModel
]

{ #category : #'api - pharo package tags coder model' }
TGtWithPharoPackageTagsCoderModel >> subscribeToPharoPackageTagsCoderModel [
	"Is sent after a new pharoPackageTagsCoder model is assigned to the view model.
	It is required to unsubscribe from the domain model by implementing
	#unsubscribeFromPharoPackageTagsCoderModel if view model subscribes to them"
]

{ #category : #'api - pharo package tags coder model' }
TGtWithPharoPackageTagsCoderModel >> unsubscribeFromPharoPackageTagsCoderModel [
	"Is sent before a new pharoPackageTagsCoder model is assigned to the view model.
	View models that subscribe to pharoPackageTagsCoder model are required to implement this methods"
]
