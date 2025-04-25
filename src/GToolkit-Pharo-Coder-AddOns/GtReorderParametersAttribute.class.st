Class {
	#name : #GtReorderParametersAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#instVars : [
		'actionBlock',
		'icon',
		'label'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Base'
}

{ #category : #'instance creation' }
GtReorderParametersAttribute class >> action: aBlock icon: anIcon [
	^ self new
		actionBlock: aBlock;
		icon: anIcon;
		yourself
]

{ #category : #'instance creation' }
GtReorderParametersAttribute class >> action: aBlock icon: anIcon label: aString [
	^ self new
		actionBlock: aBlock;
		icon: anIcon;
		label: aString;
		yourself
]

{ #category : #accessing }
GtReorderParametersAttribute >> actionBlock [
	^ actionBlock
]

{ #category : #accessing }
GtReorderParametersAttribute >> actionBlock: aBlock [
	actionBlock := aBlock
]

{ #category : #accessing }
GtReorderParametersAttribute >> doAffect: aTBrTextEditorTextualPiece in: anEditorElement [
	^ BrButton new
		icon: icon;
		label: self label;
		aptitude: BrGlamorousButtonExteriorAptitude
				+ ((BrGlamorousButtonRectangularAptitude paddingScale: 2 / 3)
						+ BrGlamorousButtonIconAptitude
						+ BrGlamorousButtonWithLabelTooltipAptitude2);
		beMiniSize;
		margin: (BlInsets
				top: 1
				right: 4
				bottom: 0
				left: 4);
		action: [ :anEvent | actionBlock cull: anEvent ];
		id: #'reorder-parameter-button';
		yourself
]

{ #category : #accessing }
GtReorderParametersAttribute >> icon [
	^ icon
]

{ #category : #accessing }
GtReorderParametersAttribute >> icon: anObject [
	icon := anObject
]

{ #category : #'initialize-release' }
GtReorderParametersAttribute >> initialize [
	super initialize.

	self beAppend.
	self beNotOverwritableByStyler
]

{ #category : #accessing }
GtReorderParametersAttribute >> label [
	^ label ifNil: [ 'Reorder' ]
]

{ #category : #accessing }
GtReorderParametersAttribute >> label: aString [
	label := aString
]
