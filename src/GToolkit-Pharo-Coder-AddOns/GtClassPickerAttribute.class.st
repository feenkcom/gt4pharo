Class {
	#name : #GtClassPickerAttribute,
	#superclass : #GtRefactoringDropDownAttribute,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method'
}

{ #category : #accessing }
GtClassPickerAttribute >> buttonId [
	^ #classPicker
]

{ #category : #accessing }
GtClassPickerAttribute >> buttonLabel [
	^ selected name
]

{ #category : #accessing }
GtClassPickerAttribute >> classes: aCollection [
	self items: aCollection
]

{ #category : #accessing }
GtClassPickerAttribute >> currentSelection [
	^ refactoringController implementor
]

{ #category : #accessing }
GtClassPickerAttribute >> listId [
	^ #classList
]

{ #category : #private }
GtClassPickerAttribute >> select: cls [
	refactoringController selectClass: cls
]
