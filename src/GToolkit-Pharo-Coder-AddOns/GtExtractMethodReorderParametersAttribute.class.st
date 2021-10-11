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
		aptitude: (BrGlamorousButtonRectangularAptitude paddingScale: 0) + BrGlamorousButtonIconAptitude;
		action: [ :anEvent | actionBlock cull: anEvent ];
		icon: icon;
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
