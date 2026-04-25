"
Validator for multi-keyword message rename selector parts.
"
Class {
	#name : #GtPharoRenameSelectorKeywordPartValidator,
	#superclass : #GtPharoRenameSelectorPartValidator,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #validating }
GtPharoRenameSelectorKeywordPartValidator >> validateSelectorPart: aString [
	aString isEmpty ifTrue: [ ^ false ].
	^ (self validateKeyword: aString) or: [ self validateVariable: aString ]
]
