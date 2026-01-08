Class {
	#name : #GtPharoMethodModificationIndicatorElement,
	#superclass : #BlElement,
	#traits : 'TBrLayoutAlignable + TBrLayoutResizable + TGtPharoWithMethodModificationIndicator + TGtWithPharoMethodCoderViewModel',
	#classTraits : 'TBrLayoutAlignable classTrait + TBrLayoutResizable classTrait + TGtPharoWithMethodModificationIndicator classTrait + TGtWithPharoMethodCoderViewModel classTrait',
	#category : #'GToolkit-Pharo-Coder-Method-UI-Support - Modification UI'
}

{ #category : #initialization }
GtPharoMethodModificationIndicatorElement >> initialize [
	super initialize.

	self hMatchParent.
	self vFitContent.
	self alignCenterLeft.

	self
		viewModel: (BrButtonModel new
				action: [ :aButtonElement :aButtonModel :anEvent | self onClick ]).

	self
		aptitude: BrGlamorousButtonFlatExteriorAptitude + BrGlamorousButtonRectangularAptitude
]

{ #category : #'private - event handling' }
GtPharoMethodModificationIndicatorElement >> onClick [
	"Subclasses may act on click"

	
]

{ #category : #actions }
GtPharoMethodModificationIndicatorElement >> save [
	pharoMethodCoderViewModel ifNil: [ ^ self ].
	methodModificationIndicator ifNil: [ ^ self ].

	pharoMethodCoderViewModel saveIn: methodModificationIndicator behavior.
	self dispatchEvent: BrDropdownHideWish new
]
