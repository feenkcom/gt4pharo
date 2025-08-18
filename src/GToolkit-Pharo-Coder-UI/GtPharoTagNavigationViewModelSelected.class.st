Class {
	#name : #GtPharoTagNavigationViewModelSelected,
	#superclass : #Announcement,
	#instVars : [
		'tagViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - Events'
}

{ #category : #accessing }
GtPharoTagNavigationViewModelSelected >> tagViewModel [
	^ tagViewModel
]

{ #category : #accessing }
GtPharoTagNavigationViewModelSelected >> tagViewModel: anObject [
	tagViewModel := anObject
]
