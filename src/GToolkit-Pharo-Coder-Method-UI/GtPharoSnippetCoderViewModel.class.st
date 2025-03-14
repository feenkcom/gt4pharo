Class {
	#name : #GtPharoSnippetCoderViewModel,
	#superclass : #GtPharoSourceCoderViewModel,
	#instVars : [
		'context',
		'sharedBindings',
		'variableValueToggleModel'
	],
	#category : #'GToolkit-Pharo-Coder-Method-UI-! View Models'
}

{ #category : #accessing }
GtPharoSnippetCoderViewModel >> allowSaveDueTo: anObject [
	"do nothing"
]

{ #category : #'api - coder model' }
GtPharoSnippetCoderViewModel >> behavior [
	^ self ifSelfObject: [ :each | each class ] ifNone: [ UndefinedObject ]
]

{ #category : #'private - bindings' }
GtPharoSnippetCoderViewModel >> compositeVariableBindings [
	| theBindings |
	theBindings := super compositeVariableBindings.
	context ifNotNil: [ :aContext | 
		theBindings addBindings: (GtContextVariablesBindings new 
			context: aContext) ].
	theBindings addBindings: sharedBindings.
	
	^ theBindings
]

{ #category : #accessing }
GtPharoSnippetCoderViewModel >> context [
	^ context
]

{ #category : #accessing }
GtPharoSnippetCoderViewModel >> context: anObject [
	context := anObject
]

{ #category : #'private - evaluation' }
GtPharoSnippetCoderViewModel >> evaluationContext [
	^ super evaluationContext
		runtimeContext: self context
]

{ #category : #accessing }
GtPharoSnippetCoderViewModel >> gtBindingsFor: aView [
	<gtView>
	^ aView forward
		title: 'Bindings';
		object: [sharedBindings];
		view: #gtBindingsFor:
]

{ #category : #'api - coder model' }
GtPharoSnippetCoderViewModel >> hasDeclaredVariableNamed: aVariableName [
	"Return true if a variable with a given name is declared"
	<return: #Boolean>

	(super hasDeclaredVariableNamed: aVariableName)
		ifTrue: [ ^ true ].

	"in case of the workspace we ignore non-capitalized variables as they are temporary variables
	and are always declared"
	aVariableName first isUppercase not
		ifTrue: [ ^ true ].

	^ false
]

{ #category : #initialization }
GtPharoSnippetCoderViewModel >> initialize [
	super initialize.
	
	sharedBindings := GtSharedVariablesBindings new
]

{ #category : #'private - bindings' }
GtPharoSnippetCoderViewModel >> localSnippetVariableBindings [
	| theBindings |
	theBindings := GtCompositeVariablesBindings new.
	theBindings addBindings: localBindings.
	theBindings addBindings: sharedBindings.
	^ theBindings
]

{ #category : #accessing }
GtPharoSnippetCoderViewModel >> newCompletionStrategy [
	| strategy |
	strategy := super newCompletionStrategy
		isMethod: false;
		hasImplicitVariables: true;
		yourself.
	^ strategy
]

{ #category : #'api - coder model' }
GtPharoSnippetCoderViewModel >> onCoderModelChanged [
	super onCoderModelChanged.

	self localBindings
		localAt: #thisCoderViewModel
		put: self.
		
	self localBindings
		localAt: #thisCoder
		put: self coderModel.
		
	self updateCompletionBindings
]

{ #category : #accessing }
GtPharoSnippetCoderViewModel >> onSelfObjectHolderChanged [
	super onSelfObjectHolderChanged.

	coderModel ifNotNil: [ coderModel behavior: self behavior ]
]

{ #category : #accessing }
GtPharoSnippetCoderViewModel >> preventSaveDueTo: anObject [
	"do nothing"
]

{ #category : #'api - actions' }
GtPharoSnippetCoderViewModel >> profileWithMessageTally [
	<return: #Boolean>

	^ self coderModel profileWithMessageTallyInContext: self evaluationContext
]

{ #category : #'api - bindings' }
GtPharoSnippetCoderViewModel >> sharedBindings [
	<return: #GtSharedVariablesBindings>

	^ sharedBindings
]

{ #category : #'api - bindings' }
GtPharoSnippetCoderViewModel >> sharedBindings: aGtSharedVariablesBindings [
	sharedBindings := aGtSharedVariablesBindings.
	self updateCompletionBindings
]

{ #category : #'api - coder model' }
GtPharoSnippetCoderViewModel >> updateCompletionBindings [
	self completionStrategy bindings: self localSnippetVariableBindings
]

{ #category : #accessing }
GtPharoSnippetCoderViewModel >> variableValueToggleModel [
	^variableValueToggleModel
]

{ #category : #accessing }
GtPharoSnippetCoderViewModel >> variableValueToggleModel: aModel [
	variableValueToggleModel := aModel
]
