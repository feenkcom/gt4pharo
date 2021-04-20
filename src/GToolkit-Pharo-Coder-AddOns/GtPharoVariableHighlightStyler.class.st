Class {
	#name : #GtPharoVariableHighlightStyler,
	#superclass : #GtGenericPharoStyler,
	#category : #'GToolkit-Pharo-Coder-AddOns-Variable'
}

{ #category : #accessing }
GtPharoVariableHighlightStyler >> visitNamedVariable: aNamedVariable [
	| occurrences |
	(text
		from: aNamedVariable name startPosition
		to: aNamedVariable name stopPosition)
		onCursorEnter: [ :aTextEditor :anEvent :aFromIndex :aToIndex | 
			occurrences := OrderedCollection new.
			(aNamedVariable whoDefines ifNil: [ aNamedVariable topParent ]) 
				allNodesOfType: aNamedVariable class do: [:node | 
					node = aNamedVariable ifTrue: [ occurrences add: node ] ].
			(occurrences size > 1) ifTrue: [
				 occurrences do: [ :node |
					(aTextEditor text
						from: node name startPosition
						to: node name stopPosition)
						attribute: (GtPharoVariableHighlightAttribute paint: BrGlamorousColors neutralBackgroundColor)]]]
		leave: [ :aTextEditor :anEvent :aFromIndex :aToIndex |
			aTextEditor text clearAttributesOfClass: GtPharoVariableHighlightAttribute ]
]
