Class {
	#name : #GtPharoMethodCoderModificationIndicator,
	#superclass : #GtSourceCoderModificationIndicator,
	#category : #'GToolkit-Pharo-Coder-Method-UI-! Views'
}

{ #category : #initialization }
GtPharoMethodCoderModificationIndicator >> buildModifiedTooltip [
	^ self
		buildTooltip: 'The editor has code that is modified and unsaved.'
		forMethod: self textualCoderViewModel coder compiledMethod
]

{ #category : #initialization }
GtPharoMethodCoderModificationIndicator >> buildTooltip: label forMethod: method [
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
GtPharoMethodCoderModificationIndicator >> initialize [
	super initialize.

	self allowMouseEvents.
	self
		viewModel: (BrButtonModel new
				action: [ :aButton :aButtonModel :anEvent | self onClickEvent: anEvent ]).

	self
		addAptitude: (BrGlamorousWithExplicitTooltipAptitude new
				content: [ self buildModifiedTooltip ];
				withClickPositionRelocator)
]

{ #category : #'private - event handling' }
GtPharoMethodCoderModificationIndicator >> onClickEvent: anEvent [
	self hasTextualCoderViewModel ifFalse: [ ^ self ].

	self textualCoderViewModel coder compiledMethod ifNotNil: [ :aCompiledMethod | 
		self phlow spawnTool: (GtMethodCoderTool compiledMethod: aCompiledMethod) ]
]
