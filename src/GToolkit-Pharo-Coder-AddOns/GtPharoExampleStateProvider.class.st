Class {
	#name : #GtPharoExampleStateProvider,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-AddOns-Test Case'
}

{ #category : #'api - accessing' }
GtPharoExampleStateProvider >> allStates [

	^ GtFilterExampleState default allStates
]

{ #category : #'api - accessing' }
GtPharoExampleStateProvider >> totalDescriptionForState: aState in: aMethodsCoder [

	| aTotal aTotalString |
	aTotal := aState numberOfExamplesFor: aMethodsCoder.
	aTotalString := aTotal asString , (' example' asPluralBasedOn: aTotal).
	^ aTotalString
]

{ #category : #'api - updating' }
GtPharoExampleStateProvider >> updateCoder: aMethodsCoder filterWith: aSelectedState source: aSource [
	aMethodsCoder
		setFilters: { (GtSearchExamplesFilter new
				 resultState: aSelectedState;
				 coder: aMethodsCoder) }
		source: aSource
]
