Class {
	#name : #GtPharoRemoveMethodPreviewStencil,
	#superclass : #GtAbstractRemovePreviewStencil,
	#instVars : [
		'selectorToRemove',
		'isEmptyMethod'
	],
	#category : #'GToolkit-Pharo-Coder-Method-UI-Utilities'
}

{ #category : #accessing }
GtPharoRemoveMethodPreviewStencil >> create [
	(self isEmptyMethod or: [ self selectorToRemove isNil ])
		ifTrue: [ ^ self noReferencesLabel ].
	^ self
		createPreviewContainerForItemNamed: self selectorToRemove
		withReferences: self selectorToRemove gtReferences
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
