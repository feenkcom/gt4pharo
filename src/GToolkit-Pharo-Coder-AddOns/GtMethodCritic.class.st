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
		ifNil: [ (self withAllSubclasses
				select: [ :each | each isAbstract not and: [ each isDefault ] ])
				collect: [ :each | each new ] ]
]

{ #category : #testing }
GtMethodCritic class >> isAbstract [
	^ self == GtMethodCritic
]

{ #category : #testing }
GtMethodCritic class >> isDefault [
	^ true
]

{ #category : #comparing }
GtMethodCritic >> = anObject [
	^ self class = anObject class
]

{ #category : #accessing }
GtMethodCritic >> allMethodsDo: aBlock [
	Smalltalk
		allClassesDo: [ :each | 
			each methodsDo: aBlock.
			each class methodsDo: aBlock ]
]

{ #category : #accessing }
GtMethodCritic >> description [
	^ self subclassResponsibility
]

{ #category : #styling }
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

{ #category : #accessing }
GtMethodCritic >> finish: aNode from: criticRunner [
]

{ #category : #styling }
GtMethodCritic >> fixItActionsFor: aNode using: aCriticStyler [
	^ #()
]

{ #category : #styling }
GtMethodCritic >> fixItLocationFor: aSmaCCNode [
	(aSmaCCNode isMessage or: [ aSmaCCNode isMethodPattern ])
		ifTrue: [ ^ aSmaCCNode selectorParts last stopPosition ].
	aSmaCCNode isMessageSend
		ifTrue: [ ^ aSmaCCNode message selectorParts last stopPosition ].
	^ aSmaCCNode stopPosition
]

{ #category : #comparing }
GtMethodCritic >> hash [
	^ self class hash
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
GtMethodCritic >> includeFixIt [
	^ true
]

{ #category : #testing }
GtMethodCritic >> includeHighlight [
	^ true
]

{ #category : #testing }
GtMethodCritic >> matches: aNode from: aCriticRunner [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtMethodCritic >> name [
	^ ''
]

{ #category : #accessing }
GtMethodCritic >> potentialMethodsDo: aBlock [
	^ self allMethodsDo: aBlock
]

{ #category : #styling }
GtMethodCritic >> styleFixIt: aNode using: aCriticStyler [
	| location hoverMarker hoverAttribute |
	self includeFixIt ifFalse: [ ^ self ].
	location := self fixItLocationFor: aNode.
	hoverMarker := BrTextInvisibleMarkerAttribute new.
	hoverAttribute := self errorHighlightAttribute.
	aCriticStyler
		attributes: {GtFixItAttribute new
					label: self name;
					hoverMarker: hoverMarker;
					hoverAttribute: hoverAttribute;
					description: [ :editorElement | self descriptionWithEditor: editorElement ];
					fixItActions: [ self fixItActionsFor: aNode using: aCriticStyler ];
					yourself}
		from: location
		to: location.
	self includeHighlight ifFalse: [ ^ self ].
	(self highlightPositionsFor: aNode)
		do: [ :each | 
			(aCriticStyler text from: each first to: each last)
				attribute: hoverMarker;
				onCursorEnter: [ :aTextEditor :anEvent :aFromIndex :aToIndex | 
						aTextEditor text
							findAttribute: hoverMarker
							indicesDo: [ :aHighlightStart :aHighlightEnd | 
								(aTextEditor text from: aHighlightStart to: aHighlightEnd)
									attribute: hoverAttribute ] ]
					leave: [ :aTextEditor :anEvent :aFromIndex :aToIndex | aTextEditor text clearAttributes: [ :e | e == hoverAttribute ] ] ]
]

{ #category : #styling }
GtMethodCritic >> styleHighlight: aNode using: aCriticStyler [
	(self includeHighlight and: [ self includeFixIt not ]) ifFalse: [ ^ self ].
	(self highlightPositionsFor: aNode)
		do: [ :each | 
			aCriticStyler
				attributes: {self errorHighlightAttribute}
				from: each first
				to: each last ]
]

{ #category : #styling }
GtMethodCritic >> styleIssue: aNode using: aCriticStyler [
	self styleFixIt: aNode using: aCriticStyler.
	self styleHighlight: aNode using: aCriticStyler
]
