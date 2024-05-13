Extension { #name : #PositionableStream }

{ #category : #'*GToolkit-Pharo-Extensions' }
PositionableStream >> on: aCollection [
	aCollection ifNil: [ 
		^ Error signal: 'Streams cannot be initialized with a nil collection' ].
		
	collection := aCollection.
	readLimit := aCollection size.
	position := 0.
	self reset
]
