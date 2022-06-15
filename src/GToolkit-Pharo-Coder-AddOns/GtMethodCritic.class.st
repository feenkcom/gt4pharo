Class {
	#name : #GtMethodCritic,
	#superclass : #Object,
	#classVars : [
		'ActiveCritics'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Critics'
}

{ #category : #accessing }
GtMethodCritic class >> activeCritics [
	^ ActiveCritics
		ifNil: [ (self withAllSubclasses reject: [ :each | each isAbstract ])
				collect: [ :each | each new ] ]
]

{ #category : #testing }
GtMethodCritic class >> isAbstract [
	^ self == GtMethodCritic
]

{ #category : #private }
GtMethodCritic >> attributes [
	^ #()
]

{ #category : #styling }
GtMethodCritic >> attributesAndLocationsFor: aSmaCCNode from: coderModel do: aBlock [
	aBlock
		value: (self attributesFor: aSmaCCNode from: coderModel)
		value: (self locationFor: aSmaCCNode).
	self includeHighlight
		ifTrue: [ (self highlightPositionsFor: aSmaCCNode)
				do: [ :each | aBlock value: {self errorHighlightAttribute} value: each ] ]
]

{ #category : #private }
GtMethodCritic >> attributesFor: aNode [
	^ self attributes
]

{ #category : #private }
GtMethodCritic >> attributesFor: aNode from: coderModel [
	^ self attributesFor: aNode
]

{ #category : #accessing }
GtMethodCritic >> description [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtMethodCritic >> descriptionWithEditor: anEditorElement [
	| text browseAttribute |
	text := self description asRopedText.
	browseAttribute := GtButtonAttribute new
			beAppend;
			stencil: [ BrButton new
					aptitude: BrGlamorousButtonWithIconAptitude new;
					beTinySize;
					margin: (BlInsets left: 5);
					icon: BrGlamorousVectorIcons browse;
					action: [ anEditorElement phlow spawnTool: (GtClassCoderTool forClass: self class) ];
					label: 'Browse rule definition' ].
	text
		attribute: browseAttribute
		from: text size
		to: text size.
	^ text
]

{ #category : #styling }
GtMethodCritic >> errorHighlightAttribute [
	^ BlTextHighlightAttribute paint: BrGlamorousColors paleErrorBackgroundColor
]

{ #category : #styling }
GtMethodCritic >> highlightPositionsFor: aSmaCCNode [
	aSmaCCNode isMessage
		ifTrue: [ ^ aSmaCCNode selectorParts collect: [ :each | each sourceInterval ] ].
	aSmaCCNode isMessageSend
		ifTrue: [ ^ self highlightPositionsFor: aSmaCCNode message ].
	^ {aSmaCCNode sourceInterval}
]

{ #category : #testing }
GtMethodCritic >> includeHighlight [
	^ true
]

{ #category : #private }
GtMethodCritic >> locationFor: aSmaCCNode [
	^ aSmaCCNode sourceInterval
]

{ #category : #testing }
GtMethodCritic >> matches: aNode [
	self subclassResponsibility
]
