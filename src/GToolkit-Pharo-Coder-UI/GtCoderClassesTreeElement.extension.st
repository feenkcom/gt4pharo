Extension { #name : #GtCoderClassesTreeElement }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtCoderClassesTreeElement >> convertToSiblingSubmenuFor: aClass siblings: aCollection [
	| submenu |
	submenu := BrMenuExplicit new.
	submenu
		id: #'coder--context-menu-convert-to-sibling-form';
		stencil: [ :anExplicitMenu | 
			| aViewModel |
			aViewModel := GtRefactoringsViewModel new
					refactoringTitle: 'Convert to sibling';
					targetName: aClass name;
					inputLabel: 'Superclass: ';
					initialText: 'NewClass';
					refactoringBlock: [ :anInput | 
						GtChildrenToSiblingsRefactoring
							name: anInput
							class: aClass
							subclasses: aCollection ];
					beforeApplyBlock: [ anExplicitMenu hideAll ];
					menuModel: anExplicitMenu;
					anchorElement: self.
			GtRefactoringsPreviewWithInputElement new 
				refactoringsViewModel: aViewModel ].
	^ submenu
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtCoderClassesTreeElement >> copyClassOrTraitSubmenuFor: aClass [
	| submenu |
	submenu := BrMenuExplicit new.
	submenu
		stencil: [ aClass isTrait
				ifTrue: [ ((GtCopyTraitForm for: aClass)
						onAccept: [ :newClass | 
							self
								inUIProcessDo: [ self phlow spawnTool: (GtClassCoderTool forClass: newClass) ] ])
						asElement padding: (BlInsets all: 5) ]
				ifFalse: [ ((GtCopyClassForm for: aClass)
						onAccept: [ :newClass | 
							self
								inUIProcessDo: [ self phlow spawnTool: (GtClassCoderTool forClass: newClass) ] ])
						asElement padding: (BlInsets all: 5) ] ].
	^ submenu
]
