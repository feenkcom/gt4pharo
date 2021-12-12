Class {
	#name : #GtPharoSnippetCoder,
	#superclass : #GtPharoSourceCoder,
	#instVars : [
		'xdocFilename'
	],
	#category : #'GToolkit-Pharo-Coder-Method-Coder'
}

{ #category : #'instance creation' }
GtPharoSnippetCoder class >> forSource: aString [
	^ self new sourceCodeSynchronously: (GtCoderExplicitStringSource new source: aString)
]

{ #category : #'api - ast' }
GtPharoSnippetCoder >> computeAst: theSourceString [
	^ GtPharoParser
		parseWithErrors: theSourceString
		startingAt: GtPharoParser startingStateForMethodSequence
]

{ #category : #initialization }
GtPharoSnippetCoder >> forSource: aString [
	self sourceCode: (GtCoderExplicitStringSource new source: aString)
]

{ #category : #'private - event handling' }
GtPharoSnippetCoder >> implicitVariableReferencesTo: aString do: aBlock [

	self astAwait
		allNodesDo:
			[ :each | (each isVariable and: [ aString = each variableName asString and: [ each whoDefines isNil ] ]) ifTrue: [ aBlock value: each ] ]
]

{ #category : #initialization }
GtPharoSnippetCoder >> initialize [	
	super initialize.

	self forSource: ''
]

{ #category : #private }
GtPharoSnippetCoder >> newCompletionStrategy [
	| strategy |
	strategy := super newCompletionStrategy
		isMethod: false;
		hasImplicitVariables: true;
		yourself.
	^ strategy
]

{ #category : #'private - ast rb' }
GtPharoSnippetCoder >> newRbAST: aString [
	| ast |
	ast := self
		parseExpression: aString
		requestor: GtLocalVariablesBindings new.
	ast doSemanticAnalysis.
	^ ast
]

{ #category : #'api - actions' }
GtPharoSnippetCoder >> profileWithMessageTallyInContext: aGtPharoCoderEvaluationContext [
	^ self
		evaluate: [ :thisCoder | thisCoder currentSourceString ]
		decorated: [ :aSourceString | 'MessageTally on: [ ', aSourceString, ']' ]
		inContext: aGtPharoCoderEvaluationContext
		thenDo: [ :anEvaluationResult | self notifyObjectSpawnFromEvaluationResult: anEvaluationResult ]
]
