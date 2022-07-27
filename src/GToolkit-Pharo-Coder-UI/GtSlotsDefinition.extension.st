Extension { #name : #GtSlotsDefinition }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSlotsDefinition >> createContextMenuContentFor: aDefinition editor: anElement [
	| theContextMenu items |
	theContextMenu := GtCoderContextMenuContent new editorElement: anElement.
	items := OrderedCollection new.
	items
		addAll: {GtCoderContextMenuAction new
					action: [ :element | (self pushUpSlotRefactoringFor: aDefinition name) execute ];
					title: 'Push Up ' , aDefinition name.
				GtCoderContextMenuAction new
					action: [ :element | (self pushDownSlotRefactoringFor: aDefinition name) execute ];
					title: 'Push Down ' , aDefinition name.
				GtCoderContextMenuAction new
					action: [ :element | (self generateAccessorsFor: aDefinition name) execute ];
					title: 'Create accessors for ' , aDefinition name}.
	theContextMenu items: items.
	^ theContextMenu
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSlotsDefinition >> createRefactoringModel [
	^ RBClassModelFactory rbNamespace onEnvironment: RBBrowserEnvironment new
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSlotsDefinition >> editors [
	^ { self slotsEditor }
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSlotsDefinition >> generateAccessorsFor: varName [
	| aModel aClass |
	aModel := self createRefactoringModel.
	aClass := aModel classNamed: self definition topMostParent name.

	^ RBCreateAccessorsForVariableRefactoring
		model: aModel
		variable: varName
		class: (aClass whoDefinesInstanceVariable: varName)
		classVariable: false
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSlotsDefinition >> pushDownSlotRefactoringFor: varName [ 
	| aModel aClass |
	aModel := self createRefactoringModel.
	aClass := aModel classNamed: self definition topMostParent name.

	^ RBPushDownInstanceVariableRefactoring
		model: aModel
		variable: varName
		class:aClass
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSlotsDefinition >> pushUpSlotRefactoringFor: varName [
	| aModel aClass |
	aModel := self createRefactoringModel.
	aClass := aModel classNamed: self definition topMostParent name.

	^ RBPullUpInstanceVariableRefactoring
		model: aModel
		variable: varName
		class: aClass superclass
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSlotsDefinition >> slotsEditor [
	<return: #GtCodeDefinitionViewer>
	^ GtCodeDefinitionPluralEditor new
		title: self title;
		definition: self;
		addSelector: #addSlotNamed:;
		removeSelector: #removeSlotNamed:;
		renameSelector: #renameSlotNamed:to:;
		getSelector: #names;
		modelSelector: #slotNamed:;
		contextMenuBlock: [ :defn :editor | [ self createContextMenuContentFor: defn editor: editor ] ];
		addEvent: GtBehaviorSlotAdded;
		removeEvent: GtBehaviorSlotRemoved;
		renameEvent: GtBehaviorSlotRenamed;
		whenKey: BlKeyCombination primaryG
			do: [ :anEvent :aDefinition | aDefinition inspectFrom: anEvent ];
		whenKey: BlKeyCombination primaryB
			do: [ :anEvent :aDefinition | aDefinition browseFrom: anEvent ];
		whenKey: BlKeyCombination primaryN
			do: [ :anEvent :aDefinition | aDefinition browseReferencesFrom: anEvent ];
		whenKey: BlKeyCombination primaryC
			do: [ :anEvent :aDefinition | Clipboard clipboardText: aDefinition name asString ];
		whenPrimaryClickDo: [ :anEvent :aDefinition | aDefinition browseFrom: anEvent ];
		containerName: self class slotsEditorName
]
