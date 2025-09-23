Extension { #name : #Class }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
Class >> gtCoderSidebarIndexConvertToSiblingClassFor: anAction [
	<gtAction>
	self subclasses notEmpty ifFalse: [ ^ anAction noAction ].

	^ anAction dropdown 
		priority: 6;
		target: GtCoderClassTarget;
		id: #'coder--context-menu-convert-to-sibling';
		icon: BrGlamorousVectorIcons empty;
		label: 'Convert to sibling';
		menuItemPreview: self name;
		menuItemGroup: BrMenuItemGroupConfiguration refactoring;
		menuItemPinSubmenu;
		content: [ :anActionElement :aTargetElement :anExplicitMenu | 
			| aViewModel |
			anExplicitMenu id: #'coder--context-menu-convert-to-sibling-form'.
			
			aViewModel := GtRefactoringsWithInputViewModel new
					refactoringTitle: 'Convert to sibling';
					targetName: self name;
					inputLabel: 'Superclass:';
					initialText: 'NewClass';
					refactoringWithInput: [ :anInput | 
						GtChildrenToSiblingsRefactoring
							name: anInput
							class: self
							subclasses: self subclasses ];
					afterAppliedBlock: [ anExplicitMenu hideAll ];
					menuModel: anExplicitMenu;
					anchorElement: self.
			GtRefactoringsPreviewWithInputElement new
				refactoringsViewModel: aViewModel;
				beContextMenuElement;
				bePinnable: anExplicitMenu ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
Class >> gtCoderSidebarIndexConvertToSiblingClassFrom: aGtCoderClassesTreeElement [
	<gtCoderSidebarIndexOneSubjectContextMenuItem: 6>
	self subclasses notEmpty ifFalse: [ ^ nil ].

	^ BrMenuSubmenuItem new
		id: #'coder--context-menu-convert-to-sibling';
		icon: BrGlamorousVectorIcons empty
			label: 'Convert to sibling'
			preview: self name;
		submenu: (aGtCoderClassesTreeElement
				convertToSiblingSubmenuFor: self
				siblings: self subclasses
				title: 'Convert to sibling');
		bePinSubmenuAction
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
Class >> gtCoderSidebarIndexCopyClassOrTraitFor: anAction [
	<gtAction>
	self superclass ifNil: [ ^ anAction noAction ].
	
	^ anAction dropdown 
		priority: 8;
		target: GtCoderClassTarget;
		icon: BrGlamorousVectorIcons changes;
		label: (self isTrait ifTrue: [ 'Copy trait' ] ifFalse: [ 'Copy class' ]);
		menuItemPreview: self name;
		menuItemGroup: BrMenuItemGroupConfiguration default;
		menuItemPinSubmenu;
		content: [ :anActionElement :aHostElement :anExplicitMenu | 
			 self isTrait
				ifTrue: [ ((GtCopyTraitForm for: self)
						onAccept: [ :newClass | 
							BlTaskAction 
								enqueueElement: aHostElement 
								action:  [ aHostElement phlow spawnTool: (GtClassCoderTool forClass: newClass) ] ])
						asElement padding: (BlInsets all: 5) ]
				ifFalse: [ ((GtCopyClassForm for: self)
						onAccept: [ :newClass | 
							BlTaskAction 
								enqueueElement: aHostElement 
								action:  [ aHostElement phlow spawnTool: (GtClassCoderTool forClass: newClass) ] ])
						asElement padding: (BlInsets all: 5) ] 
	 ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
Class >> gtCoderSidebarIndexCopyClassOrTraitFrom: aGtCoderClassesTreeElement [
	<gtCoderSidebarIndexOneSubjectContextMenuItem: 8>
	self superclass ifNil: [ ^ nil ].
	
	^ BrMenuSubmenuItem new
		icon: BrGlamorousVectorIcons changes
			label: (self isTrait ifTrue: [ 'Copy trait' ] ifFalse: [ 'Copy class' ])
			preview: self name;
		submenu: (aGtCoderClassesTreeElement copyClassOrTraitSubmenuFor: self)
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
Class >> gtCoderSidebarIndexExtractSuperclassFor: anAction [
	<gtAction>
	
	^ anAction dropdown 
		priority: 7;
		target: GtCoderClassTarget;
		icon: BrGlamorousVectorIcons empty;
		label: 'Extract superclass';
		menuItemPreview: self name;
		menuItemGroup: BrMenuItemGroupConfiguration refactoring;
		menuItemPinSubmenu;
		content: [ :anActionElement :aTargetElement :anExplicitMenu | 
			| aViewModel |
			anExplicitMenu id: #'coder--context-menu-convert-to-sibling-form'.
			
			aViewModel := GtRefactoringsWithInputViewModel new
					refactoringTitle: 'Extract superclass';
					targetName: self name;
					inputLabel: 'Superclass:';
					initialText: 'NewClass';
					refactoringWithInput: [ :anInput | 
						GtChildrenToSiblingsRefactoring
							name: anInput
							class: self
							subclasses: #() ];
					afterAppliedBlock: [ anExplicitMenu hideAll ];
					menuModel: anExplicitMenu;
					anchorElement: self.
			GtRefactoringsPreviewWithInputElement new
				refactoringsViewModel: aViewModel;
				beContextMenuElement;
				bePinnable: anExplicitMenu ]
]
