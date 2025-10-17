Class {
	#name : #GtRefactoringChangesAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#instVars : [
		'refactoring',
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
	completionAction := aBlock
]

{ #category : #'private - updating' }
GtRefactoringChangesAttribute >> createRefactoringsViewModel [
	^ GtRefactoringsViewModel new
		refactorings: [ self refactorings ];
		yourself
]

{ #category : #accessing }
GtRefactoringChangesAttribute >> doAffect: aTBrTextEditorTextualPiece in: anEditorElement [
	| refactoringsViewModel button |
	refactoringsViewModel := self createRefactoringsViewModel.
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
	button
		when: GtRefactoringsAppliedEvent
		do: [ :event | completionAction notNil ifTrue: [ completionAction cull: event ] ].
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
GtRefactoringChangesAttribute >> refactoring [
	^ refactoring
]

{ #category : #accessing }
GtRefactoringChangesAttribute >> refactoring: aRBRefactoring [
	refactoring := aRBRefactoring
]

{ #category : #accessing }
GtRefactoringChangesAttribute >> refactorings [
	^ {refactoring}
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
