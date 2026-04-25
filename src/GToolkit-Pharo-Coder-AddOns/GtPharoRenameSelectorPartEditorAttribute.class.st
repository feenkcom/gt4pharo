Class {
	#name : #GtPharoRenameSelectorPartEditorAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#instVars : [
		'selectorModel',
		'selectorPartModel',
		'shouldStartWithFocus'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #accessing }
GtPharoRenameSelectorPartEditorAttribute >> doAffect: aTBrTextEditorTextualPiece in: anEditorElement [
	"GtRenameSelectorEditorAttribute"

	| renameEditor |
	renameEditor := GtPharoRenameSelectorPartElement new
			selectorModel: selectorModel selectorPartModel: selectorPartModel;
			fitContent;
			margin: (BlInsets
					top: 0
					left: -2
					bottom: 0
					right: -2).

	shouldStartWithFocus ifTrue: [ renameEditor requestFocus ].

	^ renameEditor
]

{ #category : #printing }
GtPharoRenameSelectorPartEditorAttribute >> gtDisplayOn: aStream [
	aStream
		nextPutAll: 'Selector part: ';
		nextPutAll: (self selectorPartModel ifNotNil: #currentName) asString
]

{ #category : #initialization }
GtPharoRenameSelectorPartEditorAttribute >> initialize [
	super initialize.

	self beReplace.
	self beNotOverwritableByStyler.
	
	shouldStartWithFocus := false.
]

{ #category : #accessing }
GtPharoRenameSelectorPartEditorAttribute >> selectorModel [
	^ selectorModel
]

{ #category : #accessing }
GtPharoRenameSelectorPartEditorAttribute >> selectorModel: anObject [
	selectorModel := anObject
]

{ #category : #accessing }
GtPharoRenameSelectorPartEditorAttribute >> selectorPartModel [
	^ selectorPartModel
]

{ #category : #accessing }
GtPharoRenameSelectorPartEditorAttribute >> selectorPartModel: anObject [
	selectorPartModel := anObject
]

{ #category : #accessing }
GtPharoRenameSelectorPartEditorAttribute >> shouldStartWithFocus [
	^ shouldStartWithFocus
]

{ #category : #accessing }
GtPharoRenameSelectorPartEditorAttribute >> shouldStartWithFocus: anObject [
	shouldStartWithFocus := anObject
]
