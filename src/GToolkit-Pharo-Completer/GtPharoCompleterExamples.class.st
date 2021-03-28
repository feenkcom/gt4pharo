Class {
	#name : #GtPharoCompleterExamples,
	#superclass : #Object,
	#instVars : [
		'space'
	],
	#category : #'GToolkit-Pharo-Completer-Examples'
}

{ #category : #smalltalk }
GtPharoCompleterExamples >> methodSourceCompleter [
	<gtExample>
	| text styler editor editorElement completionStrategy completionController method ast |
	text := '' asRopedText.
	text attribute: (BlFontSizeAttribute size: 14) beNotOverwritableByStyler.
	method := OrderedCollection >> #addAll:.
	ast := GtPharoParser parse: method sourceCode.
	styler := BrRBMethodBodyTextStyler new.
	styler classOrMetaClass: method methodClass.
	styler methodPatternSource: ast pattern source.
	editor := BrTextEditor new.
	editor styler: styler.
	editor text: text.
	editorElement := BrEditorElement new.
	editorElement
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	editorElement editor: editor.
	completionStrategy := GtPharoCompletionStrategy new.
	completionStrategy classOrMetaClass: method methodClass.
	completionStrategy methodPattern: ast pattern.
	completionController := GtCompletionController on: editorElement strategy: completionStrategy.
	completionController install.
	^ editorElement
]

{ #category : #smalltalk }
GtPharoCompleterExamples >> smalltalkCompleter [
	<gtExample>
	| text styler editor editorElement completionStrategy completionController |
	text := '' asRopedText.
	text
		attributes: { (BlFontSizeAttribute size: 14) beNotOverwritableByStyler }.
	styler := BrRBTextStyler new.
	styler classOrMetaClass: GtPharoCompletionStrategy.
	editor := BrTextEditor new.
	editor styler: styler.
	editor text: text.
	editorElement := BrEditorElement new.
	editorElement
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	editorElement editor: editor.
	completionStrategy := self smalltalkStrategy.
	completionController := GtCompletionController on: editorElement strategy: completionStrategy.
	completionController install.
	^ editorElement
]

{ #category : #strategies }
GtPharoCompleterExamples >> smalltalkStrategy [
	<gtExample>
	| completionStrategy |
	completionStrategy := GtPharoCompletionStrategy newForMethod.
	completionStrategy classOrMetaClass: GtPharoCompletionStrategy.
	^ completionStrategy
]
