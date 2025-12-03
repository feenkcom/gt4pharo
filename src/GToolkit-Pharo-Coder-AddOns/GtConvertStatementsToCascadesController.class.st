Class {
	#name : #GtConvertStatementsToCascadesController,
	#superclass : #GtPharoSourceCoderRefactoringController,
	#instVars : [
		'nodes'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-Refactoring - Method'
}

{ #category : #accessing }
GtConvertStatementsToCascadesController >> foo [
	| str |
	str := WriteStream on: ''.
	str nextPutAll: 'bar'.
	str nextPutAll: 'bar'.
	str nextPutAll: 'bar'.
	str
		nextPutAll: 'bar';
		nextPutAll: 'bar'.
	str nextPutAll: 'bar'.
	str cr.
	^ str contents
]

{ #category : #accessing }
GtConvertStatementsToCascadesController >> nodes: aCollection [
	nodes := aCollection
]

{ #category : #accessing }
GtConvertStatementsToCascadesController >> refactoring [
	| refactoring model |
	model := self createRefactoringModel.
	refactoring := GtConvertStatementsToCascadesRefactoring
			model: model
			convert: (nodes first startPosition to: nodes last stopPosition)
			inMethod: sourceCoderViewModel coderModel currentSelector
			forClass: (model classFor: sourceCoderViewModel behavior).
	^ refactoring
]

{ #category : #accessing }
GtConvertStatementsToCascadesController >> refactoringName [
	^ 'Convert statements to cascades'
]

{ #category : #accessing }
GtConvertStatementsToCascadesController >> safelyExecute [
	| refactoring newSource |
	refactoring := self refactoring.
	sourceCoderViewModel selectNone.
	[ refactoring primitiveExecute ] on: RBRefactoringError do: [ :ex | ^ false ].
	newSource := (refactoring model classFor: sourceCoderViewModel behavior)
			sourceCodeFor: sourceCoderViewModel selector.
	sourceCoderViewModel sourceText asString = newSource
		ifFalse: [ self setText: newSource asText ]
]
