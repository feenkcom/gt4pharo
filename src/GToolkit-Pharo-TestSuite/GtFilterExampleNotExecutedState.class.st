Class {
	#name : #GtFilterExampleNotExecutedState,
	#superclass : #GtExampleState,
	#category : 'GToolkit-Pharo-TestSuite-States'
}

{ #category : #'api - testing' }
GtFilterExampleNotExecutedState >> includesCoder: aCoder [
	^ aCoder exampleResult isNil
]

{ #category : #'api - testing' }
GtFilterExampleNotExecutedState >> includesExampleWithResult: aGtExampleWithResult [
	^ aGtExampleWithResult result isNil
]

{ #category : #'api - testing' }
GtFilterExampleNotExecutedState >> isStatusFor: aGtExampleWithResult [
	^ aGtExampleWithResult isNotNil and: [ 
			aGtExampleWithResult hasResult not ]
]

{ #category : #'api - accessing' }
GtFilterExampleNotExecutedState >> label [
	^ 'Not Executed'
]

{ #category : #'api - accessing' }
GtFilterExampleNotExecutedState >> numberOfExamplesFor: anExampler [
	^ anExampler numberOfNotExecutedExamples
]

{ #category : #'api - accessing' }
GtFilterExampleNotExecutedState >> order [
	^ 5
]
