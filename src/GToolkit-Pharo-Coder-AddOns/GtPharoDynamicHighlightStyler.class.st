Class {
	#name : #GtPharoDynamicHighlightStyler,
	#superclass : #GtGenericPharoStyler,
	#instVars : [
		'variableMap'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-DynamicHighlight'
}

{ #category : #comparing }
GtPharoDynamicHighlightStyler >> = anObject [
	^ self class == anObject class
]

{ #category : #'api - styling' }
GtPharoDynamicHighlightStyler >> extraStyle: aText ast: theAst [

	super extraStyle: aText ast: theAst.

	variableMap
		do: [ :defs | 
			defs
				do: [ :nodes | 
					| aVariableMarker aVariableHighlightAttribute |
					aVariableMarker := BrTextInvisibleMarkerAttribute new.
					aVariableHighlightAttribute := GtPharoDynamicHighlightAttribute
							paint: BrGlamorousColors neutralBackgroundColor.
					nodes
						do: [ :each | 
							(aText from: each startPosition to: each stopPosition)
									attribute: aVariableMarker;
									onCursorEnter: [ :aTextEditor :anEvent | 
											aTextEditor text
												findAttribute: aVariableMarker
												indicesDo: [ :aVariableStart :aVariableEnd | 
													aTextEditor text
														attribute: aVariableHighlightAttribute
														from: aVariableStart
														to: aVariableEnd ] ]
										leave: [ :aTextEditor :anEvent | aTextEditor text removeAttribute: aVariableHighlightAttribute ];
									yourself ] ] ]
]

{ #category : #comparing }
GtPharoDynamicHighlightStyler >> hash [
	^ self class hash
]

{ #category : #'as yet unclassified' }
GtPharoDynamicHighlightStyler >> initialize [
	super initialize.
	variableMap := IdentityDictionary new
]

{ #category : #'api - styling' }
GtPharoDynamicHighlightStyler >> style: aText ast: theAst [
	variableMap := IdentityDictionary new.
	super style: aText ast: theAst
]

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
	| definingNode |
	super visitNamedVariable: aNamedVariable.

	definingNode := aNamedVariable whoDefines ifNil: [ aNamedVariable topParent ].
	((variableMap at: definingNode ifAbsentPut: [ Dictionary new ])
		at: aNamedVariable name
		ifAbsentPut: [ OrderedCollection new ]) add: aNamedVariable
]
