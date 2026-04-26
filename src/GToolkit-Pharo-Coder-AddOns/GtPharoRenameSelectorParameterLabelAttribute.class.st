Class {
	#name : #GtPharoRenameSelectorParameterLabelAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#instVars : [
		'parameterModel'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #private }
GtPharoRenameSelectorParameterLabelAttribute >> doAffect: aTBrTextEditorTextualPiece in: anEditorElement [
	^ GtPharoRenameSelectorParameterElement new
		parameterModel: parameterModel;
		margin: (BlInsets
				top: 0
				left: -2
				bottom: 0
				right: -2)
]

{ #category : #printing }
GtPharoRenameSelectorParameterLabelAttribute >> gtDisplayOn: aStream [
	aStream
		nextPutAll: 'Parameter: ';
		nextPutAll: (self parameterModel ifNotNil: #currentName) asString
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
