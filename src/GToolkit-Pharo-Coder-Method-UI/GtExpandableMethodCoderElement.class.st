Class {
	#name : #GtExpandableMethodCoderElement,
	#superclass : #GtExpandableSourceCoderElement,
	#instVars : [
		'tagsElement'
	],
	#category : #'GToolkit-Pharo-Coder-Method-UI-! Views'
}

{ #category : #private }
GtExpandableMethodCoderElement >> alignTagsElementBottomRight: aTagsElement [
	aTagsElement
		constraintsDo: [ :c |
			c ignored horizontal alignRight.
			c ignored vertical alignBottom ]
]

{ #category : #private }
GtExpandableMethodCoderElement >> alignTagsElementCenterRight: aTagsElement [
	aTagsElement
		constraintsDo: [ :c |
			c ignored horizontal alignRight.
			c ignored vertical alignCenter ]
]

{ #category : #accessing }
GtExpandableMethodCoderElement >> buildModifiedTooltip [
	^ self
		buildTooltip: 'The editor has code that is modified and unsaved.'
		forMethod: self textualCoderViewModel coder compiledMethod
]

{ #category : #accessing }
GtExpandableMethodCoderElement >> buildTooltip: label forMethod: method [
	| text |
	text := label asRopedText.
	method
		ifNotNil: [ text := text , String cr asRopedText
					, ('Browse' asRopedText
							replacingAdornment: [ BrButton new
									aptitude: BrGlamorousLinkSquaredButtonWithLabelAptitude new glamorousRegularFont
											glamorousRegularSmallSize;
									beSmallSize;
									margin: (BlInsets
											top: 10
											left: 2
											bottom: 10
											right: 10);
									label: 'Browse';
									action: [ self phlow spawnTool: (GtMethodCoderTool compiledMethod: method) ] ])
					, ' the installed method.' asRopedText ].
	text glamorousRegularFont.
	^ BrEditor new
		aptitude: BrGlamorousEditorAptitude new glamorousRegularSmallSize;
		padding: (BlInsets all: 5);
		fitContentLimited;
		beReadOnlyWithSelection;
		text: text
]

{ #category : #initialization }
GtExpandableMethodCoderElement >> initialize [
	super initialize.
	
	tagsElement := self newTagsElement.
	self addChild: tagsElement
]

{ #category : #'private - instance creation' }
GtExpandableMethodCoderElement >> newModificationIndicator [
	| indicator |
	indicator := super newModificationIndicator.
	indicator
		allowMouseEvents;
		addAptitude: (BrGlamorousWithExplicitTooltipAptitude  new
				content: [ self buildModifiedTooltip ];
				withClickPositionRelocator);
		when: BlClickEvent
			do: [ :evt | 
				self textualCoderViewModel coder compiledMethod
					ifNotNil: [ :method | self phlow spawnTool: (GtMethodCoderTool compiledMethod: method) ] ].
	^ indicator
]

{ #category : #'private - instance creation' }
GtExpandableMethodCoderElement >> newTagsElement [
	^ self newTagsElementClass new
		constraintsDo: [ :c | 
			c ignoreByLayout.
			c ignored horizontal alignRight.
			c ignored vertical alignBottom.
			c margin: (BlInsets top: 5 left: 5 bottom: 5 right: 5) ];
		zIndex: 10
]

{ #category : #'private - instance creation' }
GtExpandableMethodCoderElement >> newTagsElementClass [
	^ GtPharoMethodCoderTagsElement
]

{ #category : #private }
GtExpandableMethodCoderElement >> onCollapsed [
	super onCollapsed.
		
	self alignTagsElementCenterRight: tagsElement
]

{ #category : #private }
GtExpandableMethodCoderElement >> onExpanded [
	super onExpanded.
		
	self alignTagsElementBottomRight: tagsElement
]

{ #category : #'api - textual coder view model' }
GtExpandableMethodCoderElement >> onTextualCoderViewModelChanged [
	super onTextualCoderViewModelChanged.
	
	BlFrameTelemetry
		time: [ tagsElement class name, ' #pharoMethodCoderViewModel:' ]
		during: [ tagsElement pharoMethodCoderViewModel: textualCoderViewModel ]
]
