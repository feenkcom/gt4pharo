Class {
	#name : #GtPharoMethodSaveConfirmationElement,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable + TGtWithPharoMethodCoderViewModel',
	#classTraits : 'TBrLayoutResizable classTrait + TGtWithPharoMethodCoderViewModel classTrait',
	#instVars : [
		'pickerElement',
		'questionElement'
	],
	#category : #'GToolkit-Pharo-Coder-Method-UI-Support - Modification UI'
}

{ #category : #initialization }
GtPharoMethodSaveConfirmationElement >> defaultLayout [
	^ BlLinearLayout vertical
]

{ #category : #initialization }
GtPharoMethodSaveConfirmationElement >> initialize [
	super initialize.
	self initializePickerElement.
	self initializeQuestionElement.
	self initializeSink.

	self addAptitude: (BrLayoutResizerAptitude new
		common: pickerElement;
		common: questionElement).

	self fitContent
]

{ #category : #initialization }
GtPharoMethodSaveConfirmationElement >> initializePickerElement [
	pickerElement := GtPharoMethodSaveDestinationPickerElement new
]

{ #category : #initialization }
GtPharoMethodSaveConfirmationElement >> initializeQuestionElement [
	questionElement := GtPharoMethodSaveExistingQuestionElement new
]

{ #category : #initialization }
GtPharoMethodSaveConfirmationElement >> initializeSink [
	self
		withAsyncSinkDo: [ :anElementSink | 
			anElementSink
				sink: AsyncCounterSink new;
				whenUpdate: [ :anElement :aSink | self updateElementForIndicatorCount: aSink count ] ]
]

{ #category : #'api - pharo method coder view model' }
GtPharoMethodSaveConfirmationElement >> onPharoMethodCoderViewModelChanged [
	pickerElement pharoMethodCoderViewModel: self pharoMethodCoderViewModel.
	questionElement pharoMethodCoderViewModel: self pharoMethodCoderViewModel.

	self updateElement
]

{ #category : #'private - updating' }
GtPharoMethodSaveConfirmationElement >> updateElement [
	| aStream |
	aStream := self pharoMethodCoderViewModel
			availableCompilationMethodIndicatorsWithBehaviorSources.
	self asyncSink forwardStream: aStream
]

{ #category : #'private - updating' }
GtPharoMethodSaveConfirmationElement >> updateElementForIndicatorCount: aCount [
	aCount = 1
		ifTrue: [ 
			pickerElement removeFromParent.
			questionElement parent == self ifFalse: [
				self addChild: questionElement as: #question ] ]
		ifFalse: [ 
			questionElement removeFromParent.
			pickerElement parent == self ifFalse: [
				self addChild: pickerElement as: #picker ] ]
]
