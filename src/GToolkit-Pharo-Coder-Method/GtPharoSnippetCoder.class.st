Class {
	#name : #GtPharoSnippetCoder,
	#superclass : #GtPharoSourceCoder,
	#instVars : [
		'behavior'
	],
	#category : #'GToolkit-Pharo-Coder-Method-Coder'
}

{ #category : #'as yet unclassified' }
GtPharoSnippetCoder class >> forSource: aString [
	^ self new sourceCodeSynchronously: (GtCoderExplicitStringSource new source: aString)
]

{ #category : #accessing }
GtPharoSnippetCoder >> behavior [
	^ behavior ifNil: [ super behavior ]
]

{ #category : #accessing }
GtPharoSnippetCoder >> behavior: aBehavior [
	behavior := aBehavior
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

{ #category : #accessing }
GtPharoSnippetCoder >> implicitVariableNames [
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
GtPharoSnippetCoder >> implicitVariableReferencesTo: aString do: aBlock [
	self astSync
		allNodesDo: [ :each | 
			(each isVariable
				and: [ (aString sameContentAs: each variableName asString)
						and: [ each whoDefines isNil ] ]) ifTrue: [ aBlock value: each ] ]
]

{ #category : #initialization }
GtPharoSnippetCoder >> initialize [	
	super initialize.

	self forSource: ''
]

{ #category : #'private - actions' }
GtPharoSnippetCoder >> newEvaluationContext [
	^ GtPharoSnippetCoderEvaluationContext new
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
		decorated: [ :aSourceString | 'MessageTally on: [ ' , aSourceString , ']' ]
		inContext: aGtPharoCoderEvaluationContext
		thenDo: [ :anEvaluationResult | 
			self
				notifyObjectSpawnFromEvaluationResult: anEvaluationResult
				requesterObject: aGtPharoCoderEvaluationContext requesterObject ]
]
