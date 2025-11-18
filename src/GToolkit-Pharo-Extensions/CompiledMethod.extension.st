Extension { #name : #CompiledMethod }

{ #category : #'*GToolkit-Pharo-Extensions' }
CompiledMethod >> gtAllInnerCompiledBlocksDo: aBlock [
	self innerCompiledBlocksDo: [ :anInnerBlock |
		anInnerBlock gtAllInnerCompiledBlocksDo: aBlock ]
]

{ #category : #'*GToolkit-Pharo-Extensions' }
CompiledMethod >> gtBrowseHierarchyImplementorsActionFor: anAction [
	<gtAction>
	^ anAction button
		priority: 4;
		target: GtCoderMethodTarget;
		icon: BrGlamorousVectorIcons empty;
		label: 'Browse hierarchy implementors';
		menuItemPreview: self selector;
		menuItemGroup: BrMenuItemGroupConfiguration navigation;
		action: [ :aButton | aButton phlow spawnObject: (self selector gtImplementors & self gtHierarchyFilter) ]
]

{ #category : #'*GToolkit-Pharo-Extensions' }
CompiledMethod >> gtBrowseHierarchyReferencesActionFor: anAction [
	<gtAction>
	^ anAction button
		priority: 8;
		target: GtCoderMethodTarget;
		icon: BrGlamorousVectorIcons empty;
		label: 'Browse hierarchy references';
		menuItemPreview: self selector;
		menuItemGroup: BrMenuItemGroupConfiguration navigation;
		action: [ :aButton | aButton phlow spawnObject: (self selector gtSenders & self gtHierarchyFilter) ]
]

{ #category : #'*GToolkit-Pharo-Extensions' }
CompiledMethod >> gtBrowseImplementorsActionFor: anAction [
	<gtAction>
	^ anAction button
		priority: 2;
		target: GtCoderMethodTarget;
		icon: BrGlamorousVectorIcons empty;
		label: 'Browse implementors';
		menuItemPreview: self selector;
		menuItemGroup: BrMenuItemGroupConfiguration navigation;
		action: [ :aButton | aButton phlow spawnObject: (GtSearchImplementorsFilter selector: self selector) ]
]

{ #category : #'*GToolkit-Pharo-Extensions' }
CompiledMethod >> gtBrowseReferencesActionFor: anAction [
	<gtAction>
	^ anAction button
		priority: 6;
		target: GtCoderMethodTarget;
		icon: BrGlamorousVectorIcons empty;
		label: 'Browse references';
		menuItemPreview: self selector;
		menuItemGroup: BrMenuItemGroupConfiguration navigation;
		action: [ :aButton | aButton phlow spawnObject: (GtSearchReferencesFilter literal: self selector) ]
]

{ #category : #'*GToolkit-Pharo-Extensions' }
CompiledMethod >> gtHierarchyFilter [
	^ (GtSearchInheritedMethodsFilter forClass: self methodClass)
		withSuperclasses;
		withSubclasses
]

{ #category : #'*GToolkit-Pharo-Extensions' }
CompiledMethod >> gtPushDownMethodActionFor: anAction [
	<gtAction>
	self methodClass subclasses notEmpty ifFalse: [ ^ anAction noAction ].

	^ anAction dropdown
		priority: 12;
		target: GtCoderMethodTarget;
		icon: BrGlamorousVectorIcons empty;
		label: 'Push down method';
		menuItemPreview: self selector;
		menuItemGroup: BrMenuItemGroupConfiguration refactoring;
		menuItemPinSubmenu;
		content: [ :anActionElement :aTargetElement :anExplicitMenu | 
			| aViewModel |
			aViewModel := GtRefactoringsWithConfirmationViewModel new
					refactoringTitle: 'Push down';
					targetName: ('{1}>>#{2}'
							format: {self methodClass.
									self selector});
					confirmationLabel: ('Push down {1}' format: {self selector});
					refactoringWithConfirmation: [ GtRBPushDownMethodRefactoring
							pushDown: {self selector}
							from: (self
									forPharo12AndNewer: [ self methodClass name ]
									forPharo11: [ self methodClass ]) ];
					afterAppliedBlock: [ BlTaskAction
							enqueueElement: anActionElement
							action: [ anExplicitMenu hideAll ] ];
					menuModel: anExplicitMenu;
					anchorElement: self.
			GtRefactoringsPreviewWithConfirmationElement new
				refactoringsViewModel: aViewModel;
				beContextMenuElement;
				bePinnable: anExplicitMenu ]
]

{ #category : #'*GToolkit-Pharo-Extensions' }
CompiledMethod >> gtPushUpMethodActionFor: anAction [
	<gtAction>
	^ anAction dropdown
		priority: 10;
		target: GtCoderMethodTarget;
		icon: BrGlamorousVectorIcons empty;
		label: 'Push up method';
		menuItemPreview: self selector;
		menuItemGroup: BrMenuItemGroupConfiguration refactoring;
		menuItemPinSubmenu;
		content: [ :anActionElement :aTargetElement :anExplicitMenu | 
			| aViewModel |
			aViewModel := GtRefactoringsWithConfirmationViewModel new
					refactoringTitle: 'Push up';
					targetName: ('{1}>>#{2}'
							format: {self methodClass.
									self selector});
					confirmationLabel: ('Push up {1}' format: {self selector});
					refactoringWithConfirmation: [ GtPushUpMethodRefactoring pullUp: {self selector} from: self methodClass ];
					afterAppliedBlock: [ BlTaskAction
							enqueueElement: anActionElement
							action: [ anExplicitMenu hideAll ] ];
					menuModel: anExplicitMenu;
					anchorElement: self.
			GtRefactoringsPreviewWithConfirmationElement new
				refactoringsViewModel: aViewModel;
				beContextMenuElement;
				bePinnable: anExplicitMenu ]
]

{ #category : #'*GToolkit-Pharo-Extensions' }
CompiledMethod >> gtRemoveMethodActionFor: anAction [
	<gtAction>
	^ anAction dropdown
		priority: 14;
		target: GtCoderMethodTarget;
		icon: BrGlamorousVectorIcons bin;
		label: 'Remove method';
		menuItemPreview: self selector;
		menuItemGroup: BrMenuItemGroupConfiguration removal;
		content: [ :anActionElement :aTargetElement :anExplicitMenu | 
			| element change button |
			element := BrVerticalPane new fitContent.
			element
				addChild: (BrLabel new
						margin: (BlInsets
								top: 10
								bottom: 0
								left: 10
								right: 10);
						aptitude: BrGlamorousLabelAptitude new glamorousRegularFont;
						text: ('Remove ' , self selector) asRopedText).
			element
				addChild: (BrAsyncWidget new
						fitContent;
						stencil: [ | pane references |
							pane := BrVerticalPane new.
							pane fitContent.
							references := (GtPharoIndex current sendersOf: self selector) size.
							references > 0
								ifTrue: [ pane
										addChild: (BrLabel new
												margin: (BlInsets left: 10 right: 10);
												aptitude: BrGlamorousLabelAptitude new glamorousRegularFont thin;
												text: (references printString , ' reference'
														, (references > 1 ifTrue: [ 's' ] ifFalse: [ '' ])) asRopedText) ].
							pane ]).
			change := RBRemoveMethodChange remove: self selector from: self methodClass.
			button := BrButton new
					aptitude: BrGlamorousButtonWithIconAptitude;
					beSmallSize;
					margin: (BlInsets
							top: 10
							bottom: 10
							left: 10
							right: 10);
					icon: BrGlamorousVectorIcons remove;
					label: 'Remove';
					action: [ change execute.
						anExplicitMenu hideAll ].
			element addChild: button as: #removeButton.
			element ]
]

{ #category : #'*GToolkit-Pharo-Extensions' }
CompiledMethod >> gtRenameMessageActionFor: anAction [
	<gtAction>
	^ anAction dropdown
		priority: 14;
		target: GtCoderMethodTarget;
		icon: BrGlamorousVectorIcons empty;
		label: 'Rename message';
		menuItemPreview: self selector;
		menuItemGroup: BrMenuItemGroupConfiguration refactoring;
		menuItemPinSubmenu;
		content: [ :anActionElement :aTargetElement :anExplicitMenu | 
			| aViewModel |
			aViewModel := GtRefactoringsWithInputViewModel new
					refactoringTitle: 'Rename method';
					targetName: ('{1}>>#{2}'
							format: {self methodClass.
									self selector});
					inputLabel: 'New method name:';
					initialText: self selector;
					refactoringWithInput: [ :anInput | 
						GtRBRenameMethodRefactoring
							renameMethod: self selector
							in: self methodClass
							to: anInput
							permutation: (1 to: self selector numArgs) ];
					afterAppliedBlock: [ BlTaskAction
							enqueueElement: anActionElement
							action: [ anExplicitMenu hideAll ] ];
					menuModel: anExplicitMenu;
					anchorElement: self.
			GtRefactoringsPreviewWithInputElement new
				refactoringsViewModel: aViewModel;
				beContextMenuElement;
				bePinnable: anExplicitMenu ]
]
