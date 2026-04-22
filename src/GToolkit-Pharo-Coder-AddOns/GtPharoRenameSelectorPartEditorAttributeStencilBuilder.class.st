Class {
	#name : #GtPharoRenameSelectorPartEditorAttributeStencilBuilder,
	#superclass : #BrStencilBuilder,
	#instVars : [
		'selectorModel',
		'selectorPartModel'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #'api - instantiation' }
GtPharoRenameSelectorPartEditorAttributeStencilBuilder >> buildDefault [
	^ GtPharoRenameSelectorPartEditorAttribute new
		selectorPartModel: self selectorPartModel
]

{ #category : #'api - instantiation' }
GtPharoRenameSelectorPartEditorAttributeStencilBuilder >> paramsOn: aStencilExecutor [
	super paramsOn: aStencilExecutor.
	aStencilExecutor
		push: self selectorPartModel;
		push: self selectorModel
]

{ #category : #initialization }
GtPharoRenameSelectorPartEditorAttributeStencilBuilder >> reset [
	selectorPartModel := nil.
	selectorModel := nil
]

{ #category : #accessing }
GtPharoRenameSelectorPartEditorAttributeStencilBuilder >> selectorModel [
	^ selectorModel
]

{ #category : #accessing }
GtPharoRenameSelectorPartEditorAttributeStencilBuilder >> selectorModel: anObject [
	selectorModel := anObject
]

{ #category : #accessing }
GtPharoRenameSelectorPartEditorAttributeStencilBuilder >> selectorPartModel [
	^ selectorPartModel
]

{ #category : #accessing }
GtPharoRenameSelectorPartEditorAttributeStencilBuilder >> selectorPartModel: anObject [
	selectorPartModel := anObject
]
