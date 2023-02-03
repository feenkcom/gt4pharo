Extension { #name : #GtSlotsDefinition }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSlotsDefinition >> abstractVariable: varName [
	| aModel aClass |
	aModel := self createRefactoringModel.
	aClass := self modelClassFrom: aModel.

	^ RBAbstractInstanceVariableRefactoring
		model: aModel
		variable: varName
		class: aClass
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSlotsDefinition >> createContextMenuContentFor: aDefinition editor: anElement [
	| theContextMenu items |
	theContextMenu := GtCoderContextMenuContent new editorElement: anElement.
	items := OrderedCollection new.
	items
		addAll: {GtCoderContextMenuAction new
					action: [ self executeRefactoring: (self pushUpSlotRefactoringFor: aDefinition name) ];
					title: (self createLabelTextFor: 'Push up ' description: aDefinition name).
				GtCoderContextMenuAction new
					action: [ self executeRefactoring: (self pushDownSlotRefactoringFor: aDefinition name) ];
					title: (self createLabelTextFor: 'Push down ' description: aDefinition name).
				GtCoderContextMenuAction new
					action: [ self executeRefactoring: (self generateAccessorsFor: aDefinition name) ];
					title: (self createLabelTextFor: 'Create accessors for ' description: aDefinition name).
				GtCoderContextMenuAction new
					action: [ self executeRefactoring: (self abstractVariable: aDefinition name) ];
					title: (self createLabelTextFor: 'Abstract ' description: aDefinition name).
				GtCoderContextMenuAction new
					action: [ self executeRefactoring: (self protectVariable: aDefinition name) ];
					title: (self createLabelTextFor: 'Protect ' description: aDefinition name)}.
	theContextMenu items: items.
	^ theContextMenu
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSlotsDefinition >> createLabelTextFor: aString description: description [
	^ aString asRopedText glamorousRegularFont
		, ((' ' , description) asRopedText
				glamorousCodeFont;
				foreground: Color gray;
				glamorousCodeTinySize)
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSlotsDefinition >> editors [
	^ { self slotsEditor }
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSlotsDefinition >> modelClassFrom: aModel [
	^ aModel classNamed: self definition topMostParent name
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSlotsDefinition >> protectVariable: varName [
	| aModel aClass |
	aModel := self createRefactoringModel.
	aClass := self modelClassFrom: aModel.

	^ RBProtectInstanceVariableRefactoring
		model: aModel
		variable: varName
		class: aClass
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSlotsDefinition >> pushDownSlotRefactoringFor: varName [
	| aModel aClass |
	aModel := self createRefactoringModel.
	aClass := self modelClassFrom: aModel.

	^ RBPushDownInstanceVariableRefactoring
		model: aModel
		variable: varName
		class: aClass
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSlotsDefinition >> pushUpSlotRefactoringFor: varName [
	| aModel aClass |
	aModel := self createRefactoringModel.
	aClass := self modelClassFrom: aModel.

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
		renameRefactoringBlock: [ :from :to | 
			| class |
			class := Smalltalk at: self parent name.
			self parent isForMetaclass ifTrue: [ class := class class ].
			RBRenameInstanceVariableRefactoring
				rename: from
				to: to
				in: class ];
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
