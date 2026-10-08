Class {
	#name : #GtBehaviorCoderByScripterRustEditorExamples,
	#superclass : #Object,
	#instVars : [
		'isNewFluentStylableAPI',
		'defaultExpandedElementStencilClass'
	],
	#category : #'GToolkit-Pharo-Coder-Examples-RustEditor-Coders'
}

{ #category : #examples }
GtBehaviorCoderByScripterRustEditorExamples >> classCoderWithMethodRustTextEditor [
	"See https://github.com/feenkcom/gtoolkit-editor/issues/25"

	<gtExample>
	<after: #resetToDefaultTextEditor>
	| aScripter anElement |
	self setRustTextEditorAsDefault.
	aScripter := BlScripter new.
	anElement := GtCoder forMethod: GtPharoDummyOneObject >> #dummyThree.
	aScripter element: anElement.
	aScripter memoryLogger
		runFor: GtTextEditorMeasureSignal , GtTextEditorHandleMeasureSignal
				, GtTextEditorRequestLayoutSignal , GtTextEditorLayoutReadySignal
		during: [ :aStep | 
			aStep click
				// (GtPharoBehaviorExpanderId indexed: 1);
				play ].
	^ aScripter
]

{ #category : #support }
GtBehaviorCoderByScripterRustEditorExamples >> recordDefaultTextEditorSetup [
	defaultExpandedElementStencilClass := GtExpandableSourceCoderElement
			defaultExpandedElementStencilClass.
	isNewFluentStylableAPI := LeSnippetStylerVisitor isNewFluentStylableAPI
]

{ #category : #support }
GtBehaviorCoderByScripterRustEditorExamples >> resetToDefaultTextEditor [
	GtExpandableSourceCoderElement
		defaultExpandedElementStencilClass: defaultExpandedElementStencilClass.
	isNewFluentStylableAPI == true
		ifTrue: [ LeSnippetStylerVisitor useNewFluentStylableAPI ]
		ifFalse: [ LeSnippetStylerVisitor dontUseNewFluentStylableAPI ]
]

{ #category : #support }
GtBehaviorCoderByScripterRustEditorExamples >> setRustTextEditorAsDefault [
	self recordDefaultTextEditorSetup.
	GtExpandableSourceCoderElement
		defaultExpandedElementStencilClass: GtExpandedCoderElementWithRustTextEditorStencil.
	LeSnippetStylerVisitor useNewFluentStylableAPI
]
