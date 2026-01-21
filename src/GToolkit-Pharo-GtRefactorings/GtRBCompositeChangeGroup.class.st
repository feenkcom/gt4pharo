Class {
	#name : #GtRBCompositeChangeGroup,
	#superclass : #GtRBChangeGroup,
	#instVars : [
		'changes'
	],
	#category : #'GToolkit-Pharo-GtRefactorings-Changes-Group'
}

{ #category : #private }
GtRBCompositeChangeGroup class >> buildSelector [
	^ #yourself
]

{ #category : #accessing }
GtRBCompositeChangeGroup >> changes [
	^ changes
]

{ #category : #accessing }
GtRBCompositeChangeGroup >> changes: anObject [
	changes := anObject
]
