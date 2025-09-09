Extension { #name : #GtCoderClassesTreeElement }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtCoderClassesTreeElement >> convertToSiblingSubmenuFor: aClass siblings: aCollection [
	| submenu |
	submenu := BrMenuExplicit new.
	submenu
		id: #'coder--context-menu-convert-to-sibling-form';
		stencil: [ :anExplicitMenu | 
			| aViewModel anElement |
			aViewModel := GtRefactoringsViewModel new
					inputLabel: 'Superclass: ';
					initialText: 'NewClass';
					refactoringBlock: [ :anInput | 
						GtChildrenToSiblingsRefactoring
							name: anInput
							class: aClass
							subclasses: aCollection ];
					beforeApplyBlock: [ submenu hideAll ].
			anElement := GtRefactoringsInputElement new
					refactoringsViewModel: aViewModel;
					hExact: 350;
					margin: (BlInsets all: 5).

			(GtRefactoringsWithInputPreviewElement
				elementForRefactoringInputElement: anElement
				from: self
				beforeApplyingDo: [ submenu hideAll ])
				background: anElement theme default contentBackground;
				addAptitude: (BrGlamorousPopoverPinnableAptitude new
						withPostEndPinBlock: [ :aContext | 
							aContext menuElement
								when: GtRefactoringsAppliedEvent
								do: [ :anEvent | 
									| aMenuElement |
									aMenuElement := anEvent currentTarget.
									BlTaskAction
										enqueueElement: aMenuElement
										action: [ aMenuElement removeFromParent ] ].
							BlTaskAction enqueueElement: anElement action: [ anElement focusTarget ] ];
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
