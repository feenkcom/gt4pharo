Class {
	#name : #GtRefactoringChangesAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#instVars : [
		'refactoring',
		'completionAction',
		'cancelAction'
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

{ #category : #accessing }
GtRefactoringChangesAttribute >> doAffect: aTBrTextEditorTextualPiece in: anEditorElement [
	^ GtRefactoringsPreviewButton new
		vMatchParent;
		refactorings: [ {refactoring} ];
		padding: (BlInsets
				top: 1
				right: 4
				bottom: 0
				left: 4);
		cancelBlock: cancelAction;
		beMiniSize;
		when: GtRefactoringsAppliedEvent
			do: [ :event | completionAction notNil ifTrue: [ completionAction cull: event ] ]
]

{ #category : #initialization }
GtRefactoringChangesAttribute >> initialize [
	super initialize.
	self beAppend.
	self beNotOverwritableByStyler
]

{ #category : #accessing }
GtRefactoringChangesAttribute >> refactoring: aRBRefactoring [
	refactoring := aRBRefactoring
]
