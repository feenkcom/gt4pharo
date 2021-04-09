Class {
	#name : #GtPharoPackageTagNavigationElement,
	#superclass : #BrHorizontalPane,
	#traits : 'TGtWithPharoPackageTagNavigationViewModel',
	#classTraits : 'TGtWithPharoPackageTagNavigationViewModel classTrait',
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
			anEvent currentTarget pharoPackageTagNavigationViewModel selectTagAndPackage ]
]

{ #category : #'private - event handling' }
GtPharoPackageTagNavigationElement >> onPackageTagViewModelDeselected [
	self states removeState: BlElementState selected
]

{ #category : #'private - event handling' }
GtPharoPackageTagNavigationElement >> onPackageTagViewModelSelected [
	self states addState: BlElementState selected
]

{ #category : #'api - pharo package tag navigation view model' }
GtPharoPackageTagNavigationElement >> onPharoPackageTagNavigationViewModelChanged [
	"Is sent when a new pharoPackageTagNavigation view model is assigned to the element.
	Note: #onPharoPackageTagNavigationViewModelChanged is sent before #subscribeToPharoPackageTagNavigationViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoPackageTagNavigationViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"

	packageTagNameLabel text: self pharoPackageTagNavigationViewModel displayLabel.
	
	self pharoPackageTagNavigationViewModel isTagSelected
		ifTrue: [ self onPackageTagViewModelSelected ]
		ifFalse: [ self onPackageTagViewModelDeselected ]
]

{ #category : #'api - pharo package tag navigation view model' }
GtPharoPackageTagNavigationElement >> subscribeToPharoPackageTagNavigationViewModel [
	"Is sent after a new pharoPackageTagNavigation view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromPharoPackageTagNavigationViewModel if elements subscribe to them"

	self pharoPackageTagNavigationViewModel weak
		when: GtPharoPackageTagViewModelSelected
			send: #onPackageTagViewModelSelected
			to: self;
		when: GtPharoPackageTagViewModelDeselected
			send: #onPackageTagViewModelDeselected
			to: self
]

{ #category : #'api - pharo package tag navigation view model' }
GtPharoPackageTagNavigationElement >> unsubscribeFromPharoPackageTagNavigationViewModel [
	"Is sent before a new pharoPackageTagNavigation view model is assigned to the element.
	Elements that subscribe to pharoPackageTagNavigation view model in domain model are required to implement this methods."
	
	self pharoPackageTagNavigationViewModel unsubscribe: self
]
