Class {
	#name : #GtNoAdvice,
	#superclass : #GtAdvice,
	#category : #'GToolkit-Pharo-Coder-AddOns-Advice'
}

{ #category : #accessing }
GtNoAdvice >> description [
	^ '' asRopedText
]

{ #category : #testing }
GtNoAdvice >> isNone [
	^ true
]

{ #category : #accessing }
GtNoAdvice >> name [
	^ 'No advice'
]

{ #category : #advising }
GtNoAdvice >> none [
	self setCreator
]
