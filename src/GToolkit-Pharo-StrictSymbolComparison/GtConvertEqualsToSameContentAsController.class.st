Class {
	#name : #GtConvertEqualsToSameContentAsController,
	#superclass : #GtPharoSourceCoderRefactoringController,
	#instVars : [
		'nodes'
	],
	#category : #'GToolkit-Pharo-StrictSymbolComparison-Refactoring'
}

{ #category : #private }
GtConvertEqualsToSameContentAsController >> createRefactoringModel [

	^ Smalltalk createRbNamespace onEnvironment: RBBrowserEnvironment new
]

{ #category : #accessing }
GtConvertEqualsToSameContentAsController >> nodes: aCollection [
	nodes := aCollection
]

{ #category : #accessing }
GtConvertEqualsToSameContentAsController >> refactoring [
	| aModel |

	aModel := self createRefactoringModel.
	^ GtConvertEqualsToSameContentAsRefactoring
			model: aModel
			convert: nodes
			inMethod: sourceCoderViewModel coderModel currentSelector
			forClass: (sourceCoderViewModel behavior).
]

{ #category : #accessing }
GtConvertEqualsToSameContentAsController >> refactoringName [
	^ 'Convert #= to ', GtStrictSymbolEqualityArgumentSignal sameContentSelector
]

{ #category : #accessing }
GtConvertEqualsToSameContentAsController >> safelyExecute [
	| refactoring newSource |
	refactoring := self refactoring.
	sourceCoderViewModel selectNone.
	[ refactoring primitiveExecute ] on: RBRefactoringError do: [ :ex | ^ false ].
	newSource := refactoring newSource.
	sourceCoderViewModel sourceText asString = newSource
		ifFalse: [ self setText: newSource asText ]
]
