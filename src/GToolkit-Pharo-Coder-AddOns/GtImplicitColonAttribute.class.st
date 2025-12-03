Class {
	#name : #GtImplicitColonAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#category : 'GToolkit-Pharo-Coder-AddOns-Extract method'
}

{ #category : #comparing }
GtImplicitColonAttribute >> = anObject [
	^ self class = anObject class
]

{ #category : #accessing }
GtImplicitColonAttribute >> doAffect: aTBrTextEditorTextualPiece in: anEditorElement [
	^ BrVerticalPane new
		fitContent;
		addChild: (BlTextElement new
				text: (':' asRopedText foreground: BrGlamorousColors disabledButtonTextColor);
				yourself);
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
