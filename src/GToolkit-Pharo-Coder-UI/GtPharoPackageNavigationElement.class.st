Class {
	#name : #GtPharoPackageNavigationElement,
	#superclass : #BrHorizontalPane,
	#traits : 'TGtWithPharoPackageNavigationViewModel',
	#classTraits : 'TGtWithPharoPackageNavigationViewModel classTrait',
	#instVars : [
		'packageNameLabel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - Views'
}

{ #category : #initialization }
GtPharoPackageNavigationElement >> createPackageNameLabel [
	^ BrLabel new
		aptitude: BrGlamorousLabelAptitude;
		beSmallSize
]

{ #category : #initialization }
GtPharoPackageNavigationElement >> initialize [
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
			anEvent currentTarget pharoPackageNavigationViewModel selectPackageWithoutTag ]
]

{ #category : #'private - event handling' }
GtPharoPackageNavigationElement >> onPackageTagsViewModelSelectionChnaged [
	self updatePackageSelection
]

{ #category : #'private - event handling' }
GtPharoPackageNavigationElement >> onPackageViewModelDeselected [
	self updatePackageSelection
]

{ #category : #'private - event handling' }
GtPharoPackageNavigationElement >> onPackageViewModelSelected [
	self updatePackageSelection
]

{ #category : #'api - pharo package navigation view model' }
GtPharoPackageNavigationElement >> onPharoPackageNavigationViewModelChanged [
	"Is sent when a new pharoPackageNavigation view model is assigned to the element.
	Note: #onPharoPackageNavigationViewModelChanged is sent before #subscribeToPharoPackageNavigationViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoPackageNavigationViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"

	packageNameLabel text: self pharoPackageNavigationViewModel displayLabel.
	
	self updatePackageSelection
]

{ #category : #'api - pharo package navigation view model' }
GtPharoPackageNavigationElement >> subscribeToPharoPackageNavigationViewModel [
	"Is sent after a new pharoPackageNavigation view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromPharoPackageNavigationViewModel if elements subscribe to them"
	
	self pharoPackageNavigationViewModel weak
		when: GtPharoPackageViewModelSelected
			send: #onPackageViewModelSelected
			to: self;
		when: GtPharoPackageViewModelDeselected
			send: #onPackageViewModelDeselected
			to: self.
			
	self pharoPackageNavigationViewModel pharoPackageTagsViewModel weak
		when: GtPharoNavigationSelectedPackageTagViewModelChanged
			send: #onPackageTagsViewModelSelectionChnaged
			to: self
]

{ #category : #'api - pharo package navigation view model' }
GtPharoPackageNavigationElement >> unsubscribeFromPharoPackageNavigationViewModel [
	"Is sent before a new pharoPackageNavigation view model is assigned to the element.
	Elements that subscribe to pharoPackageNavigation view model in domain model are required to implement this methods."
	
	self pharoPackageNavigationViewModel unsubscribe: self.
	self pharoPackageNavigationViewModel pharoPackageTagsViewModel unsubscribe: self
]

{ #category : #'private - update' }
GtPharoPackageNavigationElement >> updatePackageSelection [
	"A package is rendered visually selected when a package is selected and none of its tags is selected"
	
	self pharoPackageNavigationViewModel isOnlyPackageSelected
		ifTrue: [ self states addState: BlElementState selected ]
		ifFalse: [ self states removeState: BlElementState selected ]
]
