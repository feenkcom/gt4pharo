Class {
	#name : #GtPharoMethodChangedSelectorIndicatorElement,
	#superclass : #GtPharoMethodModificationIndicatorElement,
	#instVars : [
		'labelElement',
		'descriptionElement'
	],
	#category : #'GToolkit-Pharo-Coder-Method-UI-Support - Modification UI'
}

{ #category : #initialization }
GtPharoMethodChangedSelectorIndicatorElement >> defaultLayout [
	^ BlLinearLayout horizontal
]

{ #category : #initialization }
GtPharoMethodChangedSelectorIndicatorElement >> initialize [
	super initialize.
	self initializeLabelElement.
	self initializeDescriptionElement.

	self addChild: labelElement as: #behavior.
	self addChild: descriptionElement as: #description.
	self alignBottomLeft
]

{ #category : #initialization }
GtPharoMethodChangedSelectorIndicatorElement >> initializeDescriptionElement [
	descriptionElement := BrLabel new
			aptitude: (BrGlamorousLabelAptitude new glamorousRegularSmallSize);
			fitContent
]

{ #category : #initialization }
GtPharoMethodChangedSelectorIndicatorElement >> initializeLabelElement [
	labelElement := BrLabel new
			aptitude: BrGlamorousLabelAptitude new glamorousCodeFont;
			fitContent
]

{ #category : #'private - event handling' }
GtPharoMethodChangedSelectorIndicatorElement >> onClick [
	self save
]

{ #category : #'api - method modification indicator' }
GtPharoMethodChangedSelectorIndicatorElement >> onMethodModificationIndicatorChanged [
	super onMethodModificationIndicatorChanged.

	self updateElement
]

{ #category : #'private - updating' }
GtPharoMethodChangedSelectorIndicatorElement >> updateDescriptionElement [
	methodModificationIndicator compiledMethodThatWillChange
		ifNil: [ descriptionElement text: '' ]
		ifNotNil: [ :aMethod | 
			descriptionElement
				text: ('already defines {1}' format: {aMethod selector}) asRopedText ]
]

{ #category : #'private - updating' }
GtPharoMethodChangedSelectorIndicatorElement >> updateElement [
	self updateLabelElement.
	self updateDescriptionElement
]

{ #category : #'private - updating' }
GtPharoMethodChangedSelectorIndicatorElement >> updateLabelElement [
	labelElement text: methodModificationIndicator behaviorName
]
