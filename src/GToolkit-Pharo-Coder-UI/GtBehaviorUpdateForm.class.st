Class {
	#name : #GtBehaviorUpdateForm,
	#superclass : #GtClassCreationForm,
	#instVars : [
		'superSlots'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Forms - Models'
}

{ #category : #accessing }
GtBehaviorUpdateForm class >> isAdditionForm [
	^ false
]

{ #category : #accessing }
GtBehaviorUpdateForm >> abstractClassVariable: varName [
	| aModel aClass |
	aModel := self createRefactoringModel.
	aClass := (self modelClassFrom: aModel) classSide.

	^ RBAbstractInstanceVariableRefactoring
		model: aModel
		variable: varName
		class: aClass
]

{ #category : #accessing }
GtBehaviorUpdateForm >> abstractVariable: varName [
	| aModel aClass |
	aModel := self createRefactoringModel.
	aClass := self modelClassFrom: aModel.

	^ RBAbstractInstanceVariableRefactoring
		model: aModel
		variable: varName
		class: aClass
]

{ #category : #accessing }
GtBehaviorUpdateForm >> addRefactoringPreviewFor: aRefactoring in: anElement [
	| button |
	button := GtRefactoringsInDropdownPreviewElement new
			id: GtBehaviorCoderBehaviorNameApplyPreviewId;
			beSmallSize;
			margin: (BlInsets top: 0 right: 5 bottom: 3 left: 0 );
			constraintsDo: [ :c | 
				c linear vertical alignCenter.
				c flow vertical alignCenter ];
			refactoringsViewModel: GtRefactoringsViewModel new;
			previewContentDo: [ :aPreviewElement :aRefactoringsViewModel | 
				aRefactoringsViewModel refactorings: [ {aRefactoring} ].
				aPreviewElement hFitContentLimited ];
			cancelBlock: [ :theButton :aRefactoringViewModel | 
				theButton
					hide;
					removeFromParent ];
			when: GtRefactoringsAppliedEvent
				do: [ :anEvent | 
					anEvent currentTarget
						hide;
						removeFromParent ].

	anElement parent addChild: button after: anElement.
	button enqueueTask: [ button showPreview ] asBlTask
]

{ #category : #accessing }
GtBehaviorUpdateForm >> browseReferencesToClassSlot: aSlotName in: anElement [
	anElement phlow
		spawnObject: (GtSearchClassSlotReferenceFilter
				forClassAndSubclasses: (Smalltalk at: self rawClassName asSymbol) class
				andVariable: aSlotName)
]

{ #category : #accessing }
GtBehaviorUpdateForm >> browseReferencesToClassVar: aClassVarName in: anElement [
	anElement phlow
		spawnObject: (GtSearchClassVariableReferenceFilter
				forClassAndSubclasses: (Smalltalk at: self rawClassName asSymbol)
				andVariable: aClassVarName)
]

{ #category : #accessing }
GtBehaviorUpdateForm >> browseReferencesToSlot: aSlotName in: anElement [
	anElement phlow
		spawnObject: (GtSearchInstanceSlotReferenceFilter
				forClassAndSubclasses: (Smalltalk at: self rawClassName asSymbol)
				andVariable: aSlotName)
]

{ #category : #accessing }
GtBehaviorUpdateForm >> changesForUpdatingClassSlotsOn: aClass [
	| changes slotsToAdd slotsToRemove |
	slotsToAdd := classSlots difference: aClass classSide slotNames.
	slotsToRemove := aClass classSide slotNames difference: classSlots.
	
	changes := (slotsToAdd
		collect: [ :aSlotName | 
			RBAddInstanceVariableChange 
				add: aSlotName 
				to: aClass classSide ]),
		(slotsToRemove
			collect: [ :aSlotName | 
				RBRemoveInstanceVariableChange 
					remove: aSlotName 
					from: aClass classSide ]).
		
	^ changes
]

{ #category : #accessing }
GtBehaviorUpdateForm >> classSlotsDescription [
	<magritteDescription>
	^ super classSlotsDescription
		blocListStencil: (self
				taggerStencilWithCompletion: nil
				contextMenuContentBlock: [ :aVariable :anElement :aMemento | 
					aMemento overallStatus valueOrNil isChanged
						ifTrue: [ GtCoderContextMenuContent new editorElement: anElement ]
						ifFalse: [ self createClassSlotsContextMenuContentFor: aVariable editor: anElement ] ]
				contextMenuBlock: [ :aSlotName :anElement :aMemento | 
					self class environment
						at: self rawClassName asSymbol
						ifPresent: [ :aClass | 
							(aClass classSide slotNamed: aSlotName) ifNotNil: [ :aSlot |
								GtCoderVariableTarget 
									menuItemsForObject: aSlot 
									hostElement: anElement ] ]
						ifAbsent: [ nil ] ]);
		blocShortcuts: [ {BlShortcutWithAction new
					name: 'Inspect slot';
					description: 'Inspect the slot indicated by the editor';
					combination: BlKeyCombination primaryG;
					action: [ :anEvent | 
						anEvent target phlow
							spawnObject: (self newClassName asString asClass classSide
									slotNamed: anEvent target text asString) ].
				BlShortcutWithAction new
					name: 'Browse slot references';
					description: 'Browses references to the slot indicated by the editor';
					combination: BlKeyCombination primaryN;
					action: [ :anEvent | 
						anEvent currentTarget phlow
							spawnObject: (GtSearchClassSlotReferenceFilter
									forClassAndSubclasses: self newClassName asString asClass classSide
									andVariable: anEvent target text asString) ]} ]
]

{ #category : #accessing }
GtBehaviorUpdateForm >> classVarsDescription [
	<magritteDescription>
	^ super classVarsDescription
		blocListStencil: (self
				taggerStencilWithCompletion: nil
				contextMenuContentBlock: [ :aVariable :anElement :aMemento | self createClassVarsContextMenuContentFor: aVariable editor: anElement ]
				contextMenuBlock: [ :aSlotName :anElement :aMemento | 
					self class environment
						at: self rawClassName asSymbol
						ifPresent: [ :aClass | 
							(aClass classVariableNamed: aSlotName ifAbsent: [ nil ]) ifNotNil: [ :aSlot |
								GtCoderVariableTarget 
									menuItemsForObject: aSlot 
									hostElement: anElement ] ]
						ifAbsent: [ nil ] ]);
		blocShortcuts: [ {BlShortcutWithAction new
					name: 'Inspect variable';
					description: 'Inspect the variable indicated by the editor';
					combination: BlKeyCombination primaryG;
					action: [ :anEvent | 
						anEvent target phlow
							spawnObject: (self newClassName asString asClass classVarNamed: anEvent target text asString) ].
				BlShortcutWithAction new
					name: 'Browse variable references';
					description: 'Browses references to the variable indicated by the editor';
					combination: BlKeyCombination primaryN;
					action: [ :anEvent | 
						anEvent currentTarget phlow
							spawnObject: (GtSearchReferencesFilter
									literal: (self newClassName asString asClass bindingOf: anEvent target text asString)) ]} ]
]

{ #category : #accessing }
GtBehaviorUpdateForm >> commit [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtBehaviorUpdateForm >> createClassSlotsContextMenuContentFor: aSlotName editor: anElement [
	| theContextMenu items |
	theContextMenu := GtFormContextMenuContent new editorElement: anElement.
	items := OrderedCollection new.
	items
		addAll: {GtCoderContextMenuAction new
					action: [ :form :elem | self browseReferencesToClassSlot: aSlotName in: elem ];
					title: (self createLabelTextFor: 'Browse references' description: aSlotName).
				GtCoderContextMenuAction new
					action: [ self
							addRefactoringPreviewFor: (self pushUpClassSlotRefactoringFor: aSlotName)
							in: anElement ];
					title: (self createLabelTextFor: 'Push up' description: aSlotName).
				GtCoderContextMenuAction new
					action: [ self
							addRefactoringPreviewFor: (self pushDownClassSlotRefactoringFor: aSlotName)
							in: anElement ];
					title: (self createLabelTextFor: 'Push down' description: aSlotName).
				GtCoderContextMenuAction new
					action: [ self
							addRefactoringPreviewFor: (self generateClassAccessorsFor: aSlotName asClassVar: false)
							in: anElement ];
					title: (self createLabelTextFor: 'Create accessors' description: aSlotName).
				GtCoderContextMenuAction new
					action: [ self
							addRefactoringPreviewFor: (self abstractClassVariable: aSlotName)
							in: anElement ];
					title: (self createLabelTextFor: 'Abstract' description: aSlotName).
				GtCoderContextMenuAction new
					action: [ self
							addRefactoringPreviewFor: (self protectClassVariable: aSlotName)
							in: anElement ];
					title: (self createLabelTextFor: 'Protect' description: aSlotName)}.
	theContextMenu items: items.
	^ theContextMenu
]

{ #category : #accessing }
GtBehaviorUpdateForm >> createClassVarsContextMenuContentFor: aClassVarName editor: anElement [
	| theContextMenu items |
	theContextMenu := GtFormContextMenuContent new editorElement: anElement.
	items := OrderedCollection new.
	items
		addAll: {GtCoderContextMenuAction new
					action: [ :form :elem | self browseReferencesToClassVar: aClassVarName in: elem ];
					title: (self createLabelTextFor: 'Browse references' description: aClassVarName).
				GtCoderContextMenuAction new
					action: [ self
							addRefactoringPreviewFor: (self pushUpClassVariableRefactoringFor: aClassVarName)
							in: anElement ];
					title: (self createLabelTextFor: 'Push up' description: aClassVarName).
				GtCoderContextMenuAction new
					action: [ self
							addRefactoringPreviewFor: (self pushDownClassVariableRefactoringFor: aClassVarName)
							in: anElement ];
					title: (self createLabelTextFor: 'Push down' description: aClassVarName).
				GtCoderContextMenuAction new
					action: [ self
							addRefactoringPreviewFor: (self generateAccessorsFor: aClassVarName asClassVar: true)
							in: anElement ];
					title: (self createLabelTextFor: 'Create accessors' description: aClassVarName)}.
	theContextMenu items: items.
	^ theContextMenu
]

{ #category : #accessing }
GtBehaviorUpdateForm >> createLabelTextFor: aString description: description [
	^ aString asRopedText glamorousRegularFont
		, ((' ' , description) asRopedText
				glamorousCodeFont;
				foreground: Color gray;
				glamorousCodeTinySize)
]

{ #category : #accessing }
GtBehaviorUpdateForm >> createRefactoringModel [
	^ Smalltalk createRbNamespace onEnvironment: RBBrowserEnvironment new
]

{ #category : #accessing }
GtBehaviorUpdateForm >> createSlotsContextMenuContentFor: aSlotName editor: anElement [
	| theContextMenu items |
	theContextMenu := GtFormContextMenuContent new editorElement: anElement.
	items := OrderedCollection new.
	items
		addAll: {GtCoderContextMenuAction new
					action: [ :form :elem | self browseReferencesToSlot: aSlotName in: elem ];
					title: (self createLabelTextFor: 'Browse references' description: aSlotName).
				GtCoderContextMenuAction new
					action: [ self
							addRefactoringPreviewFor: (self pushUpSlotRefactoringFor: aSlotName)
							in: anElement ];
					title: (self createLabelTextFor: 'Push up' description: aSlotName).
				GtCoderContextMenuAction new
					action: [ self
							addRefactoringPreviewFor: (self pushDownSlotRefactoringFor: aSlotName)
							in: anElement ];
					title: (self createLabelTextFor: 'Push down' description: aSlotName).
				GtCoderContextMenuAction new
					action: [ self
							addRefactoringPreviewFor: (self generateAccessorsFor: aSlotName asClassVar: false)
							in: anElement ];
					title: (self createLabelTextFor: 'Create accessors' description: aSlotName).
				GtCoderContextMenuAction new
					action: [ self
							addRefactoringPreviewFor: (self abstractVariable: aSlotName)
							in: anElement ];
					title: (self createLabelTextFor: 'Abstract' description: aSlotName).
				GtCoderContextMenuAction new
					action: [ self addRefactoringPreviewFor: (self protectVariable: aSlotName) in: anElement ];
					title: (self createLabelTextFor: 'Protect' description: aSlotName)}.
	theContextMenu items: items.
	^ theContextMenu
]

{ #category : #accessing }
GtBehaviorUpdateForm >> createUpdateClassSlotsRefactoringOn: aClass [
	| changes |
	changes := self changesForUpdatingClassSlotsOn: aClass.
			
	^ RBCompositeRefactoryChange new
		name: 'Update class slots';
		changes: changes;
		yourself
]

{ #category : #accessing }
GtBehaviorUpdateForm >> executeRefactoring: refactoring [
	[ refactoring execute ]
		on: RBRefactoringError
		do: [ :ex | 
			| message |
			message := ex messageText.
			(message endsWith: 'Browse references?')
				ifTrue: [ message := message allButLast: 18 ].
			self inform: message ]
]

{ #category : #'api - initialization' }
GtBehaviorUpdateForm >> fillFormWithClass: aClass [
	"Ignore for the update forms"

	
]

{ #category : #accessing }
GtBehaviorUpdateForm >> generateAccessorsFor: varName asClassVar: aBoolean [
	| aModel aClass |
	aModel := self createRefactoringModel.
	aClass := self modelClassFrom: aModel.

	^ RBCreateAccessorsForVariableRefactoring
		model: aModel
		variable: varName
		class: aClass
		classVariable: aBoolean
]

{ #category : #accessing }
GtBehaviorUpdateForm >> generateClassAccessorsFor: varName [
	| aModel aClass |
	aModel := self createRefactoringModel.
	aClass := (self modelClassFrom: aModel) classSide.

	^ RBCreateAccessorsForVariableRefactoring
		model: aModel
		variable: varName
		class: aClass
		classVariable: false
]

{ #category : #accessing }
GtBehaviorUpdateForm >> generateClassAccessorsFor: varName asClassVar: aBoolean [
	| aModel aClass |
	aModel := self createRefactoringModel.
	aClass := (self modelClassFrom: aModel) classSide.

	^ RBCreateAccessorsForVariableRefactoring
		model: aModel
		variable: varName
		class: aClass
		classVariable: aBoolean
]

{ #category : #accessing }
GtBehaviorUpdateForm >> initialize [
	super initialize.
	
	classSlots := OrderedCollection new.
]

{ #category : #accessing }
GtBehaviorUpdateForm >> modelClassFrom: aModel [
	^ aModel classNamed: self newClassName asString asSymbol
]

{ #category : #accessing }
GtBehaviorUpdateForm >> nameDescription [
	^ nil
]

{ #category : #accessing }
GtBehaviorUpdateForm >> protectClassVariable: varName [
	| aModel aClass |
	aModel := self createRefactoringModel.
	aClass := (self modelClassFrom: aModel) classSide.

	^ RBProtectInstanceVariableRefactoring
		model: aModel
		variable: varName
		class: aClass
]

{ #category : #accessing }
GtBehaviorUpdateForm >> protectVariable: varName [
	| aModel aClass |
	aModel := self createRefactoringModel.
	aClass := self modelClassFrom: aModel.

	^ RBProtectInstanceVariableRefactoring
		model: aModel
		variable: varName
		class: aClass
]

{ #category : #accessing }
GtBehaviorUpdateForm >> pushDownClassSlotRefactoringFor: varName [
	| aModel aClass |
	aModel := self createRefactoringModel.
	aClass := (self modelClassFrom: aModel) classSide.

	^ GtPushDownInstanceVariableRefactoring
		model: aModel
		variable: varName
		class: aClass
]

{ #category : #accessing }
GtBehaviorUpdateForm >> pushDownClassVariableRefactoringFor: varName [ 
	| aModel aClass |
	aModel := self createRefactoringModel.
	aClass := self modelClassFrom: aModel.

	^ RBPushDownClassVariableRefactoring
		model: aModel
		variable: varName
		class: aClass
]

{ #category : #accessing }
GtBehaviorUpdateForm >> pushDownSlotRefactoringFor: varName [
	| aModel aClass |
	aModel := self createRefactoringModel.
	aClass := self modelClassFrom: aModel.

	^ GtPushDownInstanceVariableRefactoring
		model: aModel
		variable: varName
		class: aClass
]

{ #category : #accessing }
GtBehaviorUpdateForm >> pushUpClassSlotRefactoringFor: varName [
	| aModel aClass |
	aModel := self createRefactoringModel.
	aClass := (self modelClassFrom: aModel) classSide.

	^ RBPullUpInstanceVariableRefactoring
		model: aModel
		variable: varName
		class: aClass superclass
]

{ #category : #accessing }
GtBehaviorUpdateForm >> pushUpClassVariableRefactoringFor: varName [ 
	| aModel aClass |
	aModel := self createRefactoringModel.
	aClass := self modelClassFrom: aModel.

	^ RBPullUpClassVariableRefactoring
		model: aModel
		variable: varName
		class: aClass superclass
]

{ #category : #accessing }
GtBehaviorUpdateForm >> pushUpSlotRefactoringFor: varName [
	| aModel aClass |
	aModel := self createRefactoringModel.
	aClass := self modelClassFrom: aModel.

	^ RBPullUpInstanceVariableRefactoring
		model: aModel
		variable: varName
		class: aClass superclass
]

{ #category : #accessing }
GtBehaviorUpdateForm >> slotsDescription [
	<magritteDescription>
	^ super slotsDescription
		blocListStencil: (self
				taggerStencilWithCompletion: nil
				contextMenuContentBlock: [ :aVariable :anElement :aMemento | 
					(aMemento overallStatus valueOrNil ifNotNil: #isChanged ifNil: [ true ])
						ifTrue: [ GtCoderContextMenuContent new editorElement: anElement ]
						ifFalse: [ self createSlotsContextMenuContentFor: aVariable editor: anElement ] ]
				contextMenuBlock: [ :aSlotName :anElement :aMemento | 
					self class environment
						at: self rawClassName asSymbol
						ifPresent: [ :aClass | 
							(aClass slotNamed: aSlotName) ifNotNil: [ :aSlot |
								GtCoderVariableTarget 
									menuItemsForObject: aSlot 
									hostElement: anElement ] ]
						ifAbsent: [ nil ] ]);
		blocShortcuts: [ {BlShortcutWithAction new
					name: 'Inspect slot';
					description: 'Inspect the slot indicated by the editor';
					combination: BlKeyCombination primaryG;
					action: [ :anEvent | 
						anEvent target phlow
							spawnObject: (self newClassName asString asClass slotNamed: anEvent target text asString) ].
				BlShortcutWithAction new
					name: 'Browse slot references';
					description: 'Browses references to the slot indicated by the editor';
					combination: BlKeyCombination primaryN;
					action: [ :anEvent | 
						anEvent currentTarget phlow
							spawnObject: (GtSearchInstanceSlotReferenceFilter
									forClassAndSubclasses: self newClassName asString asClass
									andVariable: anEvent target text asString) ]} ];
		addCondition: [ :aValue | aValue noneSatisfy: [ :aSlot | superSlots includes: aSlot ] ]
			labelled: 'Slot names are already taken in superclass'
]

{ #category : #accessing }
GtBehaviorUpdateForm >> superSlots [
	^ superSlots
]

{ #category : #accessing }
GtBehaviorUpdateForm >> superSlots: anObject [
	superSlots := anObject
]

{ #category : #accessing }
GtBehaviorUpdateForm >> textualCoderViewModel [
	"Hack to use context menus"
	^self
]

{ #category : #accessing }
GtBehaviorUpdateForm >> updateClassSlotsOn: aClass [
	| updateRefactoring |
	updateRefactoring := self createUpdateClassSlotsRefactoringOn: aClass.
	updateRefactoring changes isEmpty ifTrue: [ ^ self ].
	
	^ updateRefactoring gtExecuteWithUndo
]
