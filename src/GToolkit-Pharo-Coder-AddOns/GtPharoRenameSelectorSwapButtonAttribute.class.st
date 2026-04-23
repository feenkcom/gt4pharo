Class {
	#name : #GtPharoRenameSelectorSwapButtonAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#instVars : [
		'icon',
		'tooltip',
		'actionBlock',
		'id'
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

	^ button
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
