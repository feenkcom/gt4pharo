"
I display a behavior (class or trait) definition snippet.
"
Class {
	#name : #GtPharoBehaviorDefinitionSnippetCoder,
	#superclass : #GtPharoSourceCoder,
	#instVars : [
		'behavior'
	],
	#category : #'GToolkit-Pharo-Coder-Method-Coder'
}

{ #category : #'instance creation' }
GtPharoBehaviorDefinitionSnippetCoder class >> forBehavior: aBehavior [
	^ self new behavior: aBehavior
]

{ #category : #accessing }
GtPharoBehaviorDefinitionSnippetCoder >> behavior [
	^ behavior ifNil: [ super behavior ]
]

{ #category : #accessing }
GtPharoBehaviorDefinitionSnippetCoder >> behavior: aBehavior [
	behavior = aBehavior instanceSide ifTrue: [ ^ self ].

	behavior := aBehavior instanceSide.
	self updateBehaviorSource.
]

{ #category : #'api - ast' }
GtPharoBehaviorDefinitionSnippetCoder >> computeAst: theSourceString [
	^ GtPharoParser
		parseWithErrors: theSourceString
		startingAt: GtPharoParser startingStateForMethodSequence
]

{ #category : #initialization }
GtPharoBehaviorDefinitionSnippetCoder >> forSource: aString [
	self sourceCode: (GtCoderExplicitStringSource new source: aString)
]

{ #category : #accessing }
GtPharoBehaviorDefinitionSnippetCoder >> implicitVariableNames [
	| variables |
	variables := Set new.
	self astSync
		allNodesDo: [ :each | 
			(each isErrorNode not
				and: [ each isVariable
						and: [ each parent isAssignment
								and: [ each parent variable == each and: [ each whoDefines isNil ] ] ] ])
				ifTrue: [ variables add: each name source ] ].
	^ variables
]

{ #category : #'private - event handling' }
GtPharoBehaviorDefinitionSnippetCoder >> implicitVariableReferencesTo: aString do: aBlock [
	self astSync
		allNodesDo: [ :each | 
			(each isVariable
				and: [ (aString sameContentAs: each variableName asString)
						and: [ each whoDefines isNil ] ]) ifTrue: [ aBlock value: each ] ]
]

{ #category : #initialization }
GtPharoBehaviorDefinitionSnippetCoder >> initialize [	
	super initialize.

	self forSource: ''
]

{ #category : #'private - actions' }
GtPharoBehaviorDefinitionSnippetCoder >> newEvaluationContext [
	^ GtPharoMethodCoderCompilationContext new
]

{ #category : #'private - ast rb' }
GtPharoBehaviorDefinitionSnippetCoder >> newRbAST: aString [
	| ast |
	ast := self
		parseExpression: aString
		requestor: GtLocalVariablesBindings new.
	ast doSemanticAnalysis.
	^ ast
]

{ #category : #'private - event handling' }
GtPharoBehaviorDefinitionSnippetCoder >> onClassChanged: anAnnouncement [

	(anAnnouncement classAffected == behavior or: [ 
		 anAnnouncement classAffected == behavior class ]) ifFalse: [ 
		^ self ].
	
	self updateBehaviorSource.
	self announce: (GtCoderClassChanged new coder: self)
]

{ #category : #'private - actions' }
GtPharoBehaviorDefinitionSnippetCoder >> primitiveEvaluate: aSourceString inContext: aGtPharoSourceCoderEvaluationContext onFailDo: anEvaluationFailBlock [
	"I compile class definition. If the result is a class builder, I install the given class.
	I return a defined class."

	| aResult |
	aResult := super
			primitiveEvaluate: aSourceString
			inContext: aGtPharoSourceCoderEvaluationContext
			onFailDo: anEvaluationFailBlock.
			
	(aResult isKindOf: ShiftClassBuilder) ifFalse: [ ^ aResult ].
	
	^ aResult install
]

{ #category : #'private - subscriptions' }
GtPharoBehaviorDefinitionSnippetCoder >> subscribeToSystem [
	self isSubscribedToSystem ifTrue: [ ^ self ].

	SystemAnnouncer uniqueInstance weak
		when: ClassAnnouncement
			send: #onClassChanged:
			to: self
]

{ #category : #'private - actions' }
GtPharoBehaviorDefinitionSnippetCoder >> updateBehaviorSource [
	behavior ifNil: [ ^ self ].
	self
		sourceCodeSynchronously: (GtCoderExplicitStringSource new source: behavior definitionString)
]
