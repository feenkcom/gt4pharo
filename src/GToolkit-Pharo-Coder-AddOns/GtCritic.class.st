Class {
	#name : #GtCritic,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-AddOns-Critics'
}

{ #category : #testing }
GtCritic class >> isDefault [
	^ true
]

{ #category : #comparing }
GtCritic >> = anObject [
	^ self class = anObject class
]

{ #category : #accessing }
GtCritic >> description [
	^ self subclassResponsibility
]

{ #category : #comparing }
GtCritic >> hash [
	^ self class hash
]

{ #category : #testing }
GtCritic >> matches: anObject from: aCriticRunner [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtCritic >> name [
	^ ''
]
