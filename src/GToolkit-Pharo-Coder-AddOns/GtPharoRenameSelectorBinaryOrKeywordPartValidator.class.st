"
Validator for binary or single-keyword message rename selector parts.
"
Class {
	#name : #GtPharoRenameSelectorBinaryOrKeywordPartValidator,
	#superclass : #GtPharoRenameSelectorPartValidator,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #validating }
GtPharoRenameSelectorBinaryOrKeywordPartValidator >> validateSelectorPart: aString [
	aString isEmpty ifTrue: [ ^ false ].
	^ (self validateKeyword: aString)
		or: [ (self validateBinary: aString) or: [ self validateVariable: aString ] ]
]
