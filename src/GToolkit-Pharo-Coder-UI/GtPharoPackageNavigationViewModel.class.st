Class {
	#name : #GtPharoPackageNavigationViewModel,
	#superclass : #Object,
	#traits : 'TGtAnnouncer + TGtWithPharoPackageCoderModel + TGtPharoNavigationViewModelWithExpanded',
	#classTraits : 'TGtAnnouncer classTrait + TGtWithPharoPackageCoderModel classTrait + TGtPharoNavigationViewModelWithExpanded classTrait',
	#instVars : [
		'announcer',
		'pharoPackagesNavigationViewModel',
		'packageTagsViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - View Models'
}

{ #category : #announcer }
GtPharoPackageNavigationViewModel >> announcer [
	<return: #Announcer>

	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #'private - instance creation' }
GtPharoPackageNavigationViewModel >> createPackageTagsViewModel [
	^ GtPharoPackageTagsNavigationViewModel new
		pharoPackageNavigationViewModel: self;
		pharoPackageTagsCoderModel: self pharoPackageCoderModel packageTagsCoder
]

{ #category : #'api - selection' }
GtPharoPackageNavigationViewModel >> deselectPackageTagViewModel [
	packageTagsViewModel
		ifNotNil: [ :aPackageTagsVieModel | aPackageTagsVieModel deselectPackageTagViewModel ]
]

{ #category : #accessing }
GtPharoPackageNavigationViewModel >> displayLabel [
	^ self packageName
]

{ #category : #'api - selection' }
GtPharoPackageNavigationViewModel >> hasSelectedPackageTagViewModel [
	<return: #Boolean>

	^ packageTagsViewModel
		ifNil: [ false ]
		ifNotNil: [ :aPackageTagsVieModel | aPackageTagsVieModel hasSelectedPackageTagViewModel ]
]

{ #category : #'api - selection' }
GtPharoPackageNavigationViewModel >> isOnlyPackageSelected [
	"Return true if only this package selected and not tags"
	<return: #Boolean>

	^ self isPackageSelected and: [ self hasSelectedPackageTagViewModel not ]
]

{ #category : #'api - selection' }
GtPharoPackageNavigationViewModel >> isPackageSelected [
	<return: #Boolean>

	^ self pharoPackagesNavigationViewModel hasSelectedPackageViewModel
		and: [ self pharoPackagesNavigationViewModel selectedPackageViewModel == self ]
]

{ #category : #'api - testing' }
GtPharoPackageNavigationViewModel >> isPackageTagViewModel [
	^ false
]

{ #category : #'api - testing' }
GtPharoPackageNavigationViewModel >> isPackageViewModel [
	^ true
]

{ #category : #'api - expanded' }
GtPharoPackageNavigationViewModel >> notifyExpandedChanged [
	self announce: (GtPharoNavigationPackageExpansionChanged new)
]

{ #category : #'api - selection' }
GtPharoPackageNavigationViewModel >> notifyPackageDeselected [
	self announce: GtPharoPackageViewModelDeselected new
]

{ #category : #'api - selection' }
GtPharoPackageNavigationViewModel >> notifyPackageSelected [
	self announce: GtPharoPackageViewModelSelected new
]

{ #category : #'api - pharo package coder model' }
GtPharoPackageNavigationViewModel >> onPharoPackageCoderModelChanged [
	"Is sent when a new pharoPackageCoder model is assigned to the view model"
	
	
]

{ #category : #'api - pharo package coder model' }
GtPharoPackageNavigationViewModel >> packageName [
	^ self pharoPackageCoderModel packageName
]

{ #category : #accessing }
GtPharoPackageNavigationViewModel >> packageTagViewModels [
	<return: #Collection of: #GtPharoPackageTagNavigationViewModel>

	^ self pharoPackageTagsViewModel packageTagViewModels
]

{ #category : #accessing }
GtPharoPackageNavigationViewModel >> pharoPackageTagsViewModel [
	<return: #GtPharoPackageTagsNavigationViewModel>

	^ packageTagsViewModel ifNil: [ packageTagsViewModel := self createPackageTagsViewModel ]
]

{ #category : #accessing }
GtPharoPackageNavigationViewModel >> pharoPackagesNavigationViewModel [
	^ pharoPackagesNavigationViewModel
]

{ #category : #accessing }
GtPharoPackageNavigationViewModel >> pharoPackagesNavigationViewModel: anObject [
	pharoPackagesNavigationViewModel := anObject
]

{ #category : #'api - selection' }
GtPharoPackageNavigationViewModel >> selectPackage [
	"Just select a package without changing tag selection"

	self pharoPackagesNavigationViewModel selectPackageViewModel: self
]

{ #category : #'api - selection' }
GtPharoPackageNavigationViewModel >> selectPackageWithoutTag [
	"Select a package deselecting tags"

	self deselectPackageTagViewModel.
	self selectPackage
]
