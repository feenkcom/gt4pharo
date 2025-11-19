Class {
	#name : #GtPharoBehaviorNavigationViewModelSelected,
	#superclass : #Announcement,
	#instVars : [
		'behaviorViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - Events'
}

{ #category : #accessing }
GtPharoBehaviorNavigationViewModelSelected >> behaviorViewModel [
	^ behaviorViewModel
]

{ #category : #accessing }
GtPharoBehaviorNavigationViewModelSelected >> behaviorViewModel: anObject [
	behaviorViewModel := anObject
]
