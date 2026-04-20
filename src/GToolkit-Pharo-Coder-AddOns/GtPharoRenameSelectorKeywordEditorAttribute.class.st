Class {
	#name : #GtPharoRenameSelectorKeywordEditorAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#instVars : [
		'keywordModel'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #accessing }
GtPharoRenameSelectorKeywordEditorAttribute >> doAffect: aTBrTextEditorTextualPiece in: anEditorElement [
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
			text: keywordModel currentName.

	^ renameEditor
]

{ #category : #accessing }
GtPharoRenameSelectorKeywordEditorAttribute >> keywordModel [
	^ keywordModel
]

{ #category : #accessing }
GtPharoRenameSelectorKeywordEditorAttribute >> keywordModel: anObject [
	keywordModel := anObject
]
