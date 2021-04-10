"
!! Generation
${class:TGtWithPharoClassesCoderModel}$ was automatically generated with the following code:
[[[
GtWithDomainModelTraitGenerator new
	modelName 'pharoClassesCoder';
	projectPrefix: 'Gt';
	packageName: 'GToolkit-Pharo-Coder-Coders';
	generate
]]] 

"
Trait {
	#name : #TGtWithPharoClassesCoderModel,
	#instVars : [
		'pharoClassesCoderModel'
	],
	#category : #'GToolkit-Pharo-Coder-Coders'
}

{ #category : #'api - pharo classes coder model' }
TGtWithPharoClassesCoderModel >> hasPharoClassesCoder [
	"Return a true if pharoClassesCoder model is assigned to the receiver, false otherwise"
	<return: #Boolean>

	^ pharoClassesCoderModel notNil
]

{ #category : #'api - pharo classes coder model' }
TGtWithPharoClassesCoderModel >> onPharoClassesCoderModelChanged [
	"Is sent when a new pharoClassesCoder model is assigned to the view model"
]

{ #category : #'api - pharo classes coder model' }
TGtWithPharoClassesCoderModel >> pharoClassesCoderModel [
	"Return a not-null pharoClassesCoder model assigned to the receiver view model"
	<modelGetter>
	self
		assert: [ pharoClassesCoderModel notNil ]
		description: [ 'pharoClassesCoder model should be initialized' ].

	^ pharoClassesCoderModel
]

{ #category : #'api - pharo classes coder model' }
TGtWithPharoClassesCoderModel >> pharoClassesCoderModel: aPharoClassesCoderModel [
	"Set a not-null pharoClassesCoder domain model assigned to the receiver view model"
	<modelSetter>
	self
		assert: [ aPharoClassesCoderModel notNil ]
		description: [ 'pharoClassesCoder model must not be nil' ].

	pharoClassesCoderModel == aPharoClassesCoderModel 
		ifTrue: [ ^ self ].

	pharoClassesCoderModel ifNotNil: [ self unsubscribeFromPharoClassesCoderModel ].
	pharoClassesCoderModel := aPharoClassesCoderModel.

	self onPharoClassesCoderModelChanged.
	self subscribeToPharoClassesCoderModel
]

{ #category : #'api - pharo classes coder model' }
TGtWithPharoClassesCoderModel >> subscribeToPharoClassesCoderModel [
	"Is sent after a new pharoClassesCoder model is assigned to the view model.
	It is required to unsubscribe from the domain model by implementing
	#unsubscribeFromPharoClassesCoderModel if view model subscribes to them"
]

{ #category : #'api - pharo classes coder model' }
TGtWithPharoClassesCoderModel >> unsubscribeFromPharoClassesCoderModel [
	"Is sent before a new pharoClassesCoder model is assigned to the view model.
	View models that subscribe to pharoClassesCoder model are required to implement this methods"
]
