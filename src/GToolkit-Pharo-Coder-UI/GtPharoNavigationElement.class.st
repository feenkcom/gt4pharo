Class {
	#name : #GtPharoNavigationElement,
	#superclass : #BrPager,
	#traits : 'TGtWithPharoPackagesNavigationViewModel',
	#classTraits : 'TGtWithPharoPackagesNavigationViewModel classTrait',
	#instVars : [
		'packagesPage',
		'packagesNavigationElement',
		'behaivorsNavigationElement',
		'behaviorsPage'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - Views'
}

{ #category : #initialization }
GtPharoNavigationElement >> initialize [
	super initialize.
	
	self aptitude: BrProportionalHorizontalPagerAptitude.
	self matchParent.
	
	packagesNavigationElement := GtPharoPackagesNavigationElement new.
	behaivorsNavigationElement := GtPharoBehaviorsNavigationElement new.

	packagesPage := (BlElement new
		viewModel: BrPagerPageModel new;
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		addChild: packagesNavigationElement).
		
	behaviorsPage := (BlElement new
		viewModel: BrPagerPageModel new;
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		addChild: behaivorsNavigationElement).
		
	self addPage: packagesPage.
	self addPage: behaviorsPage
]

{ #category : #'private - event handling' }
GtPharoNavigationElement >> onPharoPackageNavigationSelected: anAnnouncement [

	behaivorsNavigationElement pharoBehaviorsNavigationViewModel: anAnnouncement packageViewModel pharoBehaviorsNavigationViewModel
]

{ #category : #'api - pharo packages navigation view model' }
GtPharoNavigationElement >> onPharoPackagesNavigationViewModelChanged [
	"Is sent when a new pharoPackagesNavigation view model is assigned to the element.
	Note: #onPharoPackagesNavigationViewModelChanged is sent before #subscribeToPharoPackagesNavigationViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoPackagesNavigationViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	
	packagesNavigationElement pharoPackagesNavigationViewModel: self pharoPackagesNavigationViewModel
]

{ #category : #'private - event handling' }
GtPharoNavigationElement >> onPharoTagNavigationDeselected: anAnnouncement [

	behaivorsNavigationElement pharoBehaviorsNavigationViewModel:
		anAnnouncement tagViewModel parentPharoTagsNavigationViewModel parentPharoPackageNavigationViewModel pharoBehaviorsNavigationViewModel
]

{ #category : #'private - event handling' }
GtPharoNavigationElement >> onPharoTagNavigationSelected: anAnnouncement [

	behaivorsNavigationElement pharoBehaviorsNavigationViewModel: anAnnouncement tagViewModel pharoBehaviorsNavigationViewModel
]

{ #category : #'api - pharo packages navigation view model' }
GtPharoNavigationElement >> subscribeToPharoPackagesNavigationViewModel [
	"Is sent after a new pharoPackagesNavigation view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromPharoPackagesNavigationViewModel if elements subscribe to them"
	
	self pharoPackagesNavigationViewModel
		when: GtPharoTagNavigationViewModelSelected
			send: #onPharoTagNavigationSelected:
			to: self;
		when: GtPharoTagNavigationViewModelDeselected
			send: #onPharoTagNavigationDeselected:
			to: self;
		when: GtPharoPackageNavigationViewModelSelected
			send: #onPharoPackageNavigationSelected:
			to: self.
]

{ #category : #'api - pharo packages navigation view model' }
GtPharoNavigationElement >> unsubscribeFromPharoPackagesNavigationViewModel [
	"Is sent before a new pharoPackagesNavigation view model is assigned to the element.
	Elements that subscribe to pharoPackagesNavigation view model in domain model are required to implement this methods."
	
	self pharoPackagesNavigationViewModel unsubscribe: self
]
