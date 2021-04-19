Class {
	#name : #GtPharoHaltStyler,
	#superclass : #GtGenericPharoStyler,
	#category : #'GToolkit-Pharo-Coder-AddOns-Halt'
}

{ #category : #accessing }
GtPharoHaltStyler >> visitMessage: aMessageNode [
	super visitMessage: aMessageNode.
	aMessageNode selector = #halt ifTrue: [ 
		self
			attribute: (BlTextHighlightAttribute paint: BrGlamorousColors paleErrorBackgroundColor)
			from: aMessageNode startPosition
			to: aMessageNode stopPosition ].
]
