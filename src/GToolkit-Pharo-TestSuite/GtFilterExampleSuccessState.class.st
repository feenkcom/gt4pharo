Class {
	#name : #GtFilterExampleSuccessState,
	#superclass : #GtExampleState,
	#category : 'GToolkit-Pharo-TestSuite-States'
}

{ #category : #'api - testing' }
GtFilterExampleSuccessState >> includesCoder: aCoder [
	^ aCoder canExecuteExample and: [ 
		aCoder exampleResult isNotNil and: [ 
			aCoder exampleResult isSuccess ] ]
]

{ #category : #'api - testing' }
GtFilterExampleSuccessState >> includesExampleWithResult: aGtExampleWithResult [
	^ aGtExampleWithResult result isNotNil and: [ 
		aGtExampleWithResult result isSuccess ]
]

{ #category : #'api - testing' }
GtFilterExampleSuccessState >> isStatusFor: aGtExampleWithResult [
	^ aGtExampleWithResult isNotNil and: [ 
			aGtExampleWithResult hasResult and: [ 
				aGtExampleWithResult isSuccess ] ]
]

{ #category : #'api - accessing' }
GtFilterExampleSuccessState >> label [
	^ 'Success'
]

{ #category : #'api - accessing' }
GtFilterExampleSuccessState >> numberOfExamplesFor: anExampler [
	^ anExampler numberOfSuccessExamples
]

{ #category : #'api - accessing' }
GtFilterExampleSuccessState >> order [
	^ 2
]
