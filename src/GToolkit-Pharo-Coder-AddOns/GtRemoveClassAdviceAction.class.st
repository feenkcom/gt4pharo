Class {
	#name : #GtRemoveClassAdviceAction,
	#superclass : #GtAdviceAction,
	#instVars : [
		'behavior'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-ObjectAdvices'
}

{ #category : #'instace creation' }
GtRemoveClassAdviceAction class >> remove: aClass [
	^ self new
		behavior: aClass;
		yourself
]

{ #category : #initialization }
GtRemoveClassAdviceAction >> behavior: aClass [
	behavior := aClass
]

{ #category : #accessing }
GtRemoveClassAdviceAction >> defaultTitle [
	^ ('Remove ' , behavior name) asRopedText
]

{ #category : #executing }
GtRemoveClassAdviceAction >> executeOn: anElement [
	(RBRemoveClassRefactoring classNames: {behavior name}) execute
]
