Class {
	#name : #GtImplicitColonAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#category : #'GToolkit-Pharo-Coder-AddOns-Extract method'
}

{ #category : #comparing }
GtImplicitColonAttribute >> = anObject [
	^ self class = anObject class
]

{ #category : #accessing }
GtImplicitColonAttribute >> doAffect: aTBrTextEditorTextualPiece in: anEditorElement [
	^ BlTextElement new
		text: (':' asRopedText foreground: BrGlamorousColors disabledButtonTextColor);
		yourself
]

{ #category : #comparing }
GtImplicitColonAttribute >> hash [
	^ self class hash
]

{ #category : #initialization }
GtImplicitColonAttribute >> initialize [
	super initialize.
	self beAppend
]
