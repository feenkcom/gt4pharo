Class {
	#name : #GtPharoPackageTagNavigationViewModel,
	#superclass : #Object,
	#traits : 'TGtAnnouncer + TGtWithPharoPackageTagCoderModel',
	#classTraits : 'TGtAnnouncer classTrait + TGtWithPharoPackageTagCoderModel classTrait',
	#instVars : [
		'announcer',
		'pharoPackageTagsNavigationViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - View Models'
}

{ #category : #announcer }
GtPharoPackageTagNavigationViewModel >> announcer [
	<return: #Announcer>

	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #accessing }
GtPharoPackageTagNavigationViewModel >> displayLabel [
	^ self packageTagName
]

{ #category : #testing }
GtPharoPackageTagNavigationViewModel >> isPackageTagViewModel [
	^ true
]

{ #category : #testing }
GtPharoPackageTagNavigationViewModel >> isPackageViewModel [
	^ false
]

{ #category : #'api - selection' }
GtPharoPackageTagNavigationViewModel >> isTagSelected [
	<return: #Boolean>

	^ self pharoPackageTagsNavigationViewModel hasSelectedPackageTagViewModel
		and: [ self pharoPackageTagsNavigationViewModel selectedPackageTagViewModel == self ]
]

{ #category : #'api - expanded' }
GtPharoPackageTagNavigationViewModel >> notifyExpandedChanged [
	self announce: (GtPharoNavigationPackageTagExpansionChanged new)
]

{ #category : #'api - selection' }
GtPharoPackageTagNavigationViewModel >> notifyTagDeselected [
	self announce: GtPharoPackageTagViewModelDeselected new
]

{ #category : #'api - selection' }
GtPharoPackageTagNavigationViewModel >> notifyTagSelected [
	self announce: GtPharoPackageTagViewModelSelected new
]

{ #category : #'api - pharo package tag coder model' }
GtPharoPackageTagNavigationViewModel >> onPharoPackageTagCoderModelChanged [
	"Is sent when a new pharoPackageTagCoder model is assigned to the view model"
	
	
]

{ #category : #'api - pharo package tag coder model' }
GtPharoPackageTagNavigationViewModel >> packageTagName [
	^ self pharoPackageTagCoderModel packageTagName
]

{ #category : #accessing }
GtPharoPackageTagNavigationViewModel >> pharoPackageTagsNavigationViewModel [
	<return: #GtPharoPackageTagsNavigationViewModel>

	^ pharoPackageTagsNavigationViewModel
]

{ #category : #accessing }
GtPharoPackageTagNavigationViewModel >> pharoPackageTagsNavigationViewModel: anObject [
	pharoPackageTagsNavigationViewModel := anObject
]

{ #category : #'api - selection' }
GtPharoPackageTagNavigationViewModel >> selectTagAndPackage [
	self pharoPackageTagsNavigationViewModel selectPackageTagViewModelAndPackage: self
]
