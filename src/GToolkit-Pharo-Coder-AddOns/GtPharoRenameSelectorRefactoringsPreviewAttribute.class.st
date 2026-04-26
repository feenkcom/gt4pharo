Class {
	#name : #GtPharoRenameSelectorRefactoringsPreviewAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#instVars : [
		'selectorModel',
		'refactoringsConfiguration'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #accessing }
GtPharoRenameSelectorRefactoringsPreviewAttribute >> doAffect: aTBrTextEditorTextualPiece in: anEditorElement [
	| anElement |
	anElement := GtPharoRenameSelectorRefactoringsPreviewElement new
			selectorModel: selectorModel.

	refactoringsConfiguration
		ifNotNil: [ :aConfiguration | anElement configureWith: aConfiguration ].

	^ anElement
]

{ #category : #printing }
GtPharoRenameSelectorRefactoringsPreviewAttribute >> gtDisplayOn: aStream [
	aStream nextPutAll: 'Refactorings preview attribute'
]

{ #category : #initialization }
GtPharoRenameSelectorRefactoringsPreviewAttribute >> initialize [
	super initialize.

	self beAppend.
	self beNotOverwritableByStyler
]

{ #category : #accessing }
GtPharoRenameSelectorRefactoringsPreviewAttribute >> refactoringsConfiguration [
	^ refactoringsConfiguration
]

{ #category : #accessing }
GtPharoRenameSelectorRefactoringsPreviewAttribute >> refactoringsConfiguration: anObject [
	refactoringsConfiguration := anObject
]

{ #category : #accessing }
GtPharoRenameSelectorRefactoringsPreviewAttribute >> selectorModel [
	^ selectorModel
]

{ #category : #accessing }
GtPharoRenameSelectorRefactoringsPreviewAttribute >> selectorModel: anObject [
	selectorModel := anObject
]
