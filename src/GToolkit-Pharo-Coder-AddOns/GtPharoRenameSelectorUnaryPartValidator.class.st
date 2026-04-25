"
Validator for variable or unary message rename selector parts.
"
Class {
	#name : #GtPharoRenameSelectorUnaryPartValidator,
	#superclass : #GtPharoRenameSelectorPartValidator,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #validating }
GtPharoRenameSelectorUnaryPartValidator >> validateSelectorPart: aString [
	aString isEmpty ifTrue: [ ^ false ].
	^ self validateVariable: aString
]
