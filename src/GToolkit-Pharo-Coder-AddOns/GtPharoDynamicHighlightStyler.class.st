Class {
	#name : #GtPharoDynamicHighlightStyler,
	#superclass : #GtGenericPharoStyler,
	#category : #'GToolkit-Pharo-Coder-AddOns-DynamicHighlight'
}

{ #category : #accessing }
GtPharoDynamicHighlightStyler >> visitKeywordMessage: aKeywordMessage [
	| theMarkers |
	super visitKeywordMessage: aKeywordMessage.
	
	aKeywordMessage selectorParts size <= 1
		ifTrue: [ ^ self].
	
	theMarkers := OrderedCollection new.
	aKeywordMessage selectorParts do: [ :eachPart |
		| eachMarker |
		
		eachMarker := BrTextInvisibleMarkerAttribute new.
		theMarkers add: eachMarker. 
		
		(text 
			from: eachPart startPosition
			to: eachPart stopPosition)
				attribute: eachMarker;
				onCursorEnter: [ :aTextEditor :anEvent :aFromIndex :aToIndex | 
					aTextEditor text
						findAttributes: theMarkers
						indicesDo: [ :aHighlightStart :aHighlightEnd |
							(aTextEditor text
								from: aHighlightStart
								to: aHighlightEnd)
									attribute: (GtPharoDynamicHighlightAttribute paint: BrGlamorousColors neutralBackgroundColor) ] ]
				leave: [ :aTextEditor :anEvent :aFromIndex :aToIndex |
					aTextEditor text
						findAttributes: theMarkers
						indicesDo: [ :aHighlightStart :aHighlightEnd |
							(aTextEditor text
								from: aHighlightStart
								to: aHighlightEnd)
									clearAttributesOfClass: GtPharoDynamicHighlightAttribute ] ] ]
]

{ #category : #accessing }
GtPharoDynamicHighlightStyler >> visitNamedVariable: aNamedVariable [
	| occurrences |
	super visitNamedVariable: aNamedVariable.
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
						attribute: (GtPharoDynamicHighlightAttribute paint: BrGlamorousColors neutralBackgroundColor)]]]
		leave: [ :aTextEditor :anEvent :aFromIndex :aToIndex |
			aTextEditor text clearAttributesOfClass: GtPharoDynamicHighlightAttribute ]
]
