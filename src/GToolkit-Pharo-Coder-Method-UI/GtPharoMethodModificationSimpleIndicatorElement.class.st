Class {
	#name : #GtPharoMethodModificationSimpleIndicatorElement,
	#superclass : #BrButton,
	#traits : 'TGtPharoWithMethodModificationIndicator + TGtWithPharoMethodCoderViewModel',
	#classTraits : 'TGtPharoWithMethodModificationIndicator classTrait + TGtWithPharoMethodCoderViewModel classTrait',
	#category : #'GToolkit-Pharo-Coder-Method-UI-Support - Modification UI'
}

{ #category : #initialization }
GtPharoMethodModificationSimpleIndicatorElement >> initialize [
	super initialize.

	self hMatchParent.
	self vFitContent.
	self alignCenterLeft.
	self action: [ :aButton | self onClick ].

	self
		aptitude: BrGlamorousButtonFlatExteriorAptitude
				+ BrGlamorousLabelAptitude new glamorousCodeFont
				+ BrGlamorousButtonRectangularAptitude
]

{ #category : #initialization }
GtPharoMethodModificationSimpleIndicatorElement >> onClick [
	pharoMethodCoderViewModel ifNil: [ ^ self ].
	methodModificationIndicator ifNil: [ ^ self ].

	pharoMethodCoderViewModel saveIn: methodModificationIndicator behavior.
	self dispatchEvent: BrDropdownHideWish new
]

{ #category : #'api - method modification indicator' }
GtPharoMethodModificationSimpleIndicatorElement >> onMethodModificationIndicatorChanged [
	self updateElement
]

{ #category : #'api - method modification indicator' }
GtPharoMethodModificationSimpleIndicatorElement >> updateElement [
	self label: self methodModificationIndicator behaviorName asString
]
