Class {
	#name : 'GtPharoDynamicHighlightStyler',
	#superclass : 'GtGenericPharoStyler',
	#category : 'GToolkit-Pharo-Coder-AddOns-DynamicHighlight'
}

{ #category : 'accessing' }
GtPharoDynamicHighlightStyler >> visitKeywordMessage: aKeywordMessage [
	super visitKeywordMessage: aKeywordMessage.
	aKeywordMessage selectorParts size > 1 ifFalse: [^ self].
	aKeywordMessage selectorParts do: [:eachPart |
		(text 
			from: eachPart startPosition
			to: eachPart stopPosition)
			onCursorEnter: [ :aTextEditor :anEvent :aFromIndex :aToIndex | 
				aKeywordMessage selectorParts do: [ :node |
						(aTextEditor text
							from: node startPosition
							to: node stopPosition)
							attribute: (GtPharoDynamicHighlightAttribute paint: BrGlamorousColors neutralBackgroundColor)]]
			leave: [ :aTextEditor :anEvent :aFromIndex :aToIndex |
				aTextEditor text clearAttributesOfClass: GtPharoDynamicHighlightAttribute ] ]
]

{ #category : 'accessing' }
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
