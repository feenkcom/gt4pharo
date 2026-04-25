"
Abstract validator for rename selector part scenarios. Subclasses correspond to concrete message-shape strategies.
"
Class {
	#name : #GtPharoRenameSelectorPartValidator,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #private }
GtPharoRenameSelectorPartValidator >> validateBinary: aString [
	aString isEmpty ifTrue: [ ^ false ].
	^ (RBScanner isSelector: aString) and: [ aString asSymbol isBinary ]
]

{ #category : #private }
GtPharoRenameSelectorPartValidator >> validateKeyword: aString [
	aString isEmpty
		ifTrue: [ ^ false ].
	aString last = $:
		ifFalse: [ ^ false ].
	^ (RBScanner isSelector: aString)
		and: [ aString asSymbol numArgs = 1 ]
]

{ #category : #validating }
GtPharoRenameSelectorPartValidator >> validateSelectorPart: aString [
	self subclassResponsibility
]

{ #category : #private }
GtPharoRenameSelectorPartValidator >> validateVariable: aString [
	^ RBScanner isVariable: aString
]
