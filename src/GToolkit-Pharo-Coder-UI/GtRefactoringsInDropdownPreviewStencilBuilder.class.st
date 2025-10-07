Class {
	#name : #GtRefactoringsInDropdownPreviewStencilBuilder,
	#superclass : #BrStencilBuilder,
	#instVars : [
		'refactoringsViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New - Rest'
}

{ #category : #'api - instantiation' }
GtRefactoringsInDropdownPreviewStencilBuilder >> buildDefault [
	<return: #BrStencil or: #BlElement>
	^ self refactoringsViewModel
		ifNotNil: #asPreviewElement
		ifNil: [ GtRefactoringsPreviewElement new ]
]

{ #category : #'api - instantiation' }
GtRefactoringsInDropdownPreviewStencilBuilder >> paramsOn: aStencilExecutor [
	super paramsOn: aStencilExecutor.
	aStencilExecutor push: self refactoringsViewModel
]

{ #category : #accessing }
GtRefactoringsInDropdownPreviewStencilBuilder >> refactoringsViewModel [
	^ refactoringsViewModel
]

{ #category : #accessing }
GtRefactoringsInDropdownPreviewStencilBuilder >> refactoringsViewModel: anObject [
	refactoringsViewModel := anObject
]

{ #category : #initialization }
GtRefactoringsInDropdownPreviewStencilBuilder >> reset [
	"Is called after the #build to de-reference dynamic parameters passed
	by the called of the build"
	super reset.
	refactoringsViewModel := nil
]
