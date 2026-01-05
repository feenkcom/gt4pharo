Class {
	#name : #GtLinkedCompositeRefactoryChange,
	#superclass : #RBCompositeRefactoryChange,
	#instVars : [
		'transformation'
	],
	#category : #'GToolkit-Pharo-GtRefactorings-Refactorings'
}

{ #category : #'as yet unclassified' }
GtLinkedCompositeRefactoryChange >> gtInterestingChanges [
	changes isEmpty ifTrue: [ ^ #() ].
	changes size = 1 ifFalse: [ ^ super gtInterestingChanges ].
	changes first name: self name.
	^ changes
]

{ #category : #accessing }
GtLinkedCompositeRefactoryChange >> transformation [
	^ transformation
]

{ #category : #accessing }
GtLinkedCompositeRefactoryChange >> transformation: anObject [
	transformation := anObject
]
