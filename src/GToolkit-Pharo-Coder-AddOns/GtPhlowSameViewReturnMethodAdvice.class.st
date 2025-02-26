Class {
	#name : #GtPhlowSameViewReturnMethodAdvice,
	#superclass : #GtMethodAdvice,
	#instVars : [
		'argumentName'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-MethodAdvices'
}

{ #category : #testing }
GtPhlowSameViewReturnMethodAdvice class >> isDefault [
	^ false
]

{ #category : #accessing }
GtPhlowSameViewReturnMethodAdvice >> argumentName: anObject [
	argumentName := anObject
]

{ #category : #accessing }
GtPhlowSameViewReturnMethodAdvice >> description [
	^ 'Phlow views should not return directly the view received as an argument'
]

{ #category : #private }
GtPhlowSameViewReturnMethodAdvice >> fixItActionsForNode: aNode coderModel: coderModel [
	^ { GtPhlowSameViewReturnMethodFixItAction 
			forCoder: coderModel node: aNode }
]

{ #category : #testing }
GtPhlowSameViewReturnMethodAdvice >> matches: aNode from: aCriticRunner [
	aNode isErrorNode ifTrue: [ ^ false ].
	argumentName ifNil: [ ^ false ].
	
	^ (aNode isReturn and: [ 
		aNode value isVariable and: [
			aNode value variableName = argumentName ] ])
]

{ #category : #accessing }
GtPhlowSameViewReturnMethodAdvice >> name [
	^ 'Phlow same view return'
]
