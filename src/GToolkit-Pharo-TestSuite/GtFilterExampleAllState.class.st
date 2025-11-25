Class {
	#name : #GtFilterExampleAllState,
	#superclass : #GtExampleState,
	#category : 'GToolkit-Pharo-TestSuite-States'
}

{ #category : #'api - testing' }
GtFilterExampleAllState >> includesCoder: aCoder [
	^ aCoder example isNotNil
]

{ #category : #'api - testing' }
GtFilterExampleAllState >> includesExampleWithResult: aGtExampleWithResult [
	^ true
]

{ #category : #'api - testing' }
GtFilterExampleAllState >> isStatusFor: aGtExampleWithResult [
	^ false
]

{ #category : #'api - accessing' }
GtFilterExampleAllState >> label [
	^ 'All examples'
]

{ #category : #'api - accessing' }
GtFilterExampleAllState >> numberOfExamplesFor: anExampler [
	^ anExampler numberOfAllExamples
]

{ #category : #'api - accessing' }
GtFilterExampleAllState >> order [
	^ 1
]
