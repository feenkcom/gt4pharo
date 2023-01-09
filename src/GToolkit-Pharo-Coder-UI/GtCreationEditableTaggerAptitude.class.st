Class {
	#name : #GtCreationEditableTaggerAptitude,
	#superclass : #BrGlamorousTaggerEditableAptitude,
	#instVars : [
		'addButton'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Tagger'
}

{ #category : #private }
GtCreationEditableTaggerAptitude >> addTagCreatorElement [
	addButton beNotFocusable.
	self
		addTagElement: self newTagCreatorElement
		withSeparatorAt: tagElements size + 1
]

{ #category : #'private - instance creation' }
GtCreationEditableTaggerAptitude >> newAddTagButton [
	^ addButton := BrButton new beFocusable
		aptitude:
			BrGlamorousButtonRectangularAptitude new
				+ BrGlamorousButtonIconAptitude new
				+ BrGlamorousButtonWithLabelTooltipAptitude new
				+
					(BrInteractiveCommonAptitude new
						default: [ :aWidget | 
							aWidget
								border: BlBorder empty;
								background: self theme status neutralBackgroundColor ];
						hovered: [ :aWidget | 
							aWidget background:
								self theme status neutralBackgroundColor darker ];
						pressed: [ :aWidget | 
							aWidget
								background:
									self theme status neutralBackgroundColor darker darker ];
						focused: [ :aWidget | 
							aWidget
								border: (BlBorder paint: self theme editor focusedBorderColor width: 1) ]);
		icon: BrGlamorousVectorIcons add;
		label: 'Add';
		beSmallSize;
		hExact: 20;
		margin: margin;
		constraintsDo: [ :c | c flow vertical alignCenter ];
		action: [ :aButton | self addTagCreatorElement ];
		when: BlFocusInEvent do: [ :anEvent | self addTagCreatorElement ];
		addShortcut:
			(BlShortcutWithAction new
				combination: BlKeyCombination arrowLeft;
				action: [ :anEvent | 
					anEvent currentTarget
						previousSiblingDo: [ :anElement | anElement requestFocus ] ]);
		addShortcut:
			(BlShortcutWithAction new
				combination: BlKeyCombination enter;
				action: [ :anEvent | self addTagCreatorElement ])
]

{ #category : #'private - instance creation' }
GtCreationEditableTaggerAptitude >> newTagCreatorElement [
	| aNewTagCreator |
	aNewTagCreator := (tagLabelStencil tag: (BrTaggerTag named: '')) asElement
			requestFocus;
			switchToEditor;
			padding: (BlInsets
					top: 5
					left: 6
					bottom: 5
					right: 6);
			margin: margin;
			constraintsDo: [ :c | c flow vertical alignCenter ];
			when: BrEditorAcceptWish
				do: [ :aWish | 
					addButton beFocusable.
					aWish text
						ifEmpty: [ self
								removeTagCreatorElement: aWish currentTarget
								withSeparatorAt: tagElements size + 1 ]
						ifNotEmpty: [ self
								requestAddTag: (BrTaggerTag named: aWish text asString)
								from: aWish currentTarget ] ];
			when: BrEditorCancelWish
				do: [ :anEvent | 
					anEvent currentTarget focusPrevious.
					addButton beFocusable.
					self
						removeTagElement: anEvent currentTarget
						withSeparatorAt: tagElements size + 1 ].

	aNewTagCreator navigator
		moveTo: 0;
		apply.

	^ aNewTagCreator
]