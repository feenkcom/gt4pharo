Class {
	#name : #GtPharoTestCaseStateProvider,
	#superclass : #Object,
	#category : 'GToolkit-Pharo-TestSuite-Base'
}

{ #category : #'api - accessing' }
GtPharoTestCaseStateProvider >> allStates [

	^ { 
		  GtPharoMethodTestCaseAllState.
		  GtPharoMethodTestCasePassedState.
		  GtPharoMethodTestCaseSkippedState.
		  GtPharoMethodTestCaseFailureState.
		  GtPharoMethodTestCaseErrorState.
		  GtPharoMethodNotExecutedState. }
]

{ #category : #'api - accessing' }
GtPharoTestCaseStateProvider >> totalDescriptionForState: aState in: aMethodsCoder [

	| aTotal aTotalString |
	aTotal := aState numberOfMethodsIn: aMethodsCoder.
	aTotalString := aTotal asString , (' test' asPluralBasedOn: aTotal).
	^ aTotalString
]

{ #category : #'api - updating' }
GtPharoTestCaseStateProvider >> updateCoder: aMethodsCoder filterWith: aSelectedState source: aSource [
	aMethodsCoder
		setFilters: { (GtPharoTestCaseStateFilter new
				 resultState: aSelectedState;
				 coder: aMethodsCoder) }
		source: aSource
]
