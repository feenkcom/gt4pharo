Extension { #name : #PositionableStream }

{ #category : #'*GToolkit-Pharo-Extensions' }
PositionableStream >> on: aCollection [
	"We override this method to explicitly add a precondition checking that the parameter is not nil."
	
	<gtPharoPatch: #Pharo>
	aCollection ifNil: [ 
		^ Error signal: 'Streams cannot be initialized with a nil collection' ].
		
	collection := aCollection.
	readLimit := aCollection size.
	position := 0.
	self reset
]
