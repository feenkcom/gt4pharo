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
GtPharoBehaviorDefinitionSnippetCoder class >> forSource: aString [
	^ self new sourceCodeSynchronously: (GtCoderExplicitStringSource new source: aString)
]

{ #category : #accessing }
GtPharoBehaviorDefinitionSnippetCoder >> behavior [
	^ behavior ifNil: [ super behavior ]
]

{ #category : #accessing }
GtPharoBehaviorDefinitionSnippetCoder >> behavior: aBehavior [
	behavior := aBehavior
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
	^ GtPharoSnippetCoderEvaluationContext new
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

{ #category : #'private - actions' }
GtPharoBehaviorDefinitionSnippetCoder >> primitiveEvaluate: aSourceString inContext: aGtPharoSourceCoderEvaluationContext onFailDo: anEvaluationFailBlock [
	| aResult |
	aResult := super
			primitiveEvaluate: aSourceString
			inContext: aGtPharoSourceCoderEvaluationContext
			onFailDo: anEvaluationFailBlock.
			
	(aResult isKindOf: ShiftClassBuilder) ifFalse: [ ^ aResult ].
	
	^ aResult install
]

{ #category : #'api - actions' }
GtPharoBehaviorDefinitionSnippetCoder >> profileWithMessageTallyInContext: aGtPharoCoderEvaluationContext [
	^ self
		evaluate: [ :thisCoder | thisCoder currentSourceString ]
		decorated: [ :aSourceString | 'MessageTally on: [ ' , aSourceString , ']' ]
		inContext: aGtPharoCoderEvaluationContext
		thenDo: [ :anEvaluationResult | 
			self
				notifyObjectSpawnFromEvaluationResult: anEvaluationResult
				requesterObject: aGtPharoCoderEvaluationContext requesterObject ]
]
