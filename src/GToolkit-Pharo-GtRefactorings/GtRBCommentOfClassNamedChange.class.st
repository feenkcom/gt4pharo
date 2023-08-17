Class {
	#name : #GtRBCommentOfClassNamedChange,
	#superclass : #RBCommentChange,
	#category : #'GToolkit-Pharo-GtRefactorings-Changes'
}

{ #category : #'instance creation' }
GtRBCommentOfClassNamedChange class >> comment: aString inBehaviorNamed: aBehaviorName [
	^ self new
		comment: aString
		inBehaviorNamed: aBehaviorName
]

{ #category : #accessing }
GtRBCommentOfClassNamedChange >> behaviorName: aBehaviorName [
	className := aBehaviorName
]

{ #category : #initialization }
GtRBCommentOfClassNamedChange >> comment: aString inBehaviorNamed: aBehaviorName [
	comment := aString.
	isMeta := false.
	className := aBehaviorName
]

{ #category : #accessing }
GtRBCommentOfClassNamedChange >> isMeta: isMetaClass [
	isMeta := isMetaClass
]
