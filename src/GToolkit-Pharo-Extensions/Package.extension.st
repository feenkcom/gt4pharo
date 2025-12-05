Extension { #name : #Package }

{ #category : #'*GToolkit-Pharo-Extensions' }
Package >> gtBrowseActionFor: anAction [
	<gtAction>
	^ anAction button
		target: GtCoderPackageTarget;
		icon: BrGlamorousVectorIcons empty;
		label: 'Browse package';
		menuItemPreview: [ self name ];
		menuItemGroup: BrMenuItemGroupConfiguration navigation;
		action: [ :aMenuElement | aMenuElement phlow spawnObject: self ]
]

{ #category : #'*GToolkit-Pharo-Extensions' }
Package >> gtCreateNewPackageOrPackageTagActionFor: anAction [
	<gtAction>
	^ anAction dropdown
		target: GtCoderPackageTarget;
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
Package >> gtGitActionFor: anAction [
	<gtAction>
	
	^ anAction button
		priority: 7;
		id: GtCoderGitButtonId;
		target: GtCoderPackageTarget;
		icon: BrGlamorousVectorIcons branching;
		label: 'Browse git repository';
		menuItemPreview: self name;
		menuItemGroup: BrMenuItemGroupConfiguration default;
		action: [ :aButton | 
			aButton phlow spawnTool: (GtGitPhlowTool new 
				repository: self repository) ];
		primaryModifierAction: [ :aButton | 
			BlSpace new
				withCommonSettings;
				inPager: [ GtGitPhlowTool new 
					repository: self repository ];
				title: 'Git';
				icon: BrGlamorousVectorIcons branching;
				showFrom: aButton ]
]

{ #category : #'*GToolkit-Pharo-Extensions' }
Package >> gtRemoveActionFor: anAction [
	<gtAction>
	^ anAction dropdown
		target: GtCoderPackageTarget;
		icon: BrGlamorousVectorIcons bin;
		label: 'Remove package';
		menuItemPreview: [ self name ];
		menuItemGroup: BrMenuItemGroupConfiguration removal;
		content: [ :aMenuElement :aHostElement :anExplicitMenu | 
			| labelText element change button |
			element := BrVerticalPane new fitContent.
			labelText := 'Remove package <1s>' expandMacrosWith: self name.
			element
				addChild: (BrLabel new
						aptitude: BrGlamorousLabelAptitude new glamorousRegularFont;
						text: labelText asRopedText;
						margin: (BlInsets
								top: 10
								bottom: 0
								left: 10
								right: 10)).
			element
				addChild: (BrAsyncWidget new
						fitContent;
						stencil: [ | pane definedClasses extendedClasses |
							pane := BrVerticalPane new.
							pane fitContent.
							definedClasses := self definedClassNames size.
							extendedClasses := self extendedClassNames size.
							definedClasses > 0
								ifTrue: [ pane
										addChild: (BrLabel new
												margin: (BlInsets left: 10 right: 10);
												aptitude: BrGlamorousLabelAptitude new glamorousRegularFont thin;
												text: (definedClasses printString , ' defined class'
														, (definedClasses > 1 ifTrue: [ 'es' ] ifFalse: [ '' ]))
														asRopedText) ].
							extendedClasses > 0
								ifTrue: [ pane
										addChild: (BrLabel new
												margin: (BlInsets left: 10 right: 10);
												aptitude: BrGlamorousLabelAptitude new glamorousRegularFont thin;
												text: (extendedClasses printString , ' extended class'
														, (extendedClasses > 1 ifTrue: [ 'es' ] ifFalse: [ '' ]))
														asRopedText) ].
							pane ]).
			change := RBRemovePackageChange removePackageNamed: self name.
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
Package >> gtRenameActionFor: anAction [
	<gtAction>
	^ anAction dropdown
		target: GtCoderPackageTarget;
		icon: BrGlamorousVectorIcons empty;
		label: 'Rename package';
		menuItemPreview: [ self name ];
		menuItemPinSubmenu;
		menuItemGroup: BrMenuItemGroupConfiguration refactoring;
		content: [ :aMenuElement :aHostElement :anExplicitMenu | 
			| aViewModel |
			anExplicitMenu id: #'coder--context-menu-rename-package-form'.

			aViewModel := GtRefactoringsWithInputViewModel new
					refactoringTitle: 'Rename package';
					targetName: self name;
					inputLabel: 'New package name:';
					initialText: self name;
					refactoringWithInput: [ :anInput | GtRBRenamePackageRefactoring from: self name to: anInput ];
					afterAppliedBlock: [ BlTaskAction enqueueElement: aMenuElement action: [ anExplicitMenu hideAll ] ];
					menuModel: anExplicitMenu;
					anchorElement: aHostElement.
			GtRefactoringsPreviewWithInputElement new
				refactoringsViewModel: aViewModel;
				beContextMenuElement;
				bePinnable: anExplicitMenu ]
]

{ #category : #'*GToolkit-Pharo-Extensions' }
Package >> packageManifestOrNil [
	"Avoid using #definedClasses to create a list of classes only to
	select then the one representing the manifest. The manifest is use 
	to check if the package is deprecated, which in turn can slow down checking
	if class is deprecated.
	Related issue: https://github.com/feenkcom/gtoolkit/issues/4369"
	<gtPharoPatch: #Pharo>
	
	^ self 
		forPharo12AndNewer: [ 
			self definedClasses
				detect: [ :each | each isManifest ]
				ifNone: [ nil ] ] 
		forPharo11: [
			self gtDefinedClassesWithPossibleDuplicatesDo: [:aClass|
				aClass  isManifest ifTrue: [ ^ aClass ] ].
			nil]
]
