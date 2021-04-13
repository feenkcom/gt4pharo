Class {
	#name : #GtPharoPackageTagNavigationElement,
	#superclass : #BrHorizontalPane,
	#traits : 'TGtWithPharoTagNavigationViewModel',
	#classTraits : 'TGtWithPharoTagNavigationViewModel classTrait',
	#instVars : [
		'packageTagNameLabel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - Views'
}

{ #category : #initialization }
GtPharoPackageTagNavigationElement >> createPackageTagNameLabel [
	^ BrLabel new
		aptitude: BrGlamorousLabelAptitude;
		beSmallSize
]

{ #category : #initialization }
GtPharoPackageTagNavigationElement >> initialize [
	super initialize.

	self hMatchParent.
	self vFitContent.

	self addAptitude: BrGlamorousListItemAptitude.

	packageTagNameLabel := self createPackageTagNameLabel.
	self addChild: packageTagNameLabel.

	self
		when: BlClickEvent
		do: [ :anEvent |
			anEvent consumed: true.
			anEvent currentTarget pharoTagNavigationViewModel selectTagWithoutOtherEntities ]
]

{ #category : #'api - pharo tag navigation view model' }
GtPharoPackageTagNavigationElement >> onPharoTagNavigationViewModelChanged [
	"Is sent when a new pharoTagNavigation view model is assigned to the element.
	Note: #onPharoTagNavigationViewModelChanged is sent before #subscribeToPharoTagNavigationViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoTagNavigationViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"

	packageTagNameLabel text: self pharoTagNavigationViewModel pharoPackageTagCoderModel packageTagName.
	
	self updateTagSelection
]

{ #category : #'api - pharo tag navigation view model' }
GtPharoPackageTagNavigationElement >> subscribeToPharoTagNavigationViewModel [
	"Is sent after a new pharoTagNavigation view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromPharoTagNavigationViewModel if elements subscribe to them"
	
	self pharoTagNavigationViewModel
		when: GtPharoTagNavigationViewModelSelected, GtPharoTagNavigationViewModelDeselected
			send: #updateTagSelection
			to: self
]

{ #category : #'api - pharo tag navigation view model' }
GtPharoPackageTagNavigationElement >> unsubscribeFromPharoTagNavigationViewModel [
	"Is sent before a new pharoTagNavigation view model is assigned to the element.
	Elements that subscribe to pharoTagNavigation view model in domain model are required to implement this methods."
	
	self pharoTagNavigationViewModel unsubscribe: self
]

{ #category : #'private - update' }
GtPharoPackageTagNavigationElement >> updateTagSelection [
	"A tag is rendered visually selected when a tag is selected and none of its child entities is selected"
	
	self pharoTagNavigationViewModel isSelectedTag
		ifTrue: [ self states addState: BlElementState selected ]
		ifFalse: [ self states removeState: BlElementState selected ]
]
