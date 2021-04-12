Class {
	#name : #GtPharoClassNavigationViewModelSelected,
	#superclass : #Announcement,
	#instVars : [
		'classViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - Events'
}

{ #category : #accessing }
GtPharoClassNavigationViewModelSelected >> classViewModel [
	^ classViewModel
]

{ #category : #accessing }
GtPharoClassNavigationViewModelSelected >> classViewModel: anObject [
	classViewModel := anObject
]
