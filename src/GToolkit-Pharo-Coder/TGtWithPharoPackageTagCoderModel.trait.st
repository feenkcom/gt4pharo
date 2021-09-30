"
!! Generation
${class:TGtWithPharoPackageTagCoderModel}$ was automatically generated with the following code:
[[[
GtWithDomainModelTraitGenerator new
	modelName: 'pharoPackageTagCoder';
	projectPrefix: 'Gt';
	packageName: 'GToolkit-Pharo-Coder-Coders';
	generate
]]] 

"
Trait {
	#name : #TGtWithPharoPackageTagCoderModel,
	#instVars : [
		'pharoPackageTagCoderModel'
	],
	#category : 'GToolkit-Pharo-Coder-Coders'
}

{ #category : #'api - pharo package tag coder model' }
TGtWithPharoPackageTagCoderModel >> hasPharoPackageTagCoder [
	"Return a true if pharoPackageTagCoder model is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester>

	^ pharoPackageTagCoderModel notNil
]

{ #category : #'api - pharo package tag coder model' }
TGtWithPharoPackageTagCoderModel >> onPharoPackageTagCoderModelChanged [
	"Is sent when a new pharoPackageTagCoder model is assigned to the view model"
]

{ #category : #'api - pharo package tag coder model' }
TGtWithPharoPackageTagCoderModel >> pharoPackageTagCoderModel [
	"Return a not-null pharoPackageTagCoder model assigned to the receiver view model"
	<modelGetter>
	self
		assert: [ pharoPackageTagCoderModel notNil ]
		description: [ 'pharoPackageTagCoder model should be initialized' ].

	^ pharoPackageTagCoderModel
]

{ #category : #'api - pharo package tag coder model' }
TGtWithPharoPackageTagCoderModel >> pharoPackageTagCoderModel: aPharoPackageTagCoderModel [
	"Set a not-null pharoPackageTagCoder domain model assigned to the receiver view model"
	<modelSetter>
	self
		assert: [ aPharoPackageTagCoderModel notNil ]
		description: [ 'pharoPackageTagCoder model must not be nil' ].

	pharoPackageTagCoderModel == aPharoPackageTagCoderModel 
		ifTrue: [ ^ self ].

	pharoPackageTagCoderModel ifNotNil: [ self unsubscribeFromPharoPackageTagCoderModel ].
	pharoPackageTagCoderModel := aPharoPackageTagCoderModel.

	self onPharoPackageTagCoderModelChanged.
	self subscribeToPharoPackageTagCoderModel
]

{ #category : #'api - pharo package tag coder model' }
TGtWithPharoPackageTagCoderModel >> subscribeToPharoPackageTagCoderModel [
	"Is sent after a new pharoPackageTagCoder model is assigned to the view model.
	It is required to unsubscribe from the domain model by implementing
	#unsubscribeFromPharoPackageTagCoderModel if view model subscribes to them"
]

{ #category : #'api - pharo package tag coder model' }
TGtWithPharoPackageTagCoderModel >> unsubscribeFromPharoPackageTagCoderModel [
	"Is sent before a new pharoPackageTagCoder model is assigned to the view model.
	View models that subscribe to pharoPackageTagCoder model are required to implement this methods"
]
