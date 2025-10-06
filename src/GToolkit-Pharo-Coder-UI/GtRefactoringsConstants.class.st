Class {
	#name : #GtRefactoringsConstants,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New - Rest'
}

{ #category : #initialization }
GtRefactoringsConstants class >> collapsedPreviewHeight [
	"21.86 is a height of a collapsed preview of collapsed refactoring changes.
	The reason is for this constant is, 
	that we want the preview button to be at the same place as the apply changes button.
	
	Ideally, we would prefil the preview element with a dummy change
	and make it hidden. In other words, this is a hack."

	^ 21.86
]

{ #category : #constants }
GtRefactoringsConstants class >> contextMenuPadding [
	^ 5
]

{ #category : #constants }
GtRefactoringsConstants class >> contextMenuWidth [
	^ 350
]

{ #category : #initialization }
GtRefactoringsConstants class >> futureExecutionConfiguration [
	^ AsyncFutureExecutionConfiguration new
		customGroup: #CodeChange;
		highPriority
]

{ #category : #constants }
GtRefactoringsConstants class >> spaceBetweenComposedElements [
	^ 5
]
