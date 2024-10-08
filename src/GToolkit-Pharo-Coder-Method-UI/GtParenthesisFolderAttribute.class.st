Class {
	#name : #GtParenthesisFolderAttribute,
	#superclass : #BrGlamorousTriangleExpanderTextAttribute,
	#instVars : [
		'attribute',
		'hideAttribute'
	],
	#category : #'GToolkit-Pharo-Coder-Method-UI-Stylers'
}

{ #category : #accessing }
GtParenthesisFolderAttribute class >> forAttribute: anAttribute [
	^self new attribute: anAttribute
]

{ #category : #accessing }
GtParenthesisFolderAttribute >> applyExpandedOrCollapsedAttributesOn: aTBrTextEditorTextualPiece in: aTextEditor [
	| text |
	text := aTextEditor text.
	text
		findAttribute: attribute
		indicesDo: [ :aParenthesesStart :aParenthesesEnd | 
			isExpanded
				ifTrue: [ text
						clearAttributes: aParenthesesStart
						to: aParenthesesEnd
						if: [ :att | att == hideAttribute ] ]
				ifFalse: [ text
						attribute: hideAttribute
						from: aParenthesesStart
						to: aParenthesesEnd ] ]
]

{ #category : #accessing }
GtParenthesisFolderAttribute >> attribute: anAttribute [
	attribute := anAttribute
]

{ #category : #'as yet unclassified' }
GtParenthesisFolderAttribute >> doAffect: aTBrTextEditorTextualPiece in: anEditorElement [
	| aToggle |
	aToggle := BrTriangle new
			id: self id;
			aptitude: BrGlamorousEllipsesExpanderAptitude ;
			expanded: self isExpanded;
			padding: (BlInsets all: 2);
			margin: (BlInsets top: 2);
			mouseCursor: BlCursor default;
			toggleAction: [ self
					toggleExpandedOrCollapsedAttributesOn: aTBrTextEditorTextualPiece
					in: anEditorElement editor ].

	self
		applyExpandedOrCollapsedAttributesOn: aTBrTextEditorTextualPiece
		in: anEditorElement editor.

	^ aToggle
]

{ #category : #accessing }
GtParenthesisFolderAttribute >> initialize [
	super initialize.
	self beNotOverwritableByStyler.
	isExpanded := true.
	hideAttribute := BrTextFoldAttribute new beNotOverwritableByStyler
]
