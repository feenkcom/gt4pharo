Class {
	#name : #GtVariableAdvice,
	#superclass : #GtAdvice,
	#instVars : [
		'variables',
		'behavior'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Advice'
}

{ #category : #accessing }
GtVariableAdvice >> behavior [
	^ behavior
]

{ #category : #accessing }
GtVariableAdvice >> behavior: aBehavior [
	behavior := aBehavior
]

{ #category : #accessing }
GtVariableAdvice >> variables [
	^ variables
]

{ #category : #accessing }
GtVariableAdvice >> variables: aCollection [
	variables := aCollection
]
