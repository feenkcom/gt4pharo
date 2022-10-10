Extension { #name : #GtClassVariablesDefinition }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtClassVariablesDefinition >> classVariablesEditor [
	<return: #GtCodeDefinitionViewer>
	^ GtCodeDefinitionPluralEditor new
		definition: self;
		title: 'Class vars';
		addSelector: #addClassVariableNamed:;
		removeSelector: #removeClassVariableNamed:;
		renameSelector: #renameClassVariableNamed:to:;
		renameRefactoringBlock: [ :from :to | 
			RBRenameClassVariableRefactoring
				rename: from
				to: to
				in: (Smalltalk at: self topMostParent name) ];
		getSelector: #names;
		modelSelector: #classVariableNamed:;
		contextMenuBlock: [ :defn :editor | [ self createContextMenuContentFor: defn editor: editor ] ];
		addEvent: GtBehaviorClassVariableAdded;
		removeEvent: GtBehaviorClassVariableRemoved;
		renameEvent: GtBehaviorClassVariableRenamed;
		whenKey: BlKeyCombination primaryG
			do: [ :anEvent :aDefinition | aDefinition inspectFrom: anEvent ];
		whenKey: BlKeyCombination primaryB
			do: [ :anEvent :aDefinition | aDefinition browseFrom: anEvent ];
		whenKey: BlKeyCombination primaryN
			do: [ :anEvent :aDefinition | aDefinition browseReferencesFrom: anEvent ];
		whenKey: BlKeyCombination primaryC
			do: [ :anEvent :aDefinition | Clipboard clipboardText: aDefinition name asString ];
		whenPrimaryClickDo: [ :anEvent :aDefinition | aDefinition browseFrom: anEvent ];
		containerName: self class classVariablesEditorName
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtClassVariablesDefinition >> editors [
	^ { self classVariablesEditor }
]
