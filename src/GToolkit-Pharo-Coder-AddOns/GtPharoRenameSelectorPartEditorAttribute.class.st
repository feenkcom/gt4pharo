Class {
	#name : #GtPharoRenameSelectorPartEditorAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#instVars : [
		'selectorPartModel'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #accessing }
GtPharoRenameSelectorPartEditorAttribute >> doAffect: aTBrTextEditorTextualPiece in: anEditorElement [
	| renameEditor |
	renameEditor := GtRenameEditor new
			fitContent;
			aptitude: (BrGlamorousEditableLabelAptitude new
					defaultBackground: Color transparent;
					defaultBorder: (BlBorder paint: BrGlamorousColors editorBorderColor);
					minWidth: 0);
			padding: (BlInsets left: 2 right: 2);
			margin: (BlInsets
					top: 0
					left: -2
					bottom: 0
					right: -2);
			text: selectorPartModel currentName.
			
	GtPharoRenameSelectorPartEditorAnnouncementHandler new
		editor: renameEditor;
		selectorPartModel: selectorPartModel;
		install.

	^ renameEditor
]

{ #category : #initialization }
GtPharoRenameSelectorPartEditorAttribute >> initialize [
	super initialize.

	self beReplace.
	self beNotOverwritableByStyler
]

{ #category : #accessing }
GtPharoRenameSelectorPartEditorAttribute >> selectorPartModel [
	^ selectorPartModel
]

{ #category : #accessing }
GtPharoRenameSelectorPartEditorAttribute >> selectorPartModel: anObject [
	selectorPartModel := anObject
]
