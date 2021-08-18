"
!! Generation
${class:TGtWithPharoPackageCoderModel}$ was automatically generated with the following code:
[[[
GtWithDomainModelTraitGenerator new
	modelName: 'pharoPackageCoder';
	projectPrefix: 'Gt';
	packageName: 'GToolkit-Pharo-Coder-Coders';
	generate
]]] 

"
Trait {
	#name : 'TGtWithPharoPackageCoderModel',
	#instVars : [
		'pharoPackageCoderModel'
	],
	#category : 'GToolkit-Pharo-Coder-Coders'
}

{ #category : 'api - pharo package coder model' }
TGtWithPharoPackageCoderModel >> hasPharoPackageCoder [
	"Return a true if pharoPackageCoder model is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester>

	^ pharoPackageCoderModel notNil
]

{ #category : 'api - pharo package coder model' }
TGtWithPharoPackageCoderModel >> onPharoPackageCoderModelChanged [
	"Is sent when a new pharoPackageCoder model is assigned to the view model"
]

{ #category : 'api - pharo package coder model' }
TGtWithPharoPackageCoderModel >> pharoPackageCoderModel [
	"Return a not-null pharoPackageCoder model assigned to the receiver view model"
	<modelGetter>
	self
		assert: [ pharoPackageCoderModel notNil ]
		description: [ 'pharoPackageCoder model should be initialized' ].

	^ pharoPackageCoderModel
]

{ #category : 'api - pharo package coder model' }
TGtWithPharoPackageCoderModel >> pharoPackageCoderModel: aPharoPackageCoderModel [
	"Set a not-null pharoPackageCoder domain model assigned to the receiver view model"
	<modelSetter>
	self
		assert: [ aPharoPackageCoderModel notNil ]
		description: [ 'pharoPackageCoder model must not be nil' ].

	pharoPackageCoderModel == aPharoPackageCoderModel 
		ifTrue: [ ^ self ].

	pharoPackageCoderModel ifNotNil: [ self unsubscribeFromPharoPackageCoderModel ].
	pharoPackageCoderModel := aPharoPackageCoderModel.

	self onPharoPackageCoderModelChanged.
	self subscribeToPharoPackageCoderModel
]

{ #category : 'api - pharo package coder model' }
TGtWithPharoPackageCoderModel >> subscribeToPharoPackageCoderModel [
	"Is sent after a new pharoPackageCoder model is assigned to the view model.
	It is required to unsubscribe from the domain model by implementing
	#unsubscribeFromPharoPackageCoderModel if view model subscribes to them"
]

{ #category : 'api - pharo package coder model' }
TGtWithPharoPackageCoderModel >> unsubscribeFromPharoPackageCoderModel [
	"Is sent before a new pharoPackageCoder model is assigned to the view model.
	View models that subscribe to pharoPackageCoder model are required to implement this methods"
]
