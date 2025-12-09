Extension { #name : #PackageTag }

{ #category : #'*GToolkit-Pharo-Extensions' }
PackageTag >> gtBrowseActionFor: anAction [
	<gtAction>
	^ anAction button
		target: GtCoderPackageTagTarget;
		icon: BrGlamorousVectorIcons browse;
		label: 'Browse package tag';
		menuItemPreview: [ self name ];
		menuItemGroup: BrMenuItemGroupConfiguration navigation;
		action: [ :aMenuElement | aMenuElement phlow spawnObject: self ];
		primaryModifierAction: [ :aMenuElement | self gtBrowseFrom: aMenuElement ]
]

{ #category : #'*GToolkit-Pharo-Extensions' }
PackageTag >> gtCreateNewPackageOrPackageTagActionFor: anAction [
	<gtAction>
	^ anAction dropdown
		target: GtCoderPackageTagTarget;
		icon: BrGlamorousVectorIcons add;
		label: 'New package / tag';
		menuItemGroup: BrMenuItemGroupConfiguration modification;
		content: [ :aMenuElement :aHostElement :anExplicitMenu | 
			| aChild |
			aChild := aMenuElement phlow
					firstParentCoderNavigationModelIfPresent: [ :aNavigationModel | 
						(GtCoderNavigationTabsStencil new
							pragmaName: #gtCoderDropdownNavigation;
							navigationModel: aNavigationModel;
							gtCreationInterface: aMenuElement)
							ifNotNil: [ :aTabGroup | aTabGroup selectTabWithLabelString: GtPackageCreationForm componentName ] ]
					ifAbsent: [ BrLabel new
							aptitude: BrGlamorousLabelAptitude new;
							text: 'Currently not available from lepiter and method coder';
							constraintsDo: [ :c | 
								c linear horizontal alignCenter.
								c linear vertical alignCenter ] ].

			BrVerticalPane new
				exact: 400 @ 300;
				addChild: aChild;
				background: aMenuElement theme default contentBackground;
				addAptitude: (BrGlamorousPopoverPinnableAptitude new
						withLeftAndRightResizers;
						withAllPinActions;
						menuModel: anExplicitMenu) ]
]

{ #category : #'*GToolkit-Pharo-Extensions' }
PackageTag >> gtRemoveActionFor: anAction [
	<gtAction>
	^ anAction dropdown
		target: GtCoderPackageTagTarget;
		icon: BrGlamorousVectorIcons bin;
		label: 'Remove tag';
		menuItemPreview: [ self name ];
		menuItemGroup: BrMenuItemGroupConfiguration removal;
		content: [ :aMenuElement :aHostElement :anExplicitMenu | 
			| labelText element change button |
			element := BrVerticalPane new fitContent.
			labelText := 'Remove package tag <1s>' expandMacrosWith: self name.
			element
				addChild: (BrLabel new
						aptitude: BrGlamorousLabelAptitude new glamorousRegularFont;
						text: labelText asRopedText;
						margin: (BlInsets
								top: 10
								bottom: 0
								left: 10
								right: 10)).
			change := GtRBRemovePackageTagChange
					packageName: self package name
					tagName: self name.
			button := BrButton new
					aptitude: BrGlamorousButtonWithIconAptitude;
					beSmallSize;
					margin: (BlInsets
							top: 10
							bottom: 10
							left: 10
							right: 10);
					icon: BrGlamorousVectorIcons bin;
					label: 'Remove';
					action: [ change execute.
						anExplicitMenu hideAll ].
			element addChild: button as: #removeButton.
			element ]
]

{ #category : #'*GToolkit-Pharo-Extensions' }
PackageTag >> gtRenameActionFor: anAction [
	<gtAction>
	^ anAction dropdown
		target: GtCoderPackageTagTarget;
		icon: BrGlamorousVectorIcons empty;
		label: 'Rename tag';
		menuItemPreview: [ self name ];
		menuItemPinSubmenu;
		menuItemGroup: BrMenuItemGroupConfiguration refactoring;
		content: [ :aMenuElement :aHostElement  :anExplicitMenu | 
			| aViewModel |
			anExplicitMenu id: #'coder--context-menu-rename-package-tag-form'.

			aViewModel := GtRefactoringsWithInputViewModel new
					refactoringTitle: 'Rename package tag';
					targetName: self name;
					inputLabel: 'New package tag name:';
					initialText: self name;
					refactoringWithInput: [ :anInput | 
						GtRBRenamePackageTagRefactoring
							packageName: self packageName
							from: self name
							to: anInput ];
					afterAppliedBlock: [ BlTaskAction enqueueElement: aMenuElement action: [ anExplicitMenu hideAll ] ];
					menuModel: anExplicitMenu;
					anchorElement: aHostElement.
			GtRefactoringsPreviewWithInputElement new
				refactoringsViewModel: aViewModel;
				beContextMenuElement;
				bePinnable: anExplicitMenu  ]
]
