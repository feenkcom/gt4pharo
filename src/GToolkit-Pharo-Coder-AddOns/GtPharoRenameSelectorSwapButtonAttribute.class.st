Class {
	#name : #GtPharoRenameSelectorSwapButtonAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#instVars : [
		'icon',
		'tooltip',
		'actionBlock',
		'id',
		'hoveredBlock',
		'unhoveredBlock',
		'selectorModel'
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
	button := GtPharoRenameSelectorSwapButtonElement new.
	button icon: icon.
	button tooltip: tooltip.
	button beMiniSize.
	button
		margin: (BlInsets
				top: 1
				right: 4
				bottom: 0
				left: 4).
	button
		action: [ :aButton | 
			actionBlock
				cull: aButton
				cull: selectorModel
				cull: anEditorElement ].
	button id: id.

	button
		hovered: (hoveredBlock
				ifNotNil: [ :aBlock | 
					[ :aButton :aSelectorModel | 
					aBlock
						cull: aButton
						cull: aSelectorModel
						cull: anEditorElement ] ])
		after: (unhoveredBlock
				ifNotNil: [ :aBlock | 
					[ :aButton :aSelectorModel | 
					aBlock
						cull: aButton
						cull: aSelectorModel
						cull: anEditorElement ] ]).

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
GtPharoRenameSelectorSwapButtonAttribute >> selectorModel [
	^ selectorModel
]

{ #category : #accessing }
GtPharoRenameSelectorSwapButtonAttribute >> selectorModel: anObject [
	selectorModel := anObject
]

{ #category : #accessing }
GtPharoRenameSelectorSwapButtonAttribute >> tooltip [
	^ tooltip
]

{ #category : #accessing }
GtPharoRenameSelectorSwapButtonAttribute >> tooltip: anObject [
	tooltip := anObject
]
