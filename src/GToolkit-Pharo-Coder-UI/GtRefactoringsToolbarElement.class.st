Class {
	#name : #GtRefactoringsToolbarElement,
	#superclass : #GtRefactoringsBasicElement,
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New'
}

{ #category : #'accessing - refactorings view model' }
GtRefactoringsToolbarElement >> onRefactoringsViewModelChanged [
	super onRefactoringsViewModelChanged.
	self updateElement.
]

{ #category : #'private - updating' }
GtRefactoringsToolbarElement >> updateElement [
]
