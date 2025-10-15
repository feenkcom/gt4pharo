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
Class >> gtCoderSidebarIndexCopyClassOrTraitFor: anAction [
	<gtAction>
	(self isTrait not and: [ self superclass isNil ])
		ifNil: [ ^ anAction noAction ].

	^ anAction dropdown
		priority: 8;
		id: GtPharoCopyClassElementId;
		target: GtCoderClassTarget;
		icon: BrGlamorousVectorIcons changes;
		label: ('Copy {1}' format: {self gtCoderTypeName});
		menuItemPreview: self name;
		menuItemGroup: BrMenuItemGroupConfiguration modification;
		menuItemPinSubmenu;
		content: [ :anActionElement :aHostElement :anExplicitMenu | 
			| aForm aFormElement |
			aForm := self isTrait
					ifTrue: [ GtCopyTraitForm for: self ]
					ifFalse: [ GtCopyClassForm for: self ].
			aForm
				onAccept: [ :newClass | 
					BlTaskAction
						enqueueElement: aHostElement
						action: [ aHostElement phlow spawnObject: newClass ] ].
			aFormElement := aForm asElement.
			BrFrame new
				fitContent;
				addChild: aFormElement;
				padding: (BlInsets all: 5);
				background: aFormElement theme default contentBackground;
				addAptitude: (BrLayoutResizerAptitude new
						exactToMatchParent: aFormElement;
						matchParentToMatchParent: aFormElement;
						fitContentToFitContent: aFormElement;
						fitContentLimitedToFitContentLimited: aFormElement);
				addAptitude: (BrGlamorousPopoverPinnableAptitude new
						withAllPinActions;
						menuModel: anExplicitMenu;
						withPostEndPinBlock: [ :aContext | 
							aForm
								onAccept: [ :newClass | 
									BlTaskAction
										enqueueElement: aHostElement
										action: [ aHostElement phlow spawnObject: newClass.
											BlTaskAction
												enqueueElement: aHostElement
												action: [ aContext menuElement removeFromParent ] ] ] ]) ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
Class >> gtCoderSidebarIndexExtractSuperclassFor: anAction [
	<gtAction>
	
	self isTrait ifTrue: [ ^ anAction noAction ].
	
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
