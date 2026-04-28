Class {
	#name : #GtPharoRenameSelectorSwapVisibilityChanged,
	#superclass : #GtPharoRenameSelectorModelAnnouncement,
	#instVars : [
		'isVisible',
		'correspondingModels'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #accessing }
GtPharoRenameSelectorSwapVisibilityChanged >> correspondingModels [
	^ correspondingModels ifNil: [ #() ]
]

{ #category : #accessing }
GtPharoRenameSelectorSwapVisibilityChanged >> correspondingModels: aCollection [
	correspondingModels := aCollection
]

{ #category : #accessing }
GtPharoRenameSelectorSwapVisibilityChanged >> isVisible [
	^ isVisible == true
]

{ #category : #accessing }
GtPharoRenameSelectorSwapVisibilityChanged >> isVisible: aBoolean [
	isVisible := aBoolean
]
