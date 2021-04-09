Class {
	#name : #GtPharoPackagesNavigationViewModel,
	#superclass : #Object,
	#traits : 'TGtAnnouncer + TGtWithPharoPackagesCoderModel + TGtPharoNavigationWithSelectedPackageViewModel',
	#classTraits : 'TGtAnnouncer classTrait + TGtWithPharoPackagesCoderModel classTrait + TGtPharoNavigationWithSelectedPackageViewModel classTrait',
	#instVars : [
		'announcer',
		'packageViewModels'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - View Models'
}

{ #category : #announcer }
GtPharoPackagesNavigationViewModel >> announcer [
	<return: #Announcer>

	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #'private - instance creation' }
GtPharoPackagesNavigationViewModel >> createPackageCoderViewModels [
	^ self pharoPackagesCoderModel coders collect: [ :eachPackageCoderModel |
		GtPharoPackageNavigationViewModel new
			pharoPackagesNavigationViewModel: self;
			pharoPackageCoderModel: eachPackageCoderModel ]
]

{ #category : #'gt-extensions' }
GtPharoPackagesNavigationViewModel >> gtPackagesFor: aView [
	<gtView>

	^ aView list
		title: 'Packages';
		priority: 10;
		items: [ self packageViewModels ];
		itemText: [ :eachPackageViewModel | eachPackageViewModel pharoPackageCoderModel packageName ]
]

{ #category : #'api - selected package view model' }
GtPharoPackagesNavigationViewModel >> hasSelectedPackageTagViewModel [
	<return: #Boolean>

	^ self hasSelectedPackageViewModel and: [ self selectedPackageViewModel hasSelectedPackageTagViewModel ]
]

{ #category : #'api - selected package view model' }
GtPharoPackagesNavigationViewModel >> notifySelectedPackageViewModelChanged [
	self announce: GtPharoNavigationSelectedPackageViewModelChanged new
]

{ #category : #'api - selected package view model' }
GtPharoPackagesNavigationViewModel >> onNewSelectedPackageViewModelSet: aNewSelectedPackageViewModel [
	"Is sent after a new value of the selectedPackageViewModel is assigned"
	
	aNewSelectedPackageViewModel notifyPackageSelected
]

{ #category : #'api - pharo packages coder model' }
GtPharoPackagesNavigationViewModel >> onPharoPackagesCoderModelChanged [
	"Is sent when a new pharoPackagesCoder model is assigned to the view model"
	
	selectedPackageViewModel := nil.

	"initialized lazily"
	packageViewModels := nil
]

{ #category : #'api - selected package view model' }
GtPharoPackagesNavigationViewModel >> onPreviousSelectedPackageViewModelUnset: aPreviousSelectedPackageViewModel [
	"Is sent after a previous value of the selectedPackageViewModel is de-assigned"
	
	aPreviousSelectedPackageViewModel deselectPackageTagViewModel.
	aPreviousSelectedPackageViewModel notifyPackageDeselected
]

{ #category : #accessing }
GtPharoPackagesNavigationViewModel >> packageViewModels [
	^  packageViewModels ifNil: [ packageViewModels := self createPackageCoderViewModels ]
]
