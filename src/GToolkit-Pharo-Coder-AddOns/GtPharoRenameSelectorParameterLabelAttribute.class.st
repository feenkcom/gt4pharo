Class {
	#name : #GtPharoRenameSelectorParameterLabelAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#instVars : [
		'parameterModel'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #accessing }
GtPharoRenameSelectorParameterLabelAttribute >> doAffect: aTBrTextEditorTextualPiece in: anEditorElement [
	| aLabel |
	aLabel := BrLabel new
			fitContent;
			aptitude: BrGlamorousLabelAptitude new;
			padding: (BlInsets left: 2 right: 2);
			margin: (BlInsets
					top: 0
					left: -2
					bottom: 0
					right: -2);
			text: parameterModel currentName.

	GtPharoRenameSelectorParameterLabelAnnouncementHandler new
		label: aLabel;
		parameterModel: parameterModel;
		install.

	^ aLabel
]

{ #category : #initialization }
GtPharoRenameSelectorParameterLabelAttribute >> initialize [
	super initialize.

	self beReplace.
	self beNotOverwritableByStyler
]

{ #category : #accessing }
GtPharoRenameSelectorParameterLabelAttribute >> parameterModel [
	^ parameterModel
]

{ #category : #accessing }
GtPharoRenameSelectorParameterLabelAttribute >> parameterModel: anObject [
	parameterModel := anObject
]
