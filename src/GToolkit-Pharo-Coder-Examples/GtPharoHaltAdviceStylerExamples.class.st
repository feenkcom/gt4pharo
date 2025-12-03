Class {
	#name : #GtPharoHaltAdviceStylerExamples,
	#superclass : #Object,
	#traits : 'TCoderByScripterExamples',
	#classTraits : 'TCoderByScripterExamples classTrait',
	#category : 'GToolkit-Pharo-Coder-Examples-Stylers'
}

{ #category : #accessing }
GtPharoHaltAdviceStylerExamples >> haltNowHighlighted [
	<gtExample>
	| aCoder anAst aSourceText aRedInterval |
	
	aCoder := GtPharoSnippetCoder forSource: 'x := 42. Halt now. y := 42' asRopedText.

	anAst := aCoder astSync.
	aSourceText := aCoder currentSourceText copy unstyled.
	
	GtMethodAdviceStyler new
		advices: { GtHaltAdvice new };
		coderViewModel: aCoder asCoderViewModel;
		style: aSourceText
		ast: anAst.
	
	aRedInterval := 1 to: 0.
	aSourceText
		findAttributesSuchThat: [ :eachAttribute | (eachAttribute isKindOf: BlTextHighlightAttribute) and: [ eachAttribute paint = BrGlamorousColors paleErrorBackgroundColor ] ]
		indicesDo: [ :aStartPosition :anEndPosition | aRedInterval := aStartPosition to: anEndPosition ].	

	self assert: aRedInterval equals: (10 to: 17).

	^ aSourceText
]

{ #category : #accessing }
GtPharoHaltAdviceStylerExamples >> haltOnceHighlighted [
	<gtExample>
	| aCoder anAst aSourceText aRedInterval |
	
	aCoder := GtPharoSnippetCoder forSource: 'x := 42. Halt once. y := 42' asRopedText.

	anAst := aCoder astSync.
	aSourceText := aCoder currentSourceText copy unstyled.
	
	GtMethodAdviceStyler new
		advices: { GtHaltAdvice new };
		coderViewModel: aCoder asCoderViewModel;
		style: aSourceText
		ast: anAst.
	
	aRedInterval := 1 to: 0.
	aSourceText
		findAttributesSuchThat: [ :eachAttribute | (eachAttribute isKindOf: BlTextHighlightAttribute) and: [ eachAttribute paint = BrGlamorousColors paleErrorBackgroundColor ] ]
		indicesDo: [ :aStartPosition :anEndPosition | aRedInterval := aStartPosition to: anEndPosition ].	

	self assert: aRedInterval equals: (10 to: 18).

	^ aSourceText
]

{ #category : #accessing }
GtPharoHaltAdviceStylerExamples >> selfHaltHighlighted [
	<gtExample>
	| aCoder anAst aSourceText aRedInterval |
	
	aCoder := GtPharoSnippetCoder forSource: 'x := 42. self halt. y := 42' asRopedText.

	anAst := aCoder astSync.
	aSourceText := aCoder currentSourceText copy unstyled.
	
	GtMethodAdviceStyler new
		advices: { GtHaltAdvice new };
		coderViewModel: aCoder asCoderViewModel;
		style: aSourceText
		ast: anAst.
	
	aRedInterval := 1 to: 0.
	aSourceText
		findAttributesSuchThat: [ :eachAttribute | (eachAttribute isKindOf: BlTextHighlightAttribute) and: [ eachAttribute paint = BrGlamorousColors paleErrorBackgroundColor ] ]
		indicesDo: [ :aStartPosition :anEndPosition | aRedInterval := aStartPosition to: anEndPosition ].	

	self assert: aRedInterval equals: (15 to: 18).

	^ aSourceText
]

{ #category : #accessing }
GtPharoHaltAdviceStylerExamples >> selfHaltOnceHighlighted [

	<gtExample>
	| aCoder anAst aSourceText aRedInterval |
	aCoder := GtPharoSnippetCoder forSource:
		          'x := 42. self haltOnce. y := 42' asRopedText.

	anAst := aCoder astSync.
	aSourceText := aCoder currentSourceText copy unstyled.

	GtMethodAdviceStyler new
		advices: { GtHaltAdvice new };
		coderViewModel: aCoder asCoderViewModel;
		style: aSourceText ast: anAst.

	aRedInterval := 1 to: 0.
	aSourceText
		findAttributesSuchThat: [ :eachAttribute | 
			(eachAttribute isKindOf: BlTextHighlightAttribute) and: [ 
				eachAttribute paint = BrGlamorousColors paleErrorBackgroundColor ] ]
		indicesDo: [ :aStartPosition :anEndPosition | 
			aRedInterval := aStartPosition to: anEndPosition ].

	self assert: aRedInterval equals: (15 to: 22).

	^ aSourceText
]
