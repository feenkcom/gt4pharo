Trait {
	#name : #TGtRefactoringsPopoverElement,
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New'
}

{ #category : #'api - initialization' }
TGtRefactoringsPopoverElement >> beContextMenuElement [
	"The element is part of a popover, e.g., context menu.
	Make the element defaults."
	
	self padding: (BlInsets all: GtRefactoringsConstants contextMenuPadding).
	self hExact: GtRefactoringsConstants contextMenuWidth.
	self vFitContentLimited
]

{ #category : #'api - initialization' }
TGtRefactoringsPopoverElement >> bePinnable: anExplicitMenu [
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
TGtRefactoringsPopoverElement >> onClosePinnedElement: anAnnouncement [
	BlTaskAction enqueueElement: self action: [ self removeFromParent ]
]
