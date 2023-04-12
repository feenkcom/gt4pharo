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
	self
		addTagElement: self newTagCreatorElement
		withSeparatorAt: tagElements size + 1
]

{ #category : #accessing }
GtCreationEditableTaggerAptitude >> deletionShortcutUsing: aTag forLabel: aLabel [
	^ BlShortcutWithAction new
		name: 'Delete tag';
		description: 'Delete tag if the editor is already empty.';
		combination: BlKeyCombination backspace;
		action: [ :anEvent | aLabel text ifEmpty: [ self requestRemoveTag: aTag from: aLabel ] ]
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
	| aNewTagCreator done |
	done := false.
	aNewTagCreator := (tagLabelStencil tag: (BrTaggerTag named: '')) asElement
			when: BlFocusInEvent do: [ :anEvent | aNewTagCreator selecter all select ];
			when: BlFocusOutEvent
				do: [ :anEvent | aNewTagCreator deselecter all deselect ];
			padding: (BlInsets
					top: 5
					left: 6
					bottom: 5
					right: 6);
			margin: margin;
			constraintsDo: [ :c | c flow vertical alignCenter ];
			addShortcut: (BlShortcutWithAction new
					name: 'Move to previous form item';
					description: 'Moves to the previous form item. If none is found, we cycle back to the last.';
					combination: BlKeyCombination shiftTab;
					action: [ :anEvent | 
						BlFocusFinder new
							direction: BlFocusSearchDirectionBackward new;
							root: tags parent parent parent;
							referenceElement: anEvent currentTarget;
							nextFocusDo: #requestFocus ifNone: [  ].
						aNewTagCreator text
							ifEmpty: [ self
									removeTagCreatorElement: aNewTagCreator
									withSeparatorAt: tagElements size + 1 ]
							ifNotEmpty: [ self
									requestAddTag: (BrTaggerTag named: aNewTagCreator text asString)
									from: aNewTagCreator ] ]);
			addShortcut: (BlShortcutWithAction new
					name: 'Move to next form item';
					description: 'Moves to the next form item. If none is found, we cycle back to the first.';
					combination: BlKeyCombination tab;
					action: [ :anEvent | 
						anEvent currentTarget
							fireEvent: (BrEditorAcceptWish new text: anEvent currentTarget text).
						anEvent currentTarget text
							ifEmpty: [ BlFocusFinder new
									direction: BlFocusSearchDirectionForward new;
									root: tags parent parent parent;
									referenceElement: addButton;
									nextFocusDo: #requestFocus ifNone: [  ].
								aNewTagCreator text
									ifEmpty: [ self
											removeTagCreatorElement: aNewTagCreator
											withSeparatorAt: tagElements size + 1 ]
									ifNotEmpty: [ self
											requestAddTag: (BrTaggerTag named: aNewTagCreator text asString)
											from: aNewTagCreator ] ]
							ifNotEmpty: [ self addTagCreatorElement ] ]).

	aNewTagCreator editor
		when: BrTextEditorModifiedEvent
		do: [ :aWish | 
			done
				ifFalse: [ done := true.
					self
						requestAddTag: (BrTaggerTag named: aWish text asString)
						from: aNewTagCreator ] ].

	aNewTagCreator navigator
		moveTo: 0;
		apply.

	^ aNewTagCreator requestFocus
]

{ #category : #accessing }
GtCreationEditableTaggerAptitude >> newTagElementFor: aTaggerTag [
	| anEditor aShortcut |
	anEditor := (tagLabelStencil tag: aTaggerTag) asElement margin: margin.

	anEditor
		when: BlFocusInEvent do: [ :anEvent | anEditor selecter all select ];
		when: BlFocusOutEvent
			do: [ :anEvent | 
				anEditor deselecter all deselect.
				anEditor text ifEmpty: [ self requestRemoveTag: aTaggerTag from: anEditor ] ].

	anEditor editor
		when: BrTextEditorModifiedEvent
		do: [ :aWish | 
			aWish text
				ifEmpty: [ anEditor
						addShortcut: (aShortcut := self deletionShortcutUsing: aTaggerTag forLabel: anEditor) ]
				ifNotEmpty: [ aShortcut
						ifNotNil: [ anEditor removeShortcut: aShortcut.
							aShortcut := nil ] ].
			self
				requestRenameTag: aTaggerTag
				to: aWish text asString
				from: anEditor ].
	^ anEditor
]

{ #category : #accessing }
GtCreationEditableTaggerAptitude >> onTagAdded: aTaggerTag at: aTagIndex [
	| aTagElement |
	aTagElement := self newTagElementFor: aTaggerTag.
	self assignTag: aTaggerTag toElement: aTagElement.

	self addTagElement: aTagElement withSeparatorAt: aTagIndex.
	tagElements add: aTagElement beforeIndex: aTagIndex.

	shouldGiveFocusToNewTag
		ifTrue: [ aTagElement requestFocus deselecter all deselect ]
]

{ #category : #accessing }
GtCreationEditableTaggerAptitude >> onTagRemoved: aTaggerTag at: anIndex [
	self
		tagElementFor: aTaggerTag
		ifFound: [ :aTagElement | 
			tagElements remove: aTagElement.
			self removeTagElement: aTagElement withSeparatorAt: anIndex ]
]
