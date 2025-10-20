Class {
	#name : #GtPharoBehaviorDefinitionSnippetCoderViewModel,
	#superclass : #GtPharoSourceCoderViewModel,
	#instVars : [
		'context',
		'sharedBindings',
		'variableValueToggleModel'
	],
	#category : #'GToolkit-Pharo-Coder-Method-UI-! View Models'
}

{ #category : #accessing }
GtPharoBehaviorDefinitionSnippetCoderViewModel >> allowSaveDueTo: anObject [
	"do nothing"
]

{ #category : #'api - coder model' }
GtPharoBehaviorDefinitionSnippetCoderViewModel >> behavior [
	^ self ifSelfObject: [ :each | each class ] ifNone: [ UndefinedObject ]
]

{ #category : #'api - actions' }
GtPharoBehaviorDefinitionSnippetCoderViewModel >> compileIt [
	<return: #GtSourceCoderEvaluationResult>
	^ self doItAllRequestedBy: self
]

{ #category : #'private - bindings' }
GtPharoBehaviorDefinitionSnippetCoderViewModel >> compositeVariableBindings [
	| theBindings |
	theBindings := super compositeVariableBindings.
	context ifNotNil: [ :aContext | 
		theBindings addBindings: (GtContextVariablesBindings new 
			context: aContext) ].
	theBindings addBindings: sharedBindings.
	
	^ theBindings
]

{ #category : #accessing }
GtPharoBehaviorDefinitionSnippetCoderViewModel >> context [
	^ context
]

{ #category : #accessing }
GtPharoBehaviorDefinitionSnippetCoderViewModel >> context: anObject [
	context := anObject
]

{ #category : #'private - evaluation' }
GtPharoBehaviorDefinitionSnippetCoderViewModel >> evaluationContext [
	^ super evaluationContext
		runtimeContext: self context
]

{ #category : #accessing }
GtPharoBehaviorDefinitionSnippetCoderViewModel >> gtBindingsFor: aView [
	<gtView>
	^ aView forward
		title: 'Bindings';
		object: [sharedBindings];
		view: #gtBindingsFor:
]

{ #category : #'api - coder model' }
GtPharoBehaviorDefinitionSnippetCoderViewModel >> hasDeclaredVariableNamed: aVariableName [
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

{ #category : #'api - coder model' }
GtPharoBehaviorDefinitionSnippetCoderViewModel >> hasExplicitlyDeclaredVariableNamed: aVariableName [
	"Don't return true for implicitly defined variables"

	^ super hasDeclaredVariableNamed: aVariableName
]

{ #category : #initialization }
GtPharoBehaviorDefinitionSnippetCoderViewModel >> initialize [
	super initialize.
	
	sharedBindings := GtSharedVariablesBindings new
]

{ #category : #'private - bindings' }
GtPharoBehaviorDefinitionSnippetCoderViewModel >> localSnippetVariableBindings [
	| theBindings |
	theBindings := GtCompositeVariablesBindings new.
	theBindings addBindings: localBindings.
	theBindings addBindings: sharedBindings.
	^ theBindings
]

{ #category : #accessing }
GtPharoBehaviorDefinitionSnippetCoderViewModel >> newCompletionStrategy [
	| strategy |
	strategy := super newCompletionStrategy
		isMethod: false;
		hasImplicitVariables: true;
		yourself.
	^ strategy
]

{ #category : #'api - coder model' }
GtPharoBehaviorDefinitionSnippetCoderViewModel >> onCoderModelChanged [
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
GtPharoBehaviorDefinitionSnippetCoderViewModel >> onSelfObjectHolderChanged [
	super onSelfObjectHolderChanged.

	coderModel ifNotNil: [ coderModel behavior: self behavior ]
]

{ #category : #accessing }
GtPharoBehaviorDefinitionSnippetCoderViewModel >> preventSaveDueTo: anObject [
	"do nothing"
]

{ #category : #'api - actions' }
GtPharoBehaviorDefinitionSnippetCoderViewModel >> profileWithMessageTally [
	<return: #Boolean>

	^ self coderModel profileWithMessageTallyInContext: self evaluationContext
]

{ #category : #'api - bindings' }
GtPharoBehaviorDefinitionSnippetCoderViewModel >> sharedBindings [
	<return: #GtSharedVariablesBindings>

	^ sharedBindings
]

{ #category : #'api - bindings' }
GtPharoBehaviorDefinitionSnippetCoderViewModel >> sharedBindings: aGtSharedVariablesBindings [
	sharedBindings := aGtSharedVariablesBindings.
	self updateCompletionBindings
]

{ #category : #'api - coder model' }
GtPharoBehaviorDefinitionSnippetCoderViewModel >> updateCompletionBindings [
	self completionStrategy bindings: self localSnippetVariableBindings
]

{ #category : #accessing }
GtPharoBehaviorDefinitionSnippetCoderViewModel >> variableValueToggleModel [
	^variableValueToggleModel
]

{ #category : #accessing }
GtPharoBehaviorDefinitionSnippetCoderViewModel >> variableValueToggleModel: aModel [
	variableValueToggleModel := aModel
]
