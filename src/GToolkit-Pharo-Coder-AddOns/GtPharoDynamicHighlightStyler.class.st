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
	| aVariableMarker aVariableHighlightAttribute theVariableOccurences |
	super visitNamedVariable: aNamedVariable.

	aVariableMarker := BrTextInvisibleMarkerAttribute new.
	aVariableHighlightAttribute := (GtPharoDynamicHighlightAttribute paint: BrGlamorousColors neutralBackgroundColor).

	theVariableOccurences := OrderedCollection new.
	
	(aNamedVariable whoDefines ifNil: [ aNamedVariable topParent ]) 
		allNodesOfType: aNamedVariable class
		do: [ :node |
			node = aNamedVariable
				ifTrue: [ theVariableOccurences add: node ] ].

	theVariableOccurences do: [ :eachVariableNode |
		text
			attribute: aVariableMarker
			from: eachVariableNode startPosition
			to: eachVariableNode stopPosition ].
		
	theVariableOccurences size <= 1
		ifTrue: [ ^ self ].

	(text
		from: aNamedVariable name startPosition
		to: aNamedVariable name stopPosition)
			attribute: aVariableMarker;
			onCursorEnter: [ :aTextEditor :anEvent | 
				aTextEditor text
					findAttribute: aVariableMarker
					indicesDo: [ :aVariableStart :aVariableEnd |
						aTextEditor text
							attribute: aVariableHighlightAttribute
							from: aVariableStart
							to: aVariableEnd ] ]
			leave: [ :aTextEditor :anEvent |
				aTextEditor text removeAttribute: aVariableHighlightAttribute ]
]
