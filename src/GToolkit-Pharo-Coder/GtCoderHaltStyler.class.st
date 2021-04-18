Class {
	#name : #GtCoderHaltStyler,
	#superclass : #GtGenericPharoStyler,
	#category : #'GToolkit-Pharo-Coder-Coders'
}

{ #category : #accessing }
GtCoderHaltStyler >> visitMessage: aMessageNode [
	super visitMessage: aMessageNode.
	aMessageNode selector = #halt ifTrue: [ 
		self
			attribute: (BlTextHighlightAttribute paint: BrGlamorousColors errorBackgroundColor)
			from: aMessageNode startPosition
			to: aMessageNode stopPosition ].
]
