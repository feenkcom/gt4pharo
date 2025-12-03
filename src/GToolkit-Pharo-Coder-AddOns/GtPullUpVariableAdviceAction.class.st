Class {
	#name : #GtPullUpVariableAdviceAction,
	#superclass : #GtAdviceAction,
	#instVars : [
		'behavior',
		'variable'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-ObjectAdvices'
}

{ #category : #'instance creation' }
GtPullUpVariableAdviceAction class >> pullUp: aString into: aClass [
	^ self new
		pullUp: aString into: aClass;
		yourself
]

{ #category : #accessing }
GtPullUpVariableAdviceAction >> defaultTitle [
	^ ('Pull up ' , variable) asRopedText
]

{ #category : #executing }
GtPullUpVariableAdviceAction >> executeOn: anElement [
	(RBPullUpInstanceVariableRefactoring variable: variable class: behavior)
		execute
]

{ #category : #initialization }
GtPullUpVariableAdviceAction >> pullUp: aString into: aClass [
	variable := aString.
	behavior := aClass
]
