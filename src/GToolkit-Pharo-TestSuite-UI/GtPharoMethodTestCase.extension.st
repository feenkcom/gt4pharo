Extension { #name : #GtPharoMethodTestCase }

{ #category : #'*GToolkit-Pharo-TestSuite-UI' }
GtPharoMethodTestCase >> executeAsyncFrom: aBrButton [ 
	aBrButton withAsyncFutureDo: 
			[:anElementFuture |
			anElementFuture
				whenSuccess: [:currentButton | currentButton enable];
				whenError: 
						[:currentButton :anError |
						currentButton enable.
						(GtSystemUtility freeze: anError) debug];
				whenPending: [:currentButton | currentButton disable].
			aBrButton
				enqueueTask: (BlTaskAction new action: 
							[aBrButton asyncFuture
								future: 
									[self state: GtPharoMethodExecutingState.
									self play] asAsyncFuture])]
]
