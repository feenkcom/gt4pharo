Class {
	#name : #GtPharoPackageTagsNavigationViewModel,
	#superclass : #Object,
	#traits : 'TGtAnnouncer + TGtWithPharoPackageTagsCoderModel + TGtPharoNavigationWithSelectedPackageTagViewModel',
	#classTraits : 'TGtAnnouncer classTrait + TGtWithPharoPackageTagsCoderModel classTrait + TGtPharoNavigationWithSelectedPackageTagViewModel classTrait',
	#instVars : [
		'announcer',
		'pharoPackageNavigationViewModel',
		'packageTagViewModels'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - View Models'
}

{ #category : #announcer }
GtPharoPackageTagsNavigationViewModel >> announcer [
	<return: #Announcer>

	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #'private - instance creation' }
GtPharoPackageTagsNavigationViewModel >> createPackageTagViewModels [
	^ self pharoPackageTagsCoderModel coders collect: [ :eachPackageTagCoderModel |
		GtPharoPackageTagNavigationViewModel new
			pharoPackageTagsNavigationViewModel: self;
			pharoPackageTagCoderModel: eachPackageTagCoderModel ]
]

{ #category : #'gt-extensions' }
GtPharoPackageTagsNavigationViewModel >> gtPackageTagsFor: aView [
	<gtView>

	^ aView list
		title: 'Tags';
		priority: 10;
		items: [ self packageTagViewModels ];
		itemText: [ :eachPackageTagViewModel | eachPackageTagViewModel pharoPackageTagCoderModel packageTagName ]
]

{ #category : #'api - selected package tag view model' }
GtPharoPackageTagsNavigationViewModel >> notifySelectedPackageTagViewModelChanged [
	self announce: GtPharoNavigationSelectedPackageTagViewModelChanged new
]

{ #category : #'api - selected package tag view model' }
GtPharoPackageTagsNavigationViewModel >> onNewSelectedPackageTagViewModelSet: aNewSelectedPackageTagViewModel [
	"Is sent after a new value of the selectedPackageTagViewModel is assigned"
	
	aNewSelectedPackageTagViewModel notifyTagSelected
]

{ #category : #'api - pharo package tags coder model' }
GtPharoPackageTagsNavigationViewModel >> onPharoPackageTagsCoderModelChanged [
	"Is sent when a new pharoPackageTagsCoder model is assigned to the view model"
	
	
]

{ #category : #'api - selected package tag view model' }
GtPharoPackageTagsNavigationViewModel >> onPreviousSelectedPackageTagViewModelUnset: aPreviousSelectedPackageTagViewModel [
	"Is sent after a previous value of the selectedPackageTagViewModel is de-assigned"
	
	aPreviousSelectedPackageTagViewModel notifyTagDeselected
]

{ #category : #accessing }
GtPharoPackageTagsNavigationViewModel >> packageTagViewModels [
	^ packageTagViewModels ifNil: [ packageTagViewModels := self createPackageTagViewModels ]
]

{ #category : #accessing }
GtPharoPackageTagsNavigationViewModel >> pharoPackageNavigationViewModel [
	^ pharoPackageNavigationViewModel
]

{ #category : #accessing }
GtPharoPackageTagsNavigationViewModel >> pharoPackageNavigationViewModel: anObject [
	pharoPackageNavigationViewModel := anObject
]

{ #category : #'api - selected package tag view model' }
GtPharoPackageTagsNavigationViewModel >> selectPackageTagViewModelAndPackage: aNewSelectedPackageTagViewModel [
	"Select a given package tag view model and corresponding package"

	self selectPackageTagViewModel: aNewSelectedPackageTagViewModel.
	self pharoPackageNavigationViewModel selectPackage
]
