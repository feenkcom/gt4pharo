Class {
	#name : #GtPharoBehaviorCoderNameElement,
	#superclass : #BrFrame,
	#instVars : [
		'behaviorCoderViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-! Views'
}

{ #category : #callbacks }
GtPharoBehaviorCoderNameElement >> actOnCoderClassChangedFor: anAnnouncements [
]

{ #category : #'building - ui' }
GtPharoBehaviorCoderNameElement >> addAddOnsElementIn: aContainer [ 
	| addonActionsElement |
	addonActionsElement := self newAddonActionsElement.
	addonActionsElement coderViewModel: self coderViewModel.
	aContainer addChild: addonActionsElement
]

{ #category : #accessing }
GtPharoBehaviorCoderNameElement >> addAdviceDropDownIn: aContainer [ 
	behaviorCoderViewModel behavior
		ifNotNil: [ :class | 
			| adviceStream future promise |
			adviceStream := ((GtAdvice adviceForClass: class) asAsyncStream
					select: [ :each | each hasAdvice ]) cached.
			future := (adviceStream asyncSimilarCopy hasNext
				then: [ :bool | 
					bool ifTrue: [ 
						aContainer enqueueTask: (BlTaskAction new
							action: [ aContainer addChild: (self 
								buildAdviceListFor: adviceStream asyncSimilarCopy) ]) ] ]).
			promise := future await: GtSingleCoderViewModel behaviourAddOnsExecutionConfiguration.
			self enqueueTask: (BlPromiseTask new promise: promise) ]
]

{ #category : #accessing }
GtPharoBehaviorCoderNameElement >> behavior [
	<return: #Behavior>

	^ self coderViewModel coder behavior
]

{ #category : #actions }
GtPharoBehaviorCoderNameElement >> browseClassReferences [
	| classCoder |
	classCoder := behaviorCoderViewModel coder.

	classCoder theClass
		ifNotNil: [ :class | self phlow spawnObject: class gtReferences ]
]

{ #category : #'building - ui' }
GtPharoBehaviorCoderNameElement >> buildAdviceListFor: anAsyncStream [
	| button dropDownAptitude |
	button := GtFixItButton new.
	button beTinySize.
	button label: 'Advice'.
	dropDownAptitude := BrGlamorousWithExplicitDropdownAptitude
			handle: [ | dropdownButton |
				dropdownButton := BrButton new.
				dropdownButton beTinySize.
				dropdownButton
					aptitude: BrGlamorousButtonWithIconAptitude - BrGlamorousButtonWithLabelTooltipAptitude2
							- BrGlamorousButtonExteriorAptitude.
				dropdownButton icon: BrGlamorousVectorIcons repair.
				dropdownButton ]
			content: [ | element |
				element := BrSimpleList new.
				element padding: (BlInsets all: 3).
				element vFitContentLimited.
				element hExact: 300.
				element
					itemsProvider: (BrStreamItemsProvider new
							preloadAmount: 1;
							stream: anAsyncStream asyncSimilarCopy);
					stencil: [ :eachImage | eachImage buildElementFor: button ].
				element ].
	button aptitude: BrGlamorousButtonWithIconAptitude + dropDownAptitude.
	button icon: BrGlamorousVectorIcons repair.
	button margin: (BlInsets left: 5).
	^ button
]

{ #category : #'building - ui' }
GtPharoBehaviorCoderNameElement >> buildContent [
	| nameContainer classNameEditor previewButton |
	nameContainer := BrHorizontalPane new
			hMatchParent;
			alignCenterLeft;
			vFitContent.

	classNameEditor := self buildEditableNameLabel.
	self registerShortcutsForNameEditor: classNameEditor.
	classNameEditor editor
		when: BrTextEditorModifiedEvent
		do: [ :anEvent | 
			anEvent text asString trimBoth asSymbol = self coderModel name
				ifTrue: [ previewButton removeFromParent ]
				ifFalse: [ (nameContainer hasChild: previewButton)
						ifFalse: [ nameContainer addChild: previewButton after: classNameEditor ] ] ].
	self instalCompletionControllerOnNameEditor: classNameEditor.

	previewButton := self
			buildRefactoringPreviewButtonForNameEditor: classNameEditor
			inContainer: nameContainer.

	nameContainer addChild: classNameEditor.

	self addAddOnsElementIn: nameContainer.
	self addAdviceDropDownIn: nameContainer.

	^ nameContainer
]

{ #category : #'building - ui' }
GtPharoBehaviorCoderNameElement >> buildEditableNameLabel [
	| anEditor |
	anEditor := BrEditableLabel new
			aptitude: (BrGlamorousEditableLabelAptitude new
					defaultBackground: Color transparent;
					glamorousCodeFont;
					bold;
					fontSize: 18);
			inputFilter: BrTextEditorClassNameInputFilter new;
			text: self coderModel name;
			margin: (BlInsets all: 0);
			id: GtBehaviorCoderBehaviorNameId.

	anEditor
		addAptitude: (BrGlamorousWithExplicitContextMenuAptitude
				menu: [ self contextMenuItemsFromClassPhlowActionsHostElement: anEditor ]).

	^ anEditor
]

{ #category : #'building - ui' }
GtPharoBehaviorCoderNameElement >> buildRefactoringPreviewButtonForNameEditor: aClassNameEditor inContainer: aContainer [
	^ GtRefactoringsPreviewButton new
		id: GtBehaviorCoderBehaviorNameApplyPreviewId;
		margin: (BlInsets left: 5);
		refactorings: [ {GtRBRenameClassRefactoring
					model: (Smalltalk createRbNamespace
							onEnvironment: RBBrowserEnvironment new)
					rename: self coderModel theClass name
					to: aClassNameEditor text asString} ];
		cancelBlock: [ aClassNameEditor text: self coderModel theClass name ];
		when: GtRefactoringsAppliedEvent
			do: [ :anEvent | 
				| element |
				element := anEvent currentTarget.
				aContainer enqueueTask: [ aContainer removeChild: element ] asBlTask ]
]

{ #category : #accessing }
GtPharoBehaviorCoderNameElement >> coderModel [
	<return: #Behavior>

	^ self coderViewModel coder
]

{ #category : #accessing }
GtPharoBehaviorCoderNameElement >> coderViewModel [
	^ behaviorCoderViewModel 
]

{ #category : #accessing }
GtPharoBehaviorCoderNameElement >> coderViewModel: aGtBehaviorDefinitionCoderViewModel [
	self unsubscribeFromCoderViewModel.

	behaviorCoderViewModel := aGtBehaviorDefinitionCoderViewModel.
	self subscribeToCoderViewModel.
	
	self addChild: self buildContent
]

{ #category : #'building - ui' }
GtPharoBehaviorCoderNameElement >> contextMenuItemsFromClassPhlowActionsHostElement: anEditorElement [
	<return: #BrMenuItems or: nil>
	| classCoder aClass |
	classCoder := behaviorCoderViewModel coder.
	aClass := classCoder theClass ifNil: [ ^ nil ].

	^ GtCoderClassTarget menuItemsForObject: aClass hostElement: anEditorElement
]

{ #category : #initialization }
GtPharoBehaviorCoderNameElement >> initialize [
	super initialize.
	
	self
		hMatchParent;
		vFitContent
]

{ #category : #accessing }
GtPharoBehaviorCoderNameElement >> instalCompletionControllerOnNameEditor: aClassNameEditor [ 
	(GtCompletionController
		on: aClassNameEditor
		strategy: GtClassesCompletionStrategy new) install
		showOnTextModification: false.
]

{ #category : #accessing }
GtPharoBehaviorCoderNameElement >> newAddonActionsElement [
	^ GtBehaviorCoderActionsElement new
		id: #actions;
		yourself
]

{ #category : #shortcuts }
GtPharoBehaviorCoderNameElement >> registerShortcutsForNameEditor: aClassNameEditor [ 
	aClassNameEditor
		whenKey: BlKeyCombination primaryN
			labelDo: [ :aShortcutEvent | self browseClassReferences ];
		whenKey: BlKeyCombination primaryB
			labelDo: [ :aShortcutEvent | self phlow 
				spawnTool: (GtClassCoderTool observedClass: self behavior) ];
		whenKey: BlKeyCombination primaryG
			labelDo: [ :aShortcutEvent | self phlow spawnObject: self behavior ];
		whenKey: BlKeyCombination primaryR
			labelDo: [ :aShortcutEvent | aShortcutEvent currentTarget switchToEditor ];
		whenKey: BlKeyCombination primaryC
			labelDo: [ :aShortcutEvent | 
				Clipboard clipboardText: self behavior name asString ]
]

{ #category : #subscriptions }
GtPharoBehaviorCoderNameElement >> subscribeToCoderViewModel [
	behaviorCoderViewModel weak
		when: GtCoderClassChanged
		send: #actOnCoderClassChangedFor:
		to: self.
]

{ #category : #subscriptions }
GtPharoBehaviorCoderNameElement >> unsubscribeFromCoderViewModel [	
	behaviorCoderViewModel
		ifNotNil: [ :aPreviousCoderViewModel | 
			aPreviousCoderViewModel unsubscribe: self ].
]
