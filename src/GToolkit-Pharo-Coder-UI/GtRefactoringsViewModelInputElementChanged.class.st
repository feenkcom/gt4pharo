Class {
	#name : #GtRefactoringsViewModelInputElementChanged,
	#superclass : #GtRefactoringsViewModelAnnouncement,
	#instVars : [
		'inputElementStencil'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New - Rest'
}

{ #category : #accessing }
GtRefactoringsViewModelInputElementChanged >> inputElement [
	<return: #BlElement or: nil>
	^ self refactoringsViewModel inputElement
]

{ #category : #accessing }
GtRefactoringsViewModelInputElementChanged >> inputElementStencil [
	<return: #GtRefactoringsInputWidgetStencilBuilder>
	^ inputElementStencil
]

{ #category : #accessing }
GtRefactoringsViewModelInputElementChanged >> inputElementStencil: aStencilBuilder [
	inputElementStencil := aStencilBuilder
]
