Class {
	#name : #GtCommentDefinition,
	#superclass : #GtCodeDefinition,
	#instVars : [
		'content'
	],
	#category : #'GToolkit-Pharo-Metamodels-Behavior - Definitions'
}

{ #category : #'instance creation' }
GtCommentDefinition class >> fromBehavior: aBehavior [
	^ self new fromBehavior: aBehavior
]

{ #category : #accessing }
GtCommentDefinition >> content [
	^ content
]

{ #category : #accessing }
GtCommentDefinition >> content: anObject [
	content := anObject
]

{ #category : #'api - accepting' }
GtCommentDefinition >> createChange [
	^ RBCommentOfClassNamedChange new
		comment: self content;
		isMeta: false
]

{ #category : #initialization }
GtCommentDefinition >> fromBehavior: aBehavior [
	content := aBehavior hasComment
		ifTrue: [ aBehavior comment ]
		ifFalse: [ '' ]
]

{ #category : #initialization }
GtCommentDefinition >> initialize [
	super initialize.
	
	content := ''
]

{ #category : #accessing }
GtCommentDefinition >> name [
	^ 'Comment'
]
