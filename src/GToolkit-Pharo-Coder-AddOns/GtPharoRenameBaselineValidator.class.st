"
I accept a variable-like name for which the class `BaselineOf<name>` does not exist yet. See {{gtClass:GtPharoRenameBaselineCoderController}}.
"
Class {
	#name : #GtPharoRenameBaselineValidator,
	#superclass : #GtPharoRenameVariableValidator,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #accessing }
GtPharoRenameBaselineValidator >> validateVariableName: aString [
	"The baseline class `BaselineOf<name>` must not exist yet."

	(super validateVariableName: aString) ifFalse: [ ^ false ].
	^ (Smalltalk globals includesKey: ('BaselineOf' , aString) asSymbol) not
]
