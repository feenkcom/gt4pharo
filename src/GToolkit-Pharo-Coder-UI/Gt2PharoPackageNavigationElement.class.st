Class {
	#name : #Gt2PharoPackageNavigationElement,
	#superclass : #BrHorizontalPane,
	#traits : 'TGt2WithPharoPackageNavigationViewModel',
	#classTraits : 'TGt2WithPharoPackageNavigationViewModel classTrait',
	#instVars : [
		'packageNameLabel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - Views'
}

{ #category : #initialization }
Gt2PharoPackageNavigationElement >> createPackageNameLabel [
	^ BrLabel new
		aptitude: BrGlamorousLabelAptitude;
		beSmallSize
]

{ #category : #initialization }
Gt2PharoPackageNavigationElement >> initialize [
	super initialize.
	
	self hMatchParent.
	self vFitContent.
	
	self addAptitude: BrGlamorousListItemAptitude.
	
	packageNameLabel := self createPackageNameLabel.
	self addChild: packageNameLabel.

	self
		when: BlClickEvent
		do: [ :anEvent |
			anEvent consumed: true.
			anEvent currentTarget pharoPackageNavigationViewModel selectPackageWithoutOtherEntities ]
]

{ #category : #'api - pharo package navigation view model' }
Gt2PharoPackageNavigationElement >> onPharoPackageNavigationViewModelChanged [
	"Is sent when a new pharoPackageNavigation view model is assigned to the element.
	Note: #onPharoPackageNavigationViewModelChanged is sent before #subscribeToPharoPackageNavigationViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoPackageNavigationViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"

	packageNameLabel text: self pharoPackageNavigationViewModel pharoPackageCoderModel packageName.
	
	self updatePackageSelection
]

{ #category : #'api - pharo package navigation view model' }
Gt2PharoPackageNavigationElement >> subscribeToPharoPackageNavigationViewModel [
	"Is sent after a new pharoPackageNavigation view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromPharoPackageNavigationViewModel if elements subscribe to them"
	
	self pharoPackageNavigationViewModel
		when: Gt2PharoPackageNavigationViewModelSelected, Gt2PharoPackageNavigationViewModelDeselected
			send: #updatePackageSelection
			to: self.

	self pharoPackageNavigationViewModel pharoTagsNavigationViewModel
		when: Gt2PharoSelectedTagNavigationViewModelChanged
			send: #updatePackageSelection
			to: self
]

{ #category : #'api - pharo package navigation view model' }
Gt2PharoPackageNavigationElement >> unsubscribeFromPharoPackageNavigationViewModel [
	"Is sent before a new pharoPackageNavigation view model is assigned to the element.
	Elements that subscribe to pharoPackageNavigation view model in domain model are required to implement this methods."
	
	self pharoPackageNavigationViewModel unsubscribe: self.
	self pharoPackageNavigationViewModel pharoTagsNavigationViewModel unsubscribe: self
]

{ #category : #'private - update' }
Gt2PharoPackageNavigationElement >> updatePackageSelection [
	"A package is rendered visually selected when a package is selected and none of its tags is selected"
	
	self pharoPackageNavigationViewModel isOnlySelectedPackage
		ifTrue: [ self states addState: BlElementState selected ]
		ifFalse: [ self states removeState: BlElementState selected ]
]
