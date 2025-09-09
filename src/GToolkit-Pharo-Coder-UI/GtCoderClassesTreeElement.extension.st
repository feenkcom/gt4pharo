Extension { #name : #GtCoderClassesTreeElement }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtCoderClassesTreeElement >> convertToSiblingSubmenuFor: aClass siblings: aCollection [
	| submenu |
	submenu := BrMenuExplicit new.
	submenu
		id: #'coder--context-menu-convert-to-sibling-form';
		stencil: [ :anExplicitMenu | 
			| aViewModel anInputElement |
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
					beforeApplyBlock: [ submenu hideAll ].
			anInputElement := GtRefactoringsInputElement new
					refactoringsViewModel: aViewModel;
					hExact: 350;
					margin: (BlInsets all: 5).

			(GtRefactoringsWithInputPreviewElement
				elementForRefactoringInputElement: anInputElement
				from: self
				beforeApplyingDo: [ submenu hideAll ])
				in: [ :aMenuElement | 
					aMenuElement
						when: GtRefactoringsAboutToApplyEvent
						do: [ :anEvent | anInputElement disableEditing ] ];
				background: anInputElement theme default contentBackground;
				addAptitude: (BrGlamorousPopoverPinnableAptitude new
						withPostEndPinBlock: [ :aContext | 
							aContext menuElement
								when: GtRefactoringsAppliedEvent
									do: [ :anEvent | 
										| aMenuElement |
										aMenuElement := anEvent currentTarget.
										BlTaskAction
											enqueueElement: aMenuElement
											action: [ anInputElement enableEditing.
												aMenuElement removeFromParent ] ];
								when: GtRefactoringsFailedEvent
									do: [ :anEvent | 
										| aMenuElement |
										aMenuElement := anEvent currentTarget.
										BlTaskAction
											enqueueElement: aMenuElement
											action: [ anInputElement enableEditing ] ].
							BlTaskAction
								enqueueElement: anInputElement
								action: [ anInputElement focusTarget ] ];
						withResizers;
						withAllPinActions;
						menuModel: anExplicitMenu) ].
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
