Class {
	#name : #GtPharoRenameSelectorKeywordEditorAttributeStencilBuilder,
	#superclass : #BrStencilBuilder,
	#instVars : [
		'selectorModel',
		'keywordModel'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #'api - instantiation' }
GtPharoRenameSelectorKeywordEditorAttributeStencilBuilder >> buildDefault [
	^ GtPharoRenameSelectorKeywordEditorAttribute new
		keywordModel: self keywordModel
]

{ #category : #accessing }
GtPharoRenameSelectorKeywordEditorAttributeStencilBuilder >> keywordModel [
	^ keywordModel
]

{ #category : #accessing }
GtPharoRenameSelectorKeywordEditorAttributeStencilBuilder >> keywordModel: anObject [
	keywordModel := anObject
]

{ #category : #'api - instantiation' }
GtPharoRenameSelectorKeywordEditorAttributeStencilBuilder >> paramsOn: aStencilExecutor [
	super paramsOn: aStencilExecutor.
	aStencilExecutor
		push: self keywordModel;
		push: self selectorModel
]

{ #category : #initialization }
GtPharoRenameSelectorKeywordEditorAttributeStencilBuilder >> reset [
	keywordModel := nil.
	selectorModel := nil
]

{ #category : #accessing }
GtPharoRenameSelectorKeywordEditorAttributeStencilBuilder >> selectorModel [
	^ selectorModel
]

{ #category : #accessing }
GtPharoRenameSelectorKeywordEditorAttributeStencilBuilder >> selectorModel: anObject [
	selectorModel := anObject
]
