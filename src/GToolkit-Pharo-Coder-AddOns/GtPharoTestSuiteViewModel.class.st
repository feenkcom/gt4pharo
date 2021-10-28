Class {
	#name : #GtPharoTestSuiteViewModel,
	#superclass : #Object,
	#traits : 'TGtPharoSuiteViewModel',
	#classTraits : 'TGtPharoSuiteViewModel classTrait',
	#instVars : [
		'coder'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Test Case'
}

{ #category : #'api - suite' }
GtPharoTestSuiteViewModel >> allStates [

	^ { 
		  GtPharoMethodAllState.
		  GtPharoMethodTestCasePassedState.
		  GtPharoMethodTestCaseSkippedState.
		  GtPharoMethodTestCaseFailureState.
		  GtPharoMethodTestCaseErrorState.
		  GtPharoMethodNotExecutedState }
]

{ #category : #accessing }
GtPharoTestSuiteViewModel >> coder [

	^ coder
]

{ #category : #accessing }
GtPharoTestSuiteViewModel >> coder: aCoder [

	coder := aCoder
]

{ #category : #'private - accessing' }
GtPharoTestSuiteViewModel >> coderDo: aBlock [

	self coder ifNotNil: aBlock
]

{ #category : #'api - suite' }
GtPharoTestSuiteViewModel >> play [
	self flag: #todo
]

{ #category : #'api - suite' }
GtPharoTestSuiteViewModel >> totalStringForState: aState [

	| aTotal |
	self coderDo: [ :aCoder | 
		aTotal := aState numberOfMethodsIn: aCoder.
		^ aTotal asString , (' test' asPluralBasedOn: aTotal) ].
	^ '?'
]

{ #category : #'api - suite' }
GtPharoTestSuiteViewModel >> updateCoderFilterWith: aState source: aSource [

	self coderDo: [ :aMethodsCoder | 
		aMethodsCoder
			setFilters: { (GtPharoTestCaseStateFilter new
					 resultState: aState;
					 coder: aMethodsCoder) }
			source: aSource ]
]
