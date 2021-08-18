"
!! Generation
${class:TGtWithPharoSnippetCoderModel}$ was automatically generated with the following code:
[[[
GtWithDomainModelTraitGenerator new
	modelName: 'pharoSnippetCoder';
	projectPrefix: 'Gt';
	packageName: 'GToolkit-Pharo-Coder-Coders';
	tagName: '';
	generate
]]] 

"
Trait {
	#name : 'TGtWithPharoSnippetCoderModel',
	#instVars : [
		'pharoSnippetCoderModel'
	],
	#category : 'GToolkit-Pharo-Coder-Coders'
}

{ #category : 'api - pharo snippet coder model' }
TGtWithPharoSnippetCoderModel >> hasPharoSnippetCoder [
	"Return a true if pharoSnippetCoder model is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester>

	^ pharoSnippetCoderModel notNil
]

{ #category : 'api - pharo snippet coder model' }
TGtWithPharoSnippetCoderModel >> onPharoSnippetCoderModelChanged [
	"Is sent when a new pharoSnippetCoder model is assigned to the view model"
]

{ #category : 'api - pharo snippet coder model' }
TGtWithPharoSnippetCoderModel >> pharoSnippetCoderModel [
	"Return a not-null pharoSnippetCoder model assigned to the receiver view model"
	<modelGetter>
	self
		assert: [ pharoSnippetCoderModel notNil ]
		description: [ 'pharoSnippetCoder model should be initialized' ].

	^ pharoSnippetCoderModel
]

{ #category : 'api - pharo snippet coder model' }
TGtWithPharoSnippetCoderModel >> pharoSnippetCoderModel: aPharoSnippetCoderModel [
	"Set a not-null pharoSnippetCoder domain model assigned to the receiver view model"
	<modelSetter>
	self
		assert: [ aPharoSnippetCoderModel notNil ]
		description: [ 'pharoSnippetCoder model must not be nil' ].

	pharoSnippetCoderModel == aPharoSnippetCoderModel 
		ifTrue: [ ^ self ].

	pharoSnippetCoderModel ifNotNil: [ self unsubscribeFromPharoSnippetCoderModel ].
	pharoSnippetCoderModel := aPharoSnippetCoderModel.

	self onPharoSnippetCoderModelChanged.
	self subscribeToPharoSnippetCoderModel
]

{ #category : 'api - pharo snippet coder model' }
TGtWithPharoSnippetCoderModel >> subscribeToPharoSnippetCoderModel [
	"Is sent after a new pharoSnippetCoder model is assigned to the view model.
	It is required to unsubscribe from the domain model by implementing
	#unsubscribeFromPharoSnippetCoderModel if view model subscribes to them"
]

{ #category : 'api - pharo snippet coder model' }
TGtWithPharoSnippetCoderModel >> unsubscribeFromPharoSnippetCoderModel [
	"Is sent before a new pharoSnippetCoder model is assigned to the view model.
	View models that subscribe to pharoSnippetCoder model are required to implement this methods"
]
