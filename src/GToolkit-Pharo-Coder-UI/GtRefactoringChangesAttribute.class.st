Class {
	#name : #GtRefactoringChangesAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#instVars : [
		'refactoringsBlock',
		'completionAction',
		'cancelAction',
		'showWhenCreated',
		'focusAction',
		'refactoringsViewModelDo'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings'
}

{ #category : #'private - attributes' }
GtRefactoringChangesAttribute >> cancelAction: aBlock [
	cancelAction := aBlock 
]

{ #category : #initialization }
GtRefactoringChangesAttribute >> completionAction: aBlock [
	"Action that is called when refactoring is complete"

	completionAction := aBlock
]

{ #category : #initialization }
GtRefactoringChangesAttribute >> configureWith: aRefactoringsConfiguration [
	aRefactoringsConfiguration cancelAction
		ifNotNil: [ :aBlock | self cancelAction: aBlock ].
	aRefactoringsConfiguration completionAction
		ifNotNil: [ :aBlock | self completionAction: aBlock ].
	aRefactoringsConfiguration focusAction
		ifNotNil: [ :aBlock | self focusAction: aBlock ].
	aRefactoringsConfiguration refactoringsBlock
		ifNotNil: [ :aBlock | self refactoringsBlock: aBlock ].
	aRefactoringsConfiguration refactoringsViewModelDo
		ifNotNil: [ :aBlock | self refactoringsViewModelDo: aBlock ].
	aRefactoringsConfiguration showWhenCreated
		ifNotNil: [ :aBoolean | self showWhenCreated: aBoolean ]
]

{ #category : #'private - updating' }
GtRefactoringChangesAttribute >> createRefactoringsViewModel [
	^ GtRefactoringsViewModel new
		refactorings: (refactoringsBlock ifNil: [ [ {} ] ]);
		yourself
]

{ #category : #accessing }
GtRefactoringChangesAttribute >> doAffect: aTBrTextEditorTextualPiece in: anEditorElement [
	| refactoringsViewModel button |
	refactoringsViewModel := self createRefactoringsViewModel.
	refactoringsViewModel
		afterAppliedBlock: [ completionAction notNil
				ifTrue: [ BlTaskAction
						enqueueElement: anEditorElement
						action: [ completionAction
								cull: (GtRefactoringsAppliedEvent new
										refactorings: (refactoringsViewModel
												ifComputedRefactorings: [ :_ :someRefactorings | someRefactorings ]
												ifNotComputed: [ #() ]
												ifInProgress: [ #() ]
												ifFailed: [ #() ]
												ifDisabled: [ #() ])) ] ] ].
	refactoringsViewModelDo
		ifNotNil: [ :aBlock | aBlock value: refactoringsViewModel ].
	button := self previewButtonClass new.

	button refactoringsViewModel: refactoringsViewModel.
	button
		previewContentDo: [ :anElement :aRefactoringsViewModel | 
			anElement hFitContentLimited.
			focusAction
				ifNotNil: [ :anAction | 
					anAction
						cull: anElement
						cull: self
						cull: aRefactoringsViewModel ] ].

	button
		padding: (BlInsets
				top: 1
				right: 4
				bottom: 0
				left: 4).
	button cancelBlock: cancelAction.
	button beMiniSize.
	showWhenCreated
		ifTrue: [ BlTaskAction enqueueElement: button action: [ button showPreview ] ].
	^ button
]

{ #category : #accessing }
GtRefactoringChangesAttribute >> focusAction [
	^ focusAction
]

{ #category : #accessing }
GtRefactoringChangesAttribute >> focusAction: anObject [
	focusAction := anObject
]

{ #category : #initialization }
GtRefactoringChangesAttribute >> initialize [
	super initialize.
	self beAppend.
	self beNotOverwritableByStyler.
	showWhenCreated := false
]

{ #category : #accessing }
GtRefactoringChangesAttribute >> previewButtonClass [
	^ GtRefactoringsInDropdownPreviewElement
]

{ #category : #accessing }
GtRefactoringChangesAttribute >> refactoring: aRBRefactoring [
	refactoringsBlock := [ { aRBRefactoring } ]
]

{ #category : #accessing }
GtRefactoringChangesAttribute >> refactoringBlock: aBlock [
	"Block returns one refactoring"

	refactoringsBlock := [ {aBlock value} ]
]

{ #category : #accessing }
GtRefactoringChangesAttribute >> refactorings: aCollectionOfRBRefactoring [
	refactoringsBlock := [ aCollectionOfRBRefactoring ]
]

{ #category : #accessing }
GtRefactoringChangesAttribute >> refactoringsBlock [
	"Block returns one refactoring"

	^ refactoringsBlock
]

{ #category : #accessing }
GtRefactoringChangesAttribute >> refactoringsBlock: aBlock [
	"Block returns a collection of refactorings"

	refactoringsBlock := aBlock
]

{ #category : #accessing }
GtRefactoringChangesAttribute >> refactoringsViewModelDo [
	^ refactoringsViewModelDo
]

{ #category : #accessing }
GtRefactoringChangesAttribute >> refactoringsViewModelDo: aBlock [
	"Configure refactorings view model, e.g., set title.
	The block receives one argument [ :aRefactoringsViewModelDo | ]."

	refactoringsViewModelDo := aBlock
]

{ #category : #accessing }
GtRefactoringChangesAttribute >> showWhenCreated [
	^ showWhenCreated
]

{ #category : #accessing }
GtRefactoringChangesAttribute >> showWhenCreated: aBoolean [
	showWhenCreated := aBoolean
]
