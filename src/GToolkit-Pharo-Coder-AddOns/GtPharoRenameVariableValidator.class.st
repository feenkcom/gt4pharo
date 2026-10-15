Class {
	#name : #GtPharoRenameVariableValidator,
	#superclass : #Object,
	#instVars : [
		'forbiddenNames'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #accessing }
GtPharoRenameVariableValidator >> forbiddenNames [
	"Names that are valid variable names but must not be chosen, e.g., names of existing variables."

	^ forbiddenNames
]

{ #category : #accessing }
GtPharoRenameVariableValidator >> forbiddenNames: aCollectionOfStrings [
	forbiddenNames := aCollectionOfStrings
]

{ #category : #initialization }
GtPharoRenameVariableValidator >> initialize [
	super initialize.
	forbiddenNames := #()
]

{ #category : #validation }
GtPharoRenameVariableValidator >> validateVariableName: aString [
	aString isEmpty ifTrue: [ ^ false ].
	(RBScanner isVariable: aString) ifFalse: [ ^ false ].
	^ (forbiddenNames includes: aString) not
]
