Class {
	#name : #Gt2PharoPackageClassNavigationElement,
	#superclass : #BrHorizontalPane,
	#traits : 'TGt2WithPharoClassNavigationViewModel',
	#classTraits : 'TGt2WithPharoClassNavigationViewModel classTrait',
	#instVars : [
		'classNameLabel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - Views'
}

{ #category : #initialization }
Gt2PharoPackageClassNavigationElement >> createNameLabel [
	^ BrLabel new
		aptitude: BrGlamorousLabelAptitude;
		beSmallSize
]

{ #category : #initialization }
Gt2PharoPackageClassNavigationElement >> initialize [
	super initialize.

	self hMatchParent.
	self vFitContent.

	self addAptitude: BrGlamorousListItemAptitude.

	classNameLabel := self createNameLabel.
	self addChild: classNameLabel.

	self
		when: BlClickEvent
		do: [ :anEvent |
			anEvent consumed: true.
			anEvent currentTarget pharoClassNavigationViewModel selectClassWithoutOtherEntities ]
]

{ #category : #'api - pharo class navigation view model' }
Gt2PharoPackageClassNavigationElement >> onPharoClassNavigationViewModelChanged [
	"Is sent when a new pharoClassNavigation view model is assigned to the element.
	Note: #onPharoClassNavigationViewModelChanged is sent before #subscribeToPharoClassNavigationViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoClassNavigationViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"

	classNameLabel text: self pharoClassNavigationViewModel pharoBehaviorCoderModel name.
	
	self updateClassSelection
]

{ #category : #'api - pharo class navigation view model' }
Gt2PharoPackageClassNavigationElement >> subscribeToPharoClassNavigationViewModel [
	"Is sent after a new pharoClassNavigation view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromPharoClassNavigationViewModel if elements subscribe to them"
	
	self pharoClassNavigationViewModel
		when: Gt2PharoClassNavigationViewModelSelected, Gt2PharoClassNavigationViewModelDeselected
			send: #updateClassSelection
			to: self
]

{ #category : #'api - pharo class navigation view model' }
Gt2PharoPackageClassNavigationElement >> unsubscribeFromPharoClassNavigationViewModel [
	"Is sent before a new pharoClassNavigation view model is assigned to the element.
	Elements that subscribe to pharoClassNavigation view model in domain model are required to implement this methods."
	
	self pharoClassNavigationViewModel unsubscribe: self
]

{ #category : #'private - update' }
Gt2PharoPackageClassNavigationElement >> updateClassSelection [
	"A class is rendered visually selected when a class is selected and none of its child entities is selected"
	
	self pharoClassNavigationViewModel isOnlySelectedClass
		ifTrue: [ self states addState: BlElementState selected ]
		ifFalse: [ self states removeState: BlElementState selected ]
]
