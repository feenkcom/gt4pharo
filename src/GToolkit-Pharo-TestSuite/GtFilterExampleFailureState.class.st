Class {
	#name : #GtFilterExampleFailureState,
	#superclass : #GtExampleState,
	#category : #'GToolkit-Pharo-TestSuite-States'
}

{ #category : #'api - testing' }
GtFilterExampleFailureState >> includesCoder: aCoder [
	^ aCoder canExecuteExample and: [ 
		aCoder exampleResult isNotNil and: [ 
			aCoder exampleResult isFailure ] ]
]

{ #category : #'api - testing' }
GtFilterExampleFailureState >> includesExampleWithResult: aGtExampleWithResult [
	^ aGtExampleWithResult result isNotNil and: [ 
		aGtExampleWithResult result isFailure ]
]

{ #category : #'api - testing' }
GtFilterExampleFailureState >> isStatusFor: aGtExampleWithResult [
	^ aGtExampleWithResult isNotNil and: [ 
			aGtExampleWithResult hasResult and: [ 
				aGtExampleWithResult isFailure ] ]
]

{ #category : #'api - accessing' }
GtFilterExampleFailureState >> label [
	^ 'Failure'
]

{ #category : #'api - accessing' }
GtFilterExampleFailureState >> numberOfExamplesFor: anExampler [
	^ anExampler numberOfFailureExamples
]

{ #category : #'api - accessing' }
GtFilterExampleFailureState >> order [
	^ 3
]
