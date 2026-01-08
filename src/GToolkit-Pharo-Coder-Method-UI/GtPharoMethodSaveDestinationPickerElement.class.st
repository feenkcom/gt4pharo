Class {
	#name : #GtPharoMethodSaveDestinationPickerElement,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable + TGtWithPharoMethodCoderViewModel',
	#classTraits : 'TBrLayoutResizable classTrait + TGtWithPharoMethodCoderViewModel classTrait',
	#instVars : [
		'labelElement',
		'listElement'
	],
	#category : #'GToolkit-Pharo-Coder-Method-UI-Support - Modification UI'
}

{ #category : #initialization }
GtPharoMethodSaveDestinationPickerElement >> defaultLayout [
	^ BlLinearLayout vertical
]

{ #category : #initialization }
GtPharoMethodSaveDestinationPickerElement >> initialize [
	super initialize.
	self initializeLabelElement.
	self initializeListElement.

	self addChild: labelElement as: #question.
	self addChild: listElement as: #options.
	
	self addAptitude: (BrLayoutResizerAptitude new
		hCommon: labelElement;
		common: listElement).

	labelElement padding: (BlInsets left: 5 right: 5).
	listElement margin: (BlInsets top: 5).
	self padding: (BlInsets top: 5 bottom: 5).
	
	self fitContent.
]

{ #category : #initialization }
GtPharoMethodSaveDestinationPickerElement >> initializeLabelElement [
	labelElement := BrLabel new
			fitContent;
			aptitude: BrGlamorousLabelAptitude new;
			text: 'Where should it be saved?'
]

{ #category : #initialization }
GtPharoMethodSaveDestinationPickerElement >> initializeListElement [
	listElement := BrSimpleList new
			fitContent;
			itemType: [ :anItemTypeFactory :anItemObject :anItemIndex | anItemObject listItemElementClass ];
			itemStencil: [ :anElementClass :aListWidget | 
				anElementClass new
					padding: (BlInsets left: 5 right: 5) ];
			itemDataBinder: [ :eachElement :eachMethodIndicator :eachIndex | 
				eachElement
					id: (GtPharoMethodModificationIndicatorElementId indexed: eachIndex);
					pharoMethodCoderViewModel: self pharoMethodCoderViewModel;
					methodModificationIndicator: eachMethodIndicator ]
]

{ #category : #'api - pharo method coder view model' }
GtPharoMethodSaveDestinationPickerElement >> onPharoMethodCoderViewModelChanged [
	self updateElement
]

{ #category : #'private - updating' }
GtPharoMethodSaveDestinationPickerElement >> updateElement [
	| aStream |
	aStream := self pharoMethodCoderViewModel
			availableCompilationMethodIndicatorsWithBehaviorSources.
	listElement stream: aStream
]
