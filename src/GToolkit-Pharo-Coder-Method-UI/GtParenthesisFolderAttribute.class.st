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

{ #category : #accessing }
GtParenthesisFolderAttribute >> initialize [
	super initialize.
	self beNotOverwritableByStyler.
	isExpanded := true.
	hideAttribute := BrTextHideAttribute new beNotOverwritableByStyler
]
