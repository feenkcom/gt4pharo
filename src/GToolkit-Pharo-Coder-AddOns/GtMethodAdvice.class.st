Class {
	#name : #GtMethodAdvice,
	#superclass : #Object,
	#classVars : [
		'ActiveAdvices'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-MethodAdvices'
}

{ #category : #accessing }
GtMethodAdvice class >> activeAdvices [
	^ ActiveAdvices
		ifNil: [ (self withAllSubclasses
				select: [ :each | each isAbstract not and: [ each isDefault ] ])
				collect: [ :each | each new ] ]
]

{ #category : #accessing }
GtMethodAdvice class >> activeAdvices: aCollection [
	ActiveAdvices := aCollection
]

{ #category : #accessing }
GtMethodAdvice class >> activeCritics [
	self
		deprecated: 'Use activeAdvices instead'
		transformWith: '`@receiver activeAdvices' -> '`@receiver activeAdvices'.
	^ self activeAdvices
]

{ #category : #accessing }
GtMethodAdvice class >> gtMethodsFor: aView [
	<gtClassView>
	self isAbstract ifTrue: [ ^ aView empty ].
	^ aView forward
		title: 'Issues';
		priority: 20;
		object: [ GtSearchMethodAdviceFilter new
				advice: self new;
				yourself ];
		view: #gtItemsFor:
]

{ #category : #testing }
GtMethodAdvice class >> isAbstract [
	^ self == GtMethodAdvice
]

{ #category : #testing }
GtMethodAdvice class >> isDefault [
	^ true
]

{ #category : #comparing }
GtMethodAdvice >> = anObject [
	^ self class = anObject class
]

{ #category : #accessing }
GtMethodAdvice >> description [
	^ self subclassResponsibility
]

{ #category : #styling }
GtMethodAdvice >> descriptionBlock [
	^ [ :editorElement :computedFixItActions | 
		self 
			descriptionWithEditor: editorElement
			andFixItActions: computedFixItActions ]
]

{ #category : #styling }
GtMethodAdvice >> descriptionWithEditor: anEditorElement andFixItActions: aCollectionOfFixItActions [
	| text browseAttribute inspectAttribute |
	text := self description asRopedText.
	
	browseAttribute := GtButtonAttribute new
		beAppend;
		stencil: [ 
			BrFrame new 
				fitContent;
				addChild:
				(BrButton new
					aptitude: BrGlamorousButtonWithIconAptitude new;
					margin: (BlInsets left: 5);
					beTinySize;
					icon: BrGlamorousVectorIcons browse;
					action: [ anEditorElement phlow 
						spawnTool: (GtClassCoderTool forClass: self class) ];
					label: 'Browse rule definition') ].

	inspectAttribute := GtButtonAttribute new
			beAppend;
			stencil: [ 
				BrFrame new 
				fitContent;
				addChild: (BrButton new
					aptitude: BrGlamorousButtonWithIconAptitude new;
					margin: (BlInsets left: 5);
					beTinySize;
					icon: BrGlamorousVectorIcons inspect;
					action: [ anEditorElement phlow 
						spawnObject: aCollectionOfFixItActions ];
					label: 'Inspect rules') ].
				
	text
		attribute: browseAttribute
		from: text size
		to: text size.
		
	text
		attribute: inspectAttribute
		from: text size
		to: text size.
		
	^ text
]

{ #category : #styling }
GtMethodAdvice >> elementIdUsing: aCriticStyler [
	^ GtMethodAdviceElementId indexed: aCriticStyler nextIndex.
]

{ #category : #styling }
GtMethodAdvice >> errorAttribute: aNode coderModel: aCoderModel [
	| fixItAttribute actions |
	actions := self fixItActionsForNode: aNode coderModel: aCoderModel.
	actions do: [ :each | each autoSave: true ].
	fixItAttribute := GtFixItAttribute new
			label: self name;
			description: self descriptionBlock;
			placeholderAlignment: #alignMiddle;
			fixItActions: actions;
			yourself.
	^ (GtSourceCoderErrorFixItAttribute for: 'Undeclared variable')
		fixItAttribute: fixItAttribute
]

{ #category : #styling }
GtMethodAdvice >> errorHighlightAttribute [
	^ BlTextHighlightAttribute paint: BrGlamorousColors paleErrorBackgroundColor
]

{ #category : #accessing }
GtMethodAdvice >> finish: aNode from: criticRunner [
]

{ #category : #styling }
GtMethodAdvice >> fixItActionsForNode: aNode coderModel: coderModel [
	^ #()
]

{ #category : #styling }
GtMethodAdvice >> fixItActionsForNode: aNode coderViewModel: coderViewModel [
	^ self fixItActionsForNode: aNode coderModel: coderViewModel coderModel
]

{ #category : #styling }
GtMethodAdvice >> fixItActionsForNode: aNode styler: aCriticStyler [
	^ MessageSend
		receiver: self
		selector: #fixItActionsForNode:coderViewModel:
		arguments: {aNode.
				aCriticStyler coderViewModel}
]

{ #category : #styling }
GtMethodAdvice >> fixItLocationFor: aSmaCCNode [
	(aSmaCCNode isMessage or: [ aSmaCCNode isMethodPattern ])
		ifTrue: [ ^ aSmaCCNode selectorParts last stopPosition ].
	aSmaCCNode isMessageSend
		ifTrue: [ ^ aSmaCCNode message selectorParts last stopPosition ].
	^ aSmaCCNode stopPosition
]

{ #category : #comparing }
GtMethodAdvice >> hash [
	^ self class hash
]

{ #category : #styling }
GtMethodAdvice >> highlightPositionsFor: aSmaCCNode [
	aSmaCCNode isMessage
		ifTrue: [ ^ aSmaCCNode selectorParts collect: [ :each | each sourceInterval ] ].
	aSmaCCNode isMessageSend
		ifTrue: [ ^ self highlightPositionsFor: aSmaCCNode message ].
	^ {aSmaCCNode sourceInterval}
]

{ #category : #testing }
GtMethodAdvice >> includeFixIt [
	^ true
]

{ #category : #testing }
GtMethodAdvice >> includeHighlight [
	^ true
]

{ #category : #testing }
GtMethodAdvice >> matches: aNode from: aCriticRunner [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtMethodAdvice >> name [
	^ ''
]

{ #category : #accessing }
GtMethodAdvice >> potentialFilter [
	^ nil
]

{ #category : #styling }
GtMethodAdvice >> styleFixIt: aNode using: aCriticStyler [
	| location hoverMarker hoverAttribute fixItAttribute |
	self includeFixIt ifFalse: [ ^ self ].
	location := self fixItLocationFor: aNode.
	hoverMarker := GtFixItMarkerAttribute new.
	hoverAttribute := self errorHighlightAttribute.
	fixItAttribute := GtFixItAttribute new
			label: self name;
			elementId: (self elementIdUsing: aCriticStyler);
			hoverMarker: hoverMarker;
			hoverAttribute: hoverAttribute;
			description: self descriptionBlock;
			placeholderAlignment: #alignMiddle;
			fixItActions: (self fixItActionsForNode: aNode styler: aCriticStyler);
			yourself.
	hoverMarker fixItAttribute: fixItAttribute.
	aCriticStyler
		attributes: {fixItAttribute}
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
GtMethodAdvice >> styleHighlight: aNode using: aCriticStyler [
	(self includeHighlight and: [ self includeFixIt not ]) ifFalse: [ ^ self ].
	(self highlightPositionsFor: aNode)
		do: [ :each | 
			aCriticStyler
				attributes: {self errorHighlightAttribute}
				from: each first
				to: each last ]
]

{ #category : #styling }
GtMethodAdvice >> styleIssue: aNode using: aCriticStyler [
	self styleFixIt: aNode using: aCriticStyler.
	self styleHighlight: aNode using: aCriticStyler
]
