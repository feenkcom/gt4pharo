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

{ #category : #accessing }
GtCreationEditableTaggerAptitude >> margin: aBlInsets [
	margin := aBlInsets.
	tags replaceChild: addButton with: (addButton := self newAddTagButton)
]

{ #category : #'private - instance creation' }
GtCreationEditableTaggerAptitude >> newAddTagButton [
	^ addButton := BrButton new beFocusable
			aptitude: BrGlamorousButtonWithIconAptitude new;
			icon: BrGlamorousVectorIcons add;
			label: 'Add';
			beSmallSize;
			hExact: 20;
			margin: margin;
			constraintsDo: [ :c | c flow vertical alignCenter ];
			action: [ :aButton | self addTagCreatorElement ];
			when: BlFocusInEvent do: [ :anEvent | self addTagCreatorElement ];
			addShortcut: (BlShortcutWithAction new
					combination: BlKeyCombination shiftTab;
					action: [ :anEvent | 
						BlFocusFinder new
							direction: BlFocusSearchDirectionBackward new;
							root: tags parent parent parent;
							referenceElement: anEvent currentTarget;
							nextFocusDo: #requestFocus ifNone: [  ] ])
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
						withSeparatorAt: tagElements size + 1 ];
			addShortcut: (BlShortcutWithAction new
					combination: BlKeyCombination shiftTab;
					action: [ :anEvent | 
						BlFocusFinder new
							direction: BlFocusSearchDirectionBackward new;
							root: tags parent parent parent;
							referenceElement: anEvent currentTarget;
							nextFocusDo: #requestFocus ifNone: [  ] ]);
			addShortcut: (BlShortcutWithAction new
					combination: BlKeyCombination tab;
					action: [ :anEvent | 
						anEvent currentTarget
							fireEvent: (BrEditorAcceptWish new text: anEvent currentTarget text).
						anEvent currentTarget text
							ifEmpty: [ BlFocusFinder new
									direction: BlFocusSearchDirectionForward new;
									root: tags parent parent parent;
									referenceElement: addButton;
									nextFocusDo: #requestFocus ifNone: [  ] ]
							ifNotEmpty: [ self addTagCreatorElement ] ]).

	aNewTagCreator navigator
		moveTo: 0;
		apply.

	^ aNewTagCreator
]

{ #category : #accessing }
GtCreationEditableTaggerAptitude >> newTagElementFor: aTaggerTag [
	^ (super newTagElementFor: aTaggerTag)
		when: BrEditorAcceptWish
			do: [ :aWish | 
				aWish text asString
					ifEmpty: [ self requestRemoveTag: aTaggerTag from: aWish currentTarget ]
					ifNotEmpty: [ self
							requestRenameTag: aTaggerTag
							to: aWish text asString
							from: aWish currentTarget ] ];
		addShortcut: (BlShortcutWithAction new
				combination: BlKeyCombination shiftTab;
				action: [ :anEvent | 
					BlFocusFinder new
						direction: BlFocusSearchDirectionBackward new;
						root: tags parent parent parent;
						referenceElement: anEvent currentTarget;
						nextFocusDo: #requestFocus ifNone: [  ] ]);
		addShortcut: (BlShortcutWithAction new
				combination: BlKeyCombination tab;
				action: [ :anEvent | 
					BlFocusFinder new
						direction: BlFocusSearchDirectionForward new;
						root: tags parent parent parent;
						referenceElement: anEvent currentTarget;
						nextFocusDo: #requestFocus ifNone: [  ] ])
]
