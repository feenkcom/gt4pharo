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
				keywordsAndParametersDo: [ :eachKeyword :eachParameter | 
					self createKeywordAttributeFor: eachKeyword into: aStream.
					self createParameterAttributeFor: eachParameter into: aStream ] ]
]

{ #category : #private }
GtPharoRenameSelectorAttributesStencil >> createKeywordAttributeFor: aSelectorKeyword into: aStream [
	| anAttribute |
	anAttribute := GtPharoRenameSelectorKeywordEditorAttribute new
			keywordModel: aSelectorKeyword.

	aStream
		nextPut: {aSelectorKeyword originalInterval first.
				aSelectorKeyword originalInterval last.
				anAttribute}
]

{ #category : #private }
GtPharoRenameSelectorAttributesStencil >> createParameterAttributeFor: aSelectorParameter into: aStream [
	| anAttribute |
	anAttribute := GtPharoRenameSelectorParameterLabelAttribute new
			parameterModel: aSelectorParameter.

	aStream
		nextPut: {aSelectorParameter originalInterval first.
				aSelectorParameter originalInterval last.
				anAttribute}
]

{ #category : #'gt - extensions' }
GtPharoRenameSelectorAttributesStencil >> gtAttributesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Attributes';
		items: [ self create ];
		column: 'Range'
			text: [ :aCol | 
				'{1}..{2}'
					format: {aCol at: 1.
							aCol at: 2} ] width: 70;
		column: 'Attribute' text: [ :aCol | aCol at: 3 ];
		send: [ :aCol | aCol at: 3 ]
]

{ #category : #'gt - extensions' }
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
