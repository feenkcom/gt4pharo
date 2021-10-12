Class {
	#name : #GtExtractMethodReorderParametersAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#instVars : [
		'actionBlock',
		'icon'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Extract method'
}

{ #category : #'instance creation' }
GtExtractMethodReorderParametersAttribute class >> action: aBlock icon: anIcon [
	^ self new
		actionBlock: aBlock;
		icon: anIcon;
		yourself
]

{ #category : #accessing }
GtExtractMethodReorderParametersAttribute >> actionBlock [
	^ actionBlock
]

{ #category : #accessing }
GtExtractMethodReorderParametersAttribute >> actionBlock: aBlock [
	actionBlock := aBlock
]

{ #category : #accessing }
GtExtractMethodReorderParametersAttribute >> doAffect: aTBrTextEditorTextualPiece in: anEditorElement [
	^ (BrButton new)
		icon: icon;
		label: 'Reorder';
		aptitude: BrGlamorousButtonExteriorAptitude +  ((BrGlamorousButtonRectangularAptitude paddingScale: 2/3) + BrGlamorousButtonIconAptitude + BrGlamorousButtonWithLabelTooltipAptitude);
		beTinySize;
		margin: (BlInsets top: 1 right: 4 bottom: 0 left: 4);
		action: [ :anEvent | actionBlock cull: anEvent ];
		id: #'reorder-parameter-button';
		yourself
]

{ #category : #accessing }
GtExtractMethodReorderParametersAttribute >> icon [
	^ icon
]

{ #category : #accessing }
GtExtractMethodReorderParametersAttribute >> icon: anObject [
	icon := anObject
]

{ #category : #'initialize-release' }
GtExtractMethodReorderParametersAttribute >> initialize [
	super initialize.

	self beAppend.
	self beNotOverwritableByStyler
]
