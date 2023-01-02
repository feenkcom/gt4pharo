Extension { #name : #TFPool }

{ #category : #'*GToolkit-Pharo-Extensions' }
TFPool >> returnOne: anObject [

	mutex critical: [ 
		| index |
		index := pointer - 1. 
		index > 0 ifFalse: [ 
			"This can happen if a new session starts in middle of a call."
			"'Returning an object but pool is full' crTrace."
			releaseBlock value:anObject. 
			^ self  ]. 
		elements at: index put: anObject.
		pointer := index ]
]
