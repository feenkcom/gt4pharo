Class {
	#name : #GtMethodAdviceFixItAction,
	#superclass : #GtFixItAction,
	#category : #'GToolkit-Pharo-Coder-AddOns-MethodAdvices-FixIt'
}

{ #category : #examples }
GtMethodAdviceFixItAction class >> testOriginal: originalSource generates: modifiedSource forNode: nodeBlock [
	^ self
		testOriginal: originalSource
		generates: modifiedSource
		forNode: nodeBlock
		configure: [ :node |  ]
]

{ #category : #examples }
GtMethodAdviceFixItAction class >> testOriginal: originalSource generates: modifiedSource forNode: nodeBlock configure: configureBlock [
	| source ast element action coder |
	source := originalSource.
	ast := GtPharoParser parse: source.
	coder := GtPharoMethodCoder forClass: self source: source.
	action := self forCoder: coder node: (nodeBlock value: ast).
	configureBlock value: action.
	element := coder asElement.
	element
		allChildrenBreadthFirstDetect: [ :each | each isKindOf: BrEditorElement ]
		ifFound: [ :editor | action executeOn: editor ].
	self assert: coder currentSourceString equals: modifiedSource.
	^ element
]

{ #category : #executing }
GtMethodAdviceFixItAction >> basicExecuteOn: anEditorElement [
	| newSource |
	newSource := sourceCoder currentSourceString.
	newSource = node topParent completeSource asString ifFalse: [ ^ self ].
	newSource := self updateSource.
	sourceCoder currentSourceString: newSource
]

{ #category : #executing }
GtMethodAdviceFixItAction >> deleteStartOfLineWhitespace: aSmaCCString before: aNode [
	| index char |
	index := aNode startPosition - 1.
	[ index > 0
		and: [ (char := aSmaCCString at: index) = Character space
				or: [ char = Character tab ] ] ] whileTrue: [ index := index - 1 ].
	index > 0
		ifTrue: [ char = Character lf
				ifTrue: [ index := index - 1.
					index > 0
						ifTrue: [ (char := aSmaCCString at: index) = Character cr ifTrue: [ index := index - 1 ] ] ]
				ifFalse: [ char = Character cr ifTrue: [ index := index - 1 ] ] ].
	index + 1 = aNode startPosition ifTrue: [ ^ self ].
	aSmaCCString deleteFrom: index + 1 to: aNode startPosition - 1
]

{ #category : #'gt - extensions' }
GtMethodAdviceFixItAction >> gtViewDiffFor: aView [
	<gtView>
	^ aView explicit
		title: 'Diff';
		priority: 1;
		stencil: [ | previousContent newContent change |
			previousContent := self printForDiffSource: self updateSource.
			newContent := self printForDiffSource: sourceCoder currentSourceString.

			change := GtDiffBuilder
					computeDifferencesFrom: previousContent
					to: newContent
					using: GtSmaCCDiffSplitter forPharo.
			GtDiffElementWithLabelStencil new
				fromLabelText: 'Current:';
				toLabelText: 'Change:';
				change: change;
				styler: GtCodeDiffRBTextStyler new ]
]

{ #category : #'gt - extensions' }
GtMethodAdviceFixItAction >> printForDiffSource: aString [
	^ String
		streamContents: [ :aStream | 
			sourceCoder isForMethod ifTrue: [
				aStream
					nextPutAll: '"protocol: ';
					nextPutAll: sourceCoder protocol;
					nextPut: $";
					cr;
					cr ].
			aStream
				nextPutAll: aString ]
]

{ #category : #executing }
GtMethodAdviceFixItAction >> updateSource [
	^ self subclassResponsibility
]
