Class {
	#name : #GtRefactoringsWithInputPreviewElement,
	#superclass : #GtRefactoringsPreviewButton,
	#instVars : [
		'editorElement'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings'
}

{ #category : #accessing }
GtRefactoringsWithInputPreviewElement >> buildPreviewForButton: previewButton [
	| pane |
	pane := BrVerticalPane new.
	pane fitContent.
	editorElement
		ifNotNil: [ editorElement removeFromParent.
			pane addChild: editorElement ].
	self refactorings notEmpty
		ifTrue: [ pane addChild: (self buildAsyncPreviewForButton: previewButton) as: #preview ].
	^ pane
]

{ #category : #accessing }
GtRefactoringsWithInputPreviewElement >> editorElement [
	^ editorElement
]

{ #category : #accessing }
GtRefactoringsWithInputPreviewElement >> editorElement: anObject [
	editorElement := anObject
]

{ #category : #accessing }
GtRefactoringsWithInputPreviewElement >> refactorings: aBlock [
	| pane |
	super refactorings: aBlock.
	executedRefactorings := nil.
	editorElement ifNil: [ ^ self ].
	pane := editorElement parent.
	pane ifNil: [ ^ self ].
	pane removeChildNamed: #preview.
	pane
		addChild: (self buildPreviewForButton: (self childNamed: #previewCheckButton))
		as: #preview
]

{ #category : #testing }
GtRefactoringsWithInputPreviewElement >> shouldFocusAcceptButton [
	^ false
]
