Trait {
	#name : #TGtRefactoringsPinnableElement,
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New'
}

{ #category : #'api - initialization' }
TGtRefactoringsPinnableElement >> bePinnable: anExplicitMenu [
	"The element is part of a popover, e.g., context menu.
	Make the element pinnable."

	self assert: self hasRefactoringsViewModel.

	self
		addAptitude: (BrGlamorousPopoverPinnableAptitude new
				withAllPinActions;
				withResizers;
				menuModel: anExplicitMenu;
				withPostEndPinBlock: [
					self refactoringsViewModel weak
						when: GtRefactoringsViewModelExecutedRefactoringsApplied
						send: #onClosePinnedElement:
						to: self ])
]

{ #category : #'private - event handling' }
TGtRefactoringsPinnableElement >> onClosePinnedElement: anAnnouncement [
	BlTaskAction enqueueElement: self action: [ self removeFromParent ]
]
