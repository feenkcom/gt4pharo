Class {
	#name : #GtPharoRenameSelectorAttributesStencil,
	#superclass : #BrStencil,
	#instVars : [
		'selectorModel'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #'api - updating' }
GtPharoRenameSelectorAttributesStencil >> create [
	^ Array
		streamContents: [ :aStream | 
			selectorModel
				keywordsAndParametersDo: [ :eachKeyword :eachParameter | self createKeywordAttributeFor: eachKeyword into: aStream ] ]
]

{ #category : #private }
GtPharoRenameSelectorAttributesStencil >> createKeywordAttributeFor: aSelectorKeyword into: aStream [
	| anAttribute |
	anAttribute := GtPharoRenameSelectorKeywordEditorAttribute new
			keywordModel: aSelectorKeyword.

	aStream nextPut: anAttribute
]

{ #category : #'as yet unclassified' }
GtPharoRenameSelectorAttributesStencil >> gtLiveFor: aView [
	^ aView empty
]

{ #category : #accessing }
GtPharoRenameSelectorAttributesStencil >> selectorModel [
	^ selectorModel
]

{ #category : #accessing }
GtPharoRenameSelectorAttributesStencil >> selectorModel: anObject [
	selectorModel := anObject
]
