Class {
	#name : #GtPharoPackageNavigationViewModelDeselected,
	#superclass : #Announcement,
	#instVars : [
		'packageViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - Events'
}

{ #category : #accessing }
GtPharoPackageNavigationViewModelDeselected >> packageViewModel [
	^ packageViewModel
]

{ #category : #accessing }
GtPharoPackageNavigationViewModelDeselected >> packageViewModel: anObject [
	packageViewModel := anObject
]
