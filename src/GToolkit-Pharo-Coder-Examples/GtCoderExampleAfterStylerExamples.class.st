Class {
	#name : #GtCoderExampleAfterStylerExamples,
	#superclass : #Object,
	#category : 'GToolkit-Pharo-Coder-Examples-Stylers'
}

{ #category : #accessing }
GtCoderExampleAfterStylerExamples >> afterWithExpander [
	<gtExample>	
	| coder text allExpandedIntervals |
	coder := GtPharoMethodCoder forClass: GtCoderExampleAfterStylerExamples source: 'foo <gtExample> <after: #afterWithExpander>'.
	text := coder currentSourceText copy.
	GtCoderExampleAfterStyler new
		coderViewModel: coder asCoderViewModel;
		style: text ast: coder astSync.
	allExpandedIntervals := OrderedCollection new.
	text
		findAttributesSuchThat: [ :eachAttribute | 
			eachAttribute isKindOf: GtPharoMethodExpanderAttribute ]
		indicesDo: [ :aStartPosition :anEndPosition | 
			allExpandedIntervals add: (aStartPosition to: anEndPosition) ].
	self assert: allExpandedIntervals size equals: 1.
	self 
		assert: allExpandedIntervals asArray 
		equals: { text size - 1 to: text size - 1 }.
	^ text
]

{ #category : #accessing }
GtCoderExampleAfterStylerExamples >> afterWithoutExpander [
	<gtExample>	
	| coder text allExpandedIntervals |
	coder := GtPharoMethodCoder forClass: GtCoderExampleAfterStylerExamples source: 'foo <gtExample> <after: #afterThatDoesNotExist>'.
	text := coder currentSourceText copy.
	GtCoderExampleAfterStyler new
		coderViewModel: coder asCoderViewModel;
		style: text ast: coder astSync.
	allExpandedIntervals := OrderedCollection new.
	text
		findAttributesSuchThat: [ :eachAttribute | 
			eachAttribute isKindOf: GtPharoMethodExpanderAttribute ]
		indicesDo: [ :aStartPosition :anEndPosition | 
			allExpandedIntervals add: (aStartPosition to: anEndPosition) ].
	self assert: allExpandedIntervals isEmpty.
	^ text
]
