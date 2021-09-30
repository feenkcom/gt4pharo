Class {
	#name : #GtPharoHaltStyler,
	#superclass : #GtGenericPharoStyler,
	#category : 'GToolkit-Pharo-Coder-AddOns-Halt'
}

{ #category : #accessing }
GtPharoHaltStyler >> visitMessage: aMessageNode [
	super visitMessage: aMessageNode.
	(aMessageNode selector = #halt or: [aMessageNode selector = #haltOnce]) ifTrue: [ 
		self
			attribute: (BlTextHighlightAttribute paint: BrGlamorousColors paleErrorBackgroundColor)
			from: aMessageNode startPosition
			to: aMessageNode stopPosition ].
]

{ #category : #accessing }
GtPharoHaltStyler >> visitMessageSend: aMessageNode [
	| receiver |
	super visitMessageSend: aMessageNode.
	((aMessageNode selector = #once or: [aMessageNode selector = #now]) and: [
		aMessageNode receiver isVariable and: [
			aMessageNode receiver variableName = #Halt]]) ifTrue: [ 
		self
			attribute: (BlTextHighlightAttribute paint: BrGlamorousColors paleErrorBackgroundColor)
			from: aMessageNode startPosition
			to: aMessageNode stopPosition ].
]
