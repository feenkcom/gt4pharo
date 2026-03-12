Class {
	#name : #GtPharoBigMethodExpandedSourceCoderElement,
	#superclass : #GtSourceCoderExpandedContentElement,
	#instVars : [
		'label',
		'selectorLabel'
	],
	#category : #'GToolkit-Pharo-Coder-BigMethods-Coder'
}

{ #category : #initialization }
GtPharoBigMethodExpandedSourceCoderElement >> initialize [
	| coderText |
	super initialize.
	selectorLabel := BlAttributedTextElement new
			id: GtSourceCoderCollapsedTextId;
			editorMeasurement;
			bold;
			glamorousCodeFont;
			foreground: self theme label defaultTextForeground;
			text: 'selector' asRopedText.
	coderText := 'This is a large method. ' asRopedText.
	coderText
		attribute: (GtButtonAttribute new
				beAppend;
				stencil: [ BrButton new
						aptitude: BrGlamorousLinkSquaredButtonWithLabelAptitude new;
						beSmallSize;
						margin: (BlInsets
								top: 1
								left: 0
								bottom: 0
								right: 0);
						padding: (BlInsets
								top: 3
								left: 5
								bottom: 3
								right: 5);
						label: 'Inspect it';
						action: [ :aButton | 
							| method methodCoder expanded |
							method := self textualCoderViewModel coder methodReference method.
							methodCoder := GtPharoMethodCoder
									forClass: method methodClass
									source: method sourceCode.
							expanded := GtSourceCoderExpandedContentElement new
									coderViewModel: methodCoder asCoderViewModel;
									showScrollbars;
									hMatchParent;
									vFitContentLimited;
									yourself.
							aButton phlow spawnObject: expanded ] ]).
	coderText := coderText , ' to see source' asRopedText.
	label := BrEditor new
			aptitude: (BrGlamorousRegularEditorAptitude new
					glamorousCodeFont;
					foreground: self theme label defaultTextForeground);
			beReadOnlyWithoutSelection;
			text: coderText.
	self removeChild: editorElement.
	self addChildFirst: label.
	self addChildFirst: selectorLabel.
	self
		addAptitude: (BrGlamorousWithExplicitContextMenuAptitude
				menu: [ self createHeaderContextMenu ])
]

{ #category : #'as yet unclassified' }
GtPharoBigMethodExpandedSourceCoderElement >> onPostTextualCoderViewModelChanged [
	super onPostTextualCoderViewModelChanged.
	textualCoderViewModel
		ifNotNil: [ selectorLabel text: textualCoderViewModel coder selector asRopedText ]
]
