Class {
	#name : #GtFilterExampleErrorState,
	#superclass : #GtExampleState,
	#category : 'GToolkit-Pharo-TestSuite-States'
}

{ #category : #'api - testing' }
GtFilterExampleErrorState >> includesCoder: aCoder [
	^ aCoder canExecuteExample and: [ 
		aCoder exampleResult isNotNil and: [ 
			aCoder exampleResult isError ] ]
]

{ #category : #'api - testing' }
GtFilterExampleErrorState >> includesExampleWithResult: aGtExampleWithResult [
	^ aGtExampleWithResult result isNotNil and: [ aGtExampleWithResult result isError ]
]

{ #category : #'api - testing' }
GtFilterExampleErrorState >> isStatusFor: aGtExampleWithResult [
	^ aGtExampleWithResult isNotNil and: [ 
			aGtExampleWithResult hasResult and: [ 
				aGtExampleWithResult isError ] ]
]

{ #category : #'api - accessing' }
GtFilterExampleErrorState >> label [
	^ 'Error'
]

{ #category : #'api - accessing' }
GtFilterExampleErrorState >> numberOfExamplesFor: anExampler [
	^ anExampler numberOfErrorExamples
]

{ #category : #'api - accessing' }
GtFilterExampleErrorState >> order [
	^ 4
]
