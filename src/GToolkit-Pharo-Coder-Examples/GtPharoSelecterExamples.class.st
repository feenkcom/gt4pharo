Class {
	#name : #GtPharoSelecterExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Examples'
}

{ #category : #'as yet unclassified' }
GtPharoSelecterExamples >> editorFor: aText [
	<return: #BrEditor>
	| anEditor aRopedText |

	aRopedText := aText asRopedText.

	anEditor := BrEditor new.
	anEditor editor beParagraphBased.
	anEditor aptitude: BrEditorAptitude new.
	anEditor padding: BlInsets empty.
	anEditor fitContent.
	anEditor text: aRopedText.
	
	BlDevCrossover on: anEditor.
	
	"anEditor editor segmentBuilder
		wordStencil: [ :aTBrTextEditorTextualPiece |
			| aTextElement |
			aTextElement := BrTextEditableWordPieceStencilBuilder new
				segmentPiece: aTBrTextEditorTextualPiece;
				asElement.
			aTextElement measurer: self fixedMeasurer.
			aTextElement measurer textOffset: aTBrTextEditorTextualPiece textStart.
			aTextElement ]."
	
	anEditor requestFocus.
	anEditor forceLayout.

	^ anEditor
]

{ #category : #examples }
GtPharoSelecterExamples >> editorOnCode [
	<gtExample>
	| anEditor anEditorElement |
	
	anEditorElement := self editorFor: self exampleSmalltalkCode.
	anEditor := anEditorElement editor.
	anEditor doubleClickWordClassifier: BrTextEditorModel smalltalkWordClassifier.
	anEditor movementWordClassifier: BrTextEditorModel smalltalkWordClassifier.
	
	self assert: anEditor cursors isEmpty.
	self assert: anEditor selection isEmpty.
	^anEditorElement
	
]

{ #category : #examples }
GtPharoSelecterExamples >> editorOnEmpty [
	<gtExample>
	| anEditor anEditorElement |
	
	anEditorElement := self editorFor: ''.
	anEditor := anEditorElement editor.
	anEditor doubleClickWordClassifier: BrTextEditorModel smalltalkWordClassifier.
	anEditor movementWordClassifier: BrTextEditorModel smalltalkWordClassifier.
	
	self assert: anEditor cursors isEmpty.
	self assert: anEditor selection isEmpty.
	^anEditorElement
	
]

{ #category : #examples }
GtPharoSelecterExamples >> exampleSmalltalkCode [
	<gtExample>
	^'at: anIndex put: aValue
	| x |
	self do: [:each | each foo].
	x := anIndex + (anIndex * 2).
	^x'
]

{ #category : #examples }
GtPharoSelecterExamples >> selectWordAtEnd [
	<gtExample>
	| editor |
	editor := self editorOnCode.
	editor selecter
		selectionUnitAt: 95;
		select.
	self 
		assert: editor selection 
		equals: (BlCompositeSelection new select: 94 to: 95).
	^ editor
]

{ #category : #examples }
GtPharoSelecterExamples >> selectWordAtIndex [
	<gtExample>
	| editor |
	editor := self editorOnCode.
	editor selecter
		selectionUnitAt: 6;
		select.
	self 
		assert: editor selection 
		equals: (BlCompositeSelection new select: 4 to: 11).
	^ editor
]

{ #category : #examples }
GtPharoSelecterExamples >> selectWordAtNextToEnd [
	<gtExample>
	| editor |
	editor := self editorOnCode.
	editor selecter
		selectionUnitAt: 94;
		select.
	self 
		assert: editor selection 
		equals: (BlCompositeSelection new select: 94 to: 95).
	^ editor
]

{ #category : #examples }
GtPharoSelecterExamples >> selectWordOnEmpty [
	<gtExample>
	| editor |
	editor := self editorOnEmpty.
	editor selecter
		selectionUnitAt: 1;
		select.
	self assert: editor selection isEmpty.
	^ editor
]

{ #category : #examples }
GtPharoSelecterExamples >> selectWordWithLeadingColon [
	<gtExample>
	| editor |
	editor := self editorOnCode.
	editor selecter
		selectionUnitAt: 45;
		select.
	self 
		assert: editor selection 
		equals: (BlCompositeSelection new select: 43 to: 47).
	^ editor
]

{ #category : #examples }
GtPharoSelecterExamples >> selectWordWithLeadingParenthesis [
	<gtExample>
	| editor |
	editor := self editorOnCode.
	editor selecter
		selectionUnitAt: 81;
		select.
	self 
		assert: editor selection 
		equals: (BlCompositeSelection new select: 78 to: 85).
	^ editor
]

{ #category : #examples }
GtPharoSelecterExamples >> selectWordWithTrailingColon [
	<gtExample>
	| editor |
	editor := self editorOnCode.
	editor selecter
		selectionUnitAt: 13;
		select.
	self 
		assert: editor selection 
		equals: (BlCompositeSelection new select: 12 to: 16).
	^ editor
]
