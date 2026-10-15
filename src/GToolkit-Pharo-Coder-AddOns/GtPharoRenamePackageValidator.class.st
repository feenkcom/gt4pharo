"
I accept a non-empty name without leading and trailing spaces that is not the name of an existing package. A package name is not a variable name, e.g., it can include hyphens. See {{gtClass:GtPharoRenamePackageCoderController}}.
"
Class {
	#name : #GtPharoRenamePackageValidator,
	#superclass : #GtPharoRenameVariableValidator,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #accessing }
GtPharoRenamePackageValidator >> validateVariableName: aString [
	"A package name is not a variable name, it must only be non-empty and not used by an existing package."

	aString isEmpty ifTrue: [ ^ false ].
	aString trimBoth = aString ifFalse: [ ^ false ].
	^ (Smalltalk packageOrganizer includesPackageNamed: aString) not
]
