Class {
	#name : #GtPharoRemoveMethodPreviewStencil,
	#superclass : #BrStencil,
	#instVars : [
		'selectorToRemove',
		'isEmptyMethod',
		'anElement'
	],
	#category : #'GToolkit-Pharo-Coder-Method-Coder'
}

{ #category : #accessing }
GtPharoRemoveMethodPreviewStencil >> anElement [
	^ anElement
]

{ #category : #accessing }
GtPharoRemoveMethodPreviewStencil >> anElement: anObject [
	^ anElement := anObject
]

{ #category : #accessing }
GtPharoRemoveMethodPreviewStencil >> isEmptyMethod [
	^ isEmptyMethod
]

{ #category : #accessing }
GtPharoRemoveMethodPreviewStencil >> isEmptyMethod: anObject [
	^ isEmptyMethod := anObject
]

{ #category : #accessing }
GtPharoRemoveMethodPreviewStencil >> selectorToRemove [
	^ selectorToRemove
]

{ #category : #accessing }
GtPharoRemoveMethodPreviewStencil >> selectorToRemove: anObject [
	^ selectorToRemove := anObject
]
