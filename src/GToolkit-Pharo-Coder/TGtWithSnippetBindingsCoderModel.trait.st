"
!! Generation
${class:TGtWithSnippetBindingsCoderModel}$ was automatically generated with the following code:
[[[
GtWithDomainModelTraitGenerator new
	modelName: 'snippetBindingsCoder';
	projectPrefix: 'Gt';
	packageName: 'GToolkit-Pharo-Coder-Coders';
	tagName: '';
	generate
]]] 

"
Trait {
	#name : 'TGtWithSnippetBindingsCoderModel',
	#instVars : [
		'snippetBindingsCoderModel'
	],
	#category : 'GToolkit-Pharo-Coder-Coders'
}

{ #category : 'api - snippet bindings coder model' }
TGtWithSnippetBindingsCoderModel >> hasSnippetBindingsCoder [
	"Return a true if snippetBindingsCoder model is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester>

	^ snippetBindingsCoderModel notNil
]

{ #category : 'api - snippet bindings coder model' }
TGtWithSnippetBindingsCoderModel >> onSnippetBindingsCoderModelChanged [
	"Is sent when a new snippetBindingsCoder model is assigned to the view model"
]

{ #category : 'api - snippet bindings coder model' }
TGtWithSnippetBindingsCoderModel >> snippetBindingsCoderModel [
	"Return a not-null snippetBindingsCoder model assigned to the receiver view model"
	<modelGetter>
	self
		assert: [ snippetBindingsCoderModel notNil ]
		description: [ 'snippetBindingsCoder model should be initialized' ].

	^ snippetBindingsCoderModel
]

{ #category : 'api - snippet bindings coder model' }
TGtWithSnippetBindingsCoderModel >> snippetBindingsCoderModel: aSnippetBindingsCoderModel [
	"Set a not-null snippetBindingsCoder domain model assigned to the receiver view model"
	<modelSetter>
	self
		assert: [ aSnippetBindingsCoderModel notNil ]
		description: [ 'snippetBindingsCoder model must not be nil' ].

	snippetBindingsCoderModel == aSnippetBindingsCoderModel 
		ifTrue: [ ^ self ].

	snippetBindingsCoderModel ifNotNil: [ self unsubscribeFromSnippetBindingsCoderModel ].
	snippetBindingsCoderModel := aSnippetBindingsCoderModel.

	self onSnippetBindingsCoderModelChanged.
	self subscribeToSnippetBindingsCoderModel
]

{ #category : 'api - snippet bindings coder model' }
TGtWithSnippetBindingsCoderModel >> subscribeToSnippetBindingsCoderModel [
	"Is sent after a new snippetBindingsCoder model is assigned to the view model.
	It is required to unsubscribe from the domain model by implementing
	#unsubscribeFromSnippetBindingsCoderModel if view model subscribes to them"
]

{ #category : 'api - snippet bindings coder model' }
TGtWithSnippetBindingsCoderModel >> unsubscribeFromSnippetBindingsCoderModel [
	"Is sent before a new snippetBindingsCoder model is assigned to the view model.
	View models that subscribe to snippetBindingsCoder model are required to implement this methods"
]
