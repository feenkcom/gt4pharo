"
!! Generation
${class:TGtWithPharoPackagesCoderModel}$ was automatically generated with the following code:
[[[
GtWithDomainModelTraitGenerator new
	modelName: 'pharoPackagesCoder';
	projectPrefix: 'Gt';
	packageName: 'GToolkit-Pharo-Coder-Coders';
	generate
]]] 

"
Trait {
	#name : #TGtWithPharoPackagesCoderModel,
	#instVars : [
		'pharoPackagesCoderModel'
	],
	#category : 'GToolkit-Pharo-Coder-Coders'
}

{ #category : #'api - pharo packages coder model' }
TGtWithPharoPackagesCoderModel >> hasPharoPackagesCoder [
	"Return a true if pharoPackagesCoder model is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester>

	^ pharoPackagesCoderModel notNil
]

{ #category : #'api - pharo packages coder model' }
TGtWithPharoPackagesCoderModel >> onPharoPackagesCoderModelChanged [
	"Is sent when a new pharoPackagesCoder model is assigned to the view model"
]

{ #category : #'api - pharo packages coder model' }
TGtWithPharoPackagesCoderModel >> pharoPackagesCoderModel [
	"Return a not-null pharoPackagesCoder model assigned to the receiver view model"
	<modelGetter>
	self
		assert: [ pharoPackagesCoderModel notNil ]
		description: [ 'pharoPackagesCoder model should be initialized' ].

	^ pharoPackagesCoderModel
]

{ #category : #'api - pharo packages coder model' }
TGtWithPharoPackagesCoderModel >> pharoPackagesCoderModel: aPharoPackagesCoderModel [
	"Set a not-null pharoPackagesCoder domain model assigned to the receiver view model"
	<modelSetter>
	self
		assert: [ aPharoPackagesCoderModel notNil ]
		description: [ 'pharoPackagesCoder model must not be nil' ].

	pharoPackagesCoderModel == aPharoPackagesCoderModel 
		ifTrue: [ ^ self ].

	pharoPackagesCoderModel ifNotNil: [ self unsubscribeFromPharoPackagesCoderModel ].
	pharoPackagesCoderModel := aPharoPackagesCoderModel.

	self onPharoPackagesCoderModelChanged.
	self subscribeToPharoPackagesCoderModel
]

{ #category : #'api - pharo packages coder model' }
TGtWithPharoPackagesCoderModel >> subscribeToPharoPackagesCoderModel [
	"Is sent after a new pharoPackagesCoder model is assigned to the view model.
	It is required to unsubscribe from the domain model by implementing
	#unsubscribeFromPharoPackagesCoderModel if view model subscribes to them"
]

{ #category : #'api - pharo packages coder model' }
TGtWithPharoPackagesCoderModel >> unsubscribeFromPharoPackagesCoderModel [
	"Is sent before a new pharoPackagesCoder model is assigned to the view model.
	View models that subscribe to pharoPackagesCoder model are required to implement this methods"
]
