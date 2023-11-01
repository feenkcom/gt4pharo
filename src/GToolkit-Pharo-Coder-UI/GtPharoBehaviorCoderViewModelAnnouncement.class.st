Class {
	#name : #GtPharoBehaviorCoderViewModelAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'pharoBehaviorCoderViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-! View Models'
}

{ #category : #accessing }
GtPharoBehaviorCoderViewModelAnnouncement >> pharoBehaviorCoderViewModel [
	^ pharoBehaviorCoderViewModel
]

{ #category : #accessing }
GtPharoBehaviorCoderViewModelAnnouncement >> pharoBehaviorCoderViewModel: aCoderViewModel [
	pharoBehaviorCoderViewModel := aCoderViewModel
]
