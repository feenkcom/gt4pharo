Class {
	#name : #GtRefactoringsInputWidgetStencilBuilder,
	#superclass : #BrStencilBuilder,
	#instVars : [
		'refactoringsViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New - Rest'
}

{ #category : #'api - instantiation' }
GtRefactoringsInputWidgetStencilBuilder >> buildDefault [
	<return: #BrStencil or: #BlElement>
	^ nil
]

{ #category : #'api - instantiation' }
GtRefactoringsInputWidgetStencilBuilder >> paramsOn: aStencilExecutor [
	super paramsOn: aStencilExecutor.
	aStencilExecutor push: self refactoringsViewModel
]

{ #category : #accessing }
GtRefactoringsInputWidgetStencilBuilder >> refactoringsViewModel [
	^ refactoringsViewModel
]

{ #category : #accessing }
GtRefactoringsInputWidgetStencilBuilder >> refactoringsViewModel: anObject [
	refactoringsViewModel := anObject
]

{ #category : #initialization }
GtRefactoringsInputWidgetStencilBuilder >> reset [
	"Is called after the #build to de-reference dynamic parameters passed
	by the called of the build"
	super reset.
	refactoringsViewModel := nil
]
