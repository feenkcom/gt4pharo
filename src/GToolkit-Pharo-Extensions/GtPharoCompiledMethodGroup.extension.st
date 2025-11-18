Extension { #name : #GtPharoCompiledMethodGroup }

{ #category : #'*GToolkit-Pharo-Extensions' }
GtPharoCompiledMethodGroup >> gtBrowseHierarchyImplementorsActionFor: anAction [
	<gtAction>
	^ anAction button
		priority: 12;
		target: GtCoderMethodsTarget;
		icon: BrGlamorousVectorIcons empty;
		label: 'Browse hierarchy implementors';
		menuItemPreview: ('{1} methods' format: {self size});
		menuItemGroup: BrMenuItemGroupConfiguration navigation;
		action: [ :aButton | 
			| aFilter |
			aFilter := self allButFirst
					inject: self first gtImplementors & (self gtHierarchyFilterFor: self first)
					into: [ :filter :compiledMethod | filter | (compiledMethod gtImplementors & (self gtHierarchyFilterFor: compiledMethod)) ].

			aButton phlow spawnObject: aFilter ]
]

{ #category : #'*GToolkit-Pharo-Extensions' }
GtPharoCompiledMethodGroup >> gtBrowseHierarchyReferencesActionFor: anAction [
	<gtAction>
	^ anAction button
		priority: 16;
		target: GtCoderMethodsTarget;
		icon: BrGlamorousVectorIcons empty;
		label: 'Browse hierarchy references';
		menuItemPreview: ('{1} methods' format: {self size});
		menuItemGroup: BrMenuItemGroupConfiguration navigation;
		action: [ :aButton | 
			| aFilter |
			aFilter := self allButFirst
					inject: self first gtSenders & (self gtHierarchyFilterFor: self first)
					into: [ :filter :compiledMethod | 
						filter
							| (compiledMethod gtSenders & (self gtHierarchyFilterFor: compiledMethod)) ].

			aButton phlow spawnObject: aFilter ]
]

{ #category : #'*GToolkit-Pharo-Extensions' }
GtPharoCompiledMethodGroup >> gtBrowseImplementorsActionFor: anAction [
	<gtAction>
	^ anAction button
		priority: 10;
		target: GtCoderMethodsTarget;
		icon: BrGlamorousVectorIcons empty;
		label: 'Browse implementors';
		menuItemPreview: ('{1} methods' format: {self size});
		menuItemGroup: BrMenuItemGroupConfiguration navigation;
		action: [ :aButton | 
			| aFilter |
			aFilter := self allButFirst
					inject: (GtSearchImplementorsFilter selector: self first)
					into: [ :filter :symbol | filter | (GtSearchImplementorsFilter selector: symbol) ].
			aButton phlow spawnObject: aFilter ]
]

{ #category : #'*GToolkit-Pharo-Extensions' }
GtPharoCompiledMethodGroup >> gtBrowseReferencesActionFor: anAction [
	<gtAction>
	^ anAction button
		priority: 14;
		target: GtCoderMethodsTarget;
		icon: BrGlamorousVectorIcons empty;
		label: 'Browse references';
		menuItemPreview: ('{1} methods' format: {self size});
		menuItemGroup: BrMenuItemGroupConfiguration navigation;
		action: [ :aButton | 
			| aFilter |
			aFilter := self allButFirst
					inject: (GtSearchReferencesFilter literal: self first selector)
					into: [ :filter :compiledMethod | filter | (GtSearchReferencesFilter literal: compiledMethod selector) ].

			aButton phlow spawnObject: aFilter ]
]

{ #category : #'*GToolkit-Pharo-Extensions' }
GtPharoCompiledMethodGroup >> gtCompareMethodsAsFilterActionFor: anAction [
	<gtAction>
	self size = 2 ifFalse: [ ^ anAction noAction ].
	^ anAction button
		priority: 2;
		target: GtCoderMethodsTarget;
		icon: BrGlamorousVectorIcons empty;
		label: 'Compare methods';
		menuItemPreview: ('{1} methods' format: {self size});
		menuItemGroup: BrMenuItemGroupConfiguration navigation;
		action: [ :b | b phlow spawnObject: (GtRGMethodDefinitionWithComparisonGroup withAll: self) ]
]

{ #category : #'*GToolkit-Pharo-Extensions' }
GtPharoCompiledMethodGroup >> gtHierarchyFilterFor: aCompiledMethod [
	(GtSearchInheritedMethodsFilter forClass: aCompiledMethod selectedClass)
		withSuperclasses;
		withSubclasses
]

{ #category : #'*GToolkit-Pharo-Extensions' }
GtPharoCompiledMethodGroup >> gtInspectMethodsAsFilterActionFor: anAction [
	<gtAction>
	^ anAction button
		priority: 2;
		target: GtCoderMethodsTarget;
		icon: BrGlamorousVectorIcons empty;
		label: 'Inspect methods as filter';
		menuItemPreview: ('{1} methods' format: {self size});
		menuItemGroup: BrMenuItemGroupConfiguration navigation;
		action: [ :b | b phlow spawnObject: (GtSearchFixedMethodsFilter new methods: self) ]
]

{ #category : #'*GToolkit-Pharo-Extensions' }
GtPharoCompiledMethodGroup >> gtPushDownMethodsActionFor: anAction [
	<gtAction>
	(self allSatisfy: [ :eachMethod | eachMethod methodClass subclasses notEmpty ])
		ifFalse: [ ^ anAction noAction ].

	^ anAction dropdown
		priority: 22;
		target: GtCoderMethodsTarget;
		icon: BrGlamorousVectorIcons empty;
		label: 'Push down methods';
		menuItemPreview: ('{1} methods' format: {self size});
		menuItemGroup: BrMenuItemGroupConfiguration refactoring;
		menuItemPinSubmenu;
		content: [ :anActionElement :aTargetElement :anExplicitMenu | 
			| aViewModel |
			aViewModel := GtRefactoringsWithConfirmationViewModel new
					refactoringTitle: 'Push down';
					targetName: ('{1} methods' format: {self size});
					confirmationLabel: ('Push down {1} methods' format: {self size});
					refactoringsWithConfirmation: [ | aGroupByClass aModel aCollectionOfRefactorings |
						aGroupByClass := self groupedBy: #methodClass.
						aModel := Smalltalk createRbNamespace
								onEnvironment: GtRBPushDownMethodRefactoring new defaultEnvironment.
						aCollectionOfRefactorings := aGroupByClass
								collect: [ :someMethods | 
									GtRBPushDownMethodRefactoring new
										model: aModel;
										pushDown: (someMethods collect: #selector)
											from: (self
													forPharo12AndNewer: [ someMethods anyOne methodClass name ]
													forPharo11: [ someMethods anyOne methodClass ]) ]
								as: Array.
						aModel name: ('Push down {1} methods' format: {self size}).
						aCollectionOfRefactorings ];
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
GtPharoCompiledMethodGroup >> gtPushUpMethodsActionFor: anAction [
	<gtAction>
	^ anAction dropdown
		priority: 20;
		target: GtCoderMethodsTarget;
		icon: BrGlamorousVectorIcons empty;
		label: 'Push up methods';
		menuItemPreview: ('{1} methods' format: {self size});
		menuItemGroup: BrMenuItemGroupConfiguration refactoring;
		menuItemPinSubmenu;
		content: [ :anActionElement :aTargetElement :anExplicitMenu | 
			| aViewModel |
			aViewModel := GtRefactoringsWithConfirmationViewModel new
					refactoringTitle: 'Push up';
					targetName: ('{1} methods' format: {self size});
					confirmationLabel: ('Push up {1} methods' format: {self size});
					refactoringsWithConfirmation: [ | aGroupByClass aModel aCollectionOfRefactorings |
						aGroupByClass := self groupedBy: #methodClass.
						aModel := Smalltalk createRbNamespace
								onEnvironment: GtPushUpMethodRefactoring new defaultEnvironment.
						aCollectionOfRefactorings := aGroupByClass
								collect: [ :someMethods | 
									GtPushUpMethodRefactoring new
										model: aModel;
										pullUp: (someMethods collect: #selector)
											from: someMethods anyOne methodClass ]
								as: Array.
						aModel name: ('Push up {1} methods' format: {self size}).
						aCollectionOfRefactorings ];
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
GtPharoCompiledMethodGroup >> gtRemoveMethodsActionFor: anAction [
	<gtAction>
	^ anAction dropdown
		priority: 100;
		target: GtCoderMethodsTarget;
		icon: BrGlamorousVectorIcons bin;
		label: 'Remove methods';
		menuItemPreview: ('{1} methods' format: {self size});
		menuItemGroup: BrMenuItemGroupConfiguration removal;
		menuItemPinSubmenu;
		content: [ :aButton :aTargetElement :anExplicitMenu | 
			self
				removeSeveralMethodsSubmenuFor: self
				explicitMenu: anExplicitMenu
				element: aButton ]
]

{ #category : #'*GToolkit-Pharo-Extensions' }
GtPharoCompiledMethodGroup >> removeSeveralMethodsSubmenuFor: aCollection explicitMenu: anExplicitMenu element: anElement [
	| element changes change button |
	element := BrVerticalPane new fitContent.
	element
		addChild: (BrLabel new
				margin: (BlInsets
						top: 10
						bottom: 0
						left: 10
						right: 10);
				aptitude: BrGlamorousLabelAptitude new glamorousRegularFont;
				text: ('Remove {1} methods' format: {aCollection size}) asRopedText).
	element
		addChild: (BrAsyncWidget new
				fitContent;
				stencil: [ | pane references |
					pane := BrVerticalPane new.
					pane fitContent.
					references := aCollection
							inject: 0
							into: [ :sum :method1 | sum + (GtPharoIndex current sendersOf: method1 selector) size ].
					references > 0
						ifTrue: [ pane
								addChild: (BrLabel new
										margin: (BlInsets left: 10 right: 10);
										aptitude: BrGlamorousLabelAptitude new glamorousRegularFont thin;
										text: (references printString , ' reference'
												, (references > 1 ifTrue: [ 's' ] ifFalse: [ '' ])) asRopedText) ].
					pane ]).
	changes := aCollection
			collect: [ :eachMethod | RBRemoveMethodChange remove: eachMethod selector from: eachMethod methodClass ].
	change := RBCompositeRefactoryChange new
			name: ('Remove {1} methods' format: {aCollection size});
			changes: changes;
			yourself.
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
	^ element
]
