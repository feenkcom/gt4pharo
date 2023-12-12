Class {
	#name : #GtBehaviorUpdateForm,
	#superclass : #GtClassCreationForm,
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
GtBehaviorUpdateForm >> classSlotsDescription [
	<magritteDescription>
	^ super classSlotsDescription
		blocListStencil: (self
				taggerStencilWithCompletion: nil
				andContextMenuBlock: [ :aVariable :anElement :aMemento | 
					aMemento overallStatus valueOrNil isChanged
						ifTrue: [ GtCoderContextMenuContent new editorElement: anElement ]
						ifFalse: [ self createClassSlotsContextMenuContentFor: aVariable editor: anElement ] ]);
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
				andContextMenuBlock: [ :aVariable :anElement :aMemento | self createClassVarsContextMenuContentFor: aVariable editor: anElement ]);
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
					action: [ :form :elem | self browseReferencesToSlot: aSlotName in: elem ];
					title: (self createLabelTextFor: 'Browse references' description: aSlotName).
				GtCoderContextMenuAction new
					action: [ self executeRefactoring: (self pushUpClassSlotRefactoringFor: aSlotName) ];
					title: (self createLabelTextFor: 'Push up' description: aSlotName).
				GtCoderContextMenuAction new
					action: [ self executeRefactoring: (self pushDownClassSlotRefactoringFor: aSlotName) ];
					title: (self createLabelTextFor: 'Push down' description: aSlotName).
				GtCoderContextMenuAction new
					action: [ self
							executeRefactoring: (self generateClassAccessorsFor: aSlotName asClassVar: false) ];
					title: (self createLabelTextFor: 'Create accessors' description: aSlotName).
				GtCoderContextMenuAction new
					action: [ self executeRefactoring: (self abstractClassVariable: aSlotName) ];
					title: (self createLabelTextFor: 'Abstract' description: aSlotName).
				GtCoderContextMenuAction new
					action: [ self executeRefactoring: (self protectClassVariable: aSlotName) ];
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
							executeRefactoring: (self pushUpClassVariableRefactoringFor: aClassVarName) ];
					title: (self createLabelTextFor: 'Push up' description: aClassVarName).
				GtCoderContextMenuAction new
					action: [ self
							executeRefactoring: (self pushDownClassVariableRefactoringFor: aClassVarName) ];
					title: (self createLabelTextFor: 'Push down' description: aClassVarName).
				GtCoderContextMenuAction new
					action: [ self
							executeRefactoring: (self generateAccessorsFor: aClassVarName asClassVar: true) ];
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
	^ RBClassModelFactory rbNamespace onEnvironment: RBBrowserEnvironment new
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
					action: [ self executeRefactoring: (self pushUpSlotRefactoringFor: aSlotName) ];
					title: (self createLabelTextFor: 'Push up' description: aSlotName).
				GtCoderContextMenuAction new
					action: [ self executeRefactoring: (self pushDownSlotRefactoringFor: aSlotName) ];
					title: (self createLabelTextFor: 'Push down' description: aSlotName).
				GtCoderContextMenuAction new
					action: [ self
							executeRefactoring: (self generateAccessorsFor: aSlotName asClassVar: false) ];
					title: (self createLabelTextFor: 'Create accessors' description: aSlotName).
				GtCoderContextMenuAction new
					action: [ self executeRefactoring: (self abstractVariable: aSlotName) ];
					title: (self createLabelTextFor: 'Abstract' description: aSlotName).
				GtCoderContextMenuAction new
					action: [ self executeRefactoring: (self protectVariable: aSlotName) ];
					title: (self createLabelTextFor: 'Protect' description: aSlotName)}.
	theContextMenu items: items.
	^ theContextMenu
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

	^ RBPushDownInstanceVariableRefactoring
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

	^ RBPushDownInstanceVariableRefactoring
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
				andContextMenuBlock: [ :aVariable :anElement :aMemento | 
					aMemento overallStatus valueOrNil isChanged
						ifTrue: [ GtCoderContextMenuContent new editorElement: anElement ]
						ifFalse: [ self createSlotsContextMenuContentFor: aVariable editor: anElement ] ]);
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
									andVariable: anEvent target text asString) ]} ]
]

{ #category : #accessing }
GtBehaviorUpdateForm >> textualCoderViewModel [
	"Hack to use context menus"
	^self
]
