Class {
	#name : #GtPharoRenameSelectorSwapButtonAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#instVars : [
		'icon',
		'tooltip',
		'actionBlock',
		'id',
		'hoveredBlock',
		'unhoveredBlock'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #accessing }
GtPharoRenameSelectorSwapButtonAttribute >> action [
	^ actionBlock
]

{ #category : #accessing }
GtPharoRenameSelectorSwapButtonAttribute >> action: anObject [
	actionBlock := anObject
]

{ #category : #accessing }
GtPharoRenameSelectorSwapButtonAttribute >> doAffect: aTBrTextEditorTextualPiece in: anEditorElement [
	| button |
	button := BrButton new.
	button icon: icon.
	button label: tooltip.
	button
		aptitude: BrGlamorousButtonExteriorAptitude
				+ ((BrGlamorousButtonRectangularAptitude paddingScale: 2 / 3)
						+ BrGlamorousButtonIconAptitude
						+ BrGlamorousButtonWithLabelTooltipAptitude2).
	button beMiniSize.
	button
		margin: (BlInsets
				top: 1
				right: 4
				bottom: 0
				left: 4).
	button action: [ :anEvent | actionBlock cull: anEvent cull: anEditorElement ].
	button id: id.

	(hoveredBlock isNotNil and: [ unhoveredBlock isNotNil ])
		ifTrue: [ button
				addAptitude: (BrLazyStyleCommonAptitude new
						hovered: [ :aStyle | 
							aStyle
								do: [ :aWidget | 
									hoveredBlock cull: aWidget cull: anEditorElement ]
								after: [ :aWidget | 
									unhoveredBlock cull: aWidget cull: anEditorElement ] ]) ].

	^ button
]

{ #category : #printing }
GtPharoRenameSelectorSwapButtonAttribute >> gtDisplayOn: aStream [
	aStream
		nextPutAll: 'Swap button: ';
		nextPutAll: self tooltip asString
]

{ #category : #accessing }
GtPharoRenameSelectorSwapButtonAttribute >> hovered: aHoveredBlock after: anAfterBlock [
	hoveredBlock := aHoveredBlock.
	unhoveredBlock := anAfterBlock
]

{ #category : #accessing }
GtPharoRenameSelectorSwapButtonAttribute >> icon [
	^ icon
]

{ #category : #accessing }
GtPharoRenameSelectorSwapButtonAttribute >> icon: anObject [
	icon := anObject
]

{ #category : #accessing }
GtPharoRenameSelectorSwapButtonAttribute >> id [
	^ id
]

{ #category : #accessing }
GtPharoRenameSelectorSwapButtonAttribute >> id: anObject [
	id := anObject
]

{ #category : #initialization }
GtPharoRenameSelectorSwapButtonAttribute >> initialize [
	super initialize.

	self beAppend.
	self beNotOverwritableByStyler
]

{ #category : #accessing }
GtPharoRenameSelectorSwapButtonAttribute >> tooltip [
	^ tooltip
]

{ #category : #accessing }
GtPharoRenameSelectorSwapButtonAttribute >> tooltip: anObject [
	tooltip := anObject
]
