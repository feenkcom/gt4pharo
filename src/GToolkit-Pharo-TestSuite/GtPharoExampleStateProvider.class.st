Class {
	#name : #GtPharoExampleStateProvider,
	#superclass : #Object,
	#category : 'GToolkit-Pharo-TestSuite-Base'
}

{ #category : #'api - accessing' }
GtPharoExampleStateProvider >> allStates [
	^ GtExampleState default allStates
]

{ #category : #'api - accessing' }
GtPharoExampleStateProvider >> totalDescriptionForState: aState in: aMethodsCoder [

	| aTotal aTotalString |
	aTotal := aState numberOfExamplesFor: aMethodsCoder exampler.
	aTotalString := aTotal asString , (' example' asPluralBasedOn: aTotal).
	^ aTotalString
]

{ #category : #'api - updating' }
GtPharoExampleStateProvider >> updateCoder: aMethodsCoder filterWith: aSelectedState source: aSource [
	aMethodsCoder
		setFilters: { (GtPharoExampleStateFilter new
				 resultState: aSelectedState;
				 coder: aMethodsCoder) }
		source: aSource
]
