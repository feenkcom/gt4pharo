Class {
	#name : #GtTextFolderAttribute,
	#superclass : #BrTextExpandButtonAttribute,
	#instVars : [
		'attribute',
		'hideAttribute',
		'hoverText'
	],
	#category : #'GToolkit-Pharo-Coder-Method-UI-Stylers'
}

{ #category : #accessing }
GtTextFolderAttribute class >> forAttribute: anAttribute [
	^self new attribute: anAttribute
]

{ #category : #accessing }
GtTextFolderAttribute >> applyExpandedOrCollapsedAttributesOnText: text [
	text
		findAttribute: attribute
		indicesDo: [ :start :end | 
			isExpanded
				ifTrue: [ text
						clearAttributes: start
						to: end
						if: [ :att | att == hideAttribute ] ]
				ifFalse: [ text
						attribute: hideAttribute
						from: start
						to: end ] ]
]

{ #category : #accessing }
GtTextFolderAttribute >> attribute [
	^ attribute
]

{ #category : #accessing }
GtTextFolderAttribute >> attribute: anAttribute [
	attribute := anAttribute
]

{ #category : #'as yet unclassified' }
GtTextFolderAttribute >> clearHighlightOn: aTBrTextEditorTextualPiece in: aTextEditor [
	| text |
	text := aTextEditor text.
	text
		findAttribute: attribute
		indicesDo: [ :start :end | 
			text
				clearAttributes: start
				to: end
				if: [ :att | att class == GtPharoDynamicHighlightAttribute ] ]
]

{ #category : #'as yet unclassified' }
GtTextFolderAttribute >> doAffect: aTBrTextEditorTextualPiece in: anEditorElement [
	| aToggle |
	aToggle := BrInlineExpanderElement new
			id: self id;
			aptitude: (BrLabelExpanderAptitude new text: hoverText);
			expanded: self isExpanded;
			padding: (BlInsets all: 2);
			margin: (BlInsets top: 2);
			mouseCursor: BlCursor default;
			toggleAction: [ self isExpanded: isExpanded not.
				self applyExpandedOrCollapsedAttributesOnText: anEditorElement editor text ].
	hoverText
		ifNotNil: [ aToggle
				addAptitude: (BrGlamorousWithTooltipAptitude content: self hoverTextStencil) ].
	aToggle
		when: BlMouseEnterEvent
		do: [ :evt | 
			self
				highlightFoldableTextOn: aTBrTextEditorTextualPiece
				in: anEditorElement editor ].
	aToggle
		when: BlMouseLeaveEvent
		do: [ :evt | self clearHighlightOn: aTBrTextEditorTextualPiece in: anEditorElement editor ].

	self applyExpandedOrCollapsedAttributesOnText: anEditorElement editor text.

	^ aToggle
]

{ #category : #accessing }
GtTextFolderAttribute >> highlightFoldableTextOn: aTBrTextEditorTextualPiece in: aTextEditor [
	| text hilight |
	text := aTextEditor text.
	hilight := GtPharoDynamicHighlightAttribute
			paint: BrGlamorousColors neutralBackgroundColor.
	text
		findAttribute: attribute
		indicesDo: [ :start :end | 
			text
				attribute: hilight
				from: start
				to: end ]
]

{ #category : #'as yet unclassified' }
GtTextFolderAttribute >> hoverText: aString [
	hoverText := aString 
]

{ #category : #'as yet unclassified' }
GtTextFolderAttribute >> hoverTextStencil [
	^ [ BrLabel new
		aptitude: BrGlamorousLabelAptitude new glamorousRegularFontAndSize;
		text: hoverText;
		alignCenter ] asStencil
]

{ #category : #accessing }
GtTextFolderAttribute >> initialize [
	super initialize.
	isExpanded := true.
	hideAttribute := BrTextFoldAttribute new
]
