Class {
	#name : #GtPharoBehaviorNavigationElement,
	#superclass : #BrHorizontalPane,
	#traits : 'TGtWithPharoBehaviorNavigationViewModel',
	#classTraits : 'TGtWithPharoBehaviorNavigationViewModel classTrait',
	#instVars : [
		'classNameLabel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - Views'
}

{ #category : #initialization }
GtPharoBehaviorNavigationElement >> createNameLabel [
	^ BrLabel new
		aptitude: BrGlamorousLabelAptitude;
		beSmallSize
]

{ #category : #initialization }
GtPharoBehaviorNavigationElement >> initialize [
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
			anEvent currentTarget pharoBehaviorNavigationViewModel selectBehaviorWithoutOtherEntities ]
]

{ #category : #'api - pharo behavior navigation view model' }
GtPharoBehaviorNavigationElement >> onPharoBehaviorNavigationViewModelChanged [
	"Is sent when a new pharoBehaviorNavigation view model is assigned to the element.
	Note: #onPharoBehaviorNavigationViewModelChanged is sent before #subscribeToPharoBehaviorNavigationViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoBehaviorNavigationViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"

	classNameLabel text: self pharoBehaviorNavigationViewModel pharoBehaviorCoderModel name.

	self updateClassSelection
]

{ #category : #'api - pharo behavior navigation view model' }
GtPharoBehaviorNavigationElement >> subscribeToPharoBehaviorNavigationViewModel [
	"Is sent after a new pharoBehaviorNavigation view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromPharoBehaviorNavigationViewModel if elements subscribe to them"
	
	self pharoBehaviorNavigationViewModel
		when: GtPharoBehaviorNavigationViewModelSelected, GtPharoBehaviorNavigationViewModelDeselected
			send: #updateClassSelection
			to: self
]

{ #category : #'api - pharo behavior navigation view model' }
GtPharoBehaviorNavigationElement >> unsubscribeFromPharoBehaviorNavigationViewModel [
	"Is sent before a new pharoBehaviorNavigation view model is assigned to the element.
	Elements that subscribe to pharoBehaviorNavigation view model in domain model are required to implement this methods."
	
	self pharoBehaviorNavigationViewModel unsubscribe: self
]

{ #category : #'private - update' }
GtPharoBehaviorNavigationElement >> updateClassSelection [
	"A behavior is rendered visually selected when a behavior is selected and none of its child entities is selected"
	
	self pharoBehaviorNavigationViewModel isOnlySelectedBehavior
		ifTrue: [ self states addState: BlElementState selected ]
		ifFalse: [ self states removeState: BlElementState selected ]
]
