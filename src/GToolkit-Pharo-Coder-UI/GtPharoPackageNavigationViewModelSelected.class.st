Class {
	#name : #GtPharoPackageNavigationViewModelSelected,
	#superclass : #Announcement,
	#instVars : [
		'packageViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - Events'
}

{ #category : #accessing }
GtPharoPackageNavigationViewModelSelected >> packageViewModel [
	^ packageViewModel
]

{ #category : #accessing }
GtPharoPackageNavigationViewModelSelected >> packageViewModel: anObject [
	packageViewModel := anObject
]
