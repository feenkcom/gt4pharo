Class {
	#name : #GtPharoMethodBasicBehaviorSource,
	#superclass : #Object,
	#instVars : [
		'behavior'
	],
	#category : #'GToolkit-Pharo-Coder-Method-UI-Support - Modification Model'
}

{ #category : #accessing }
GtPharoMethodBasicBehaviorSource >> behavior [
	^ behavior
]

{ #category : #accessing }
GtPharoMethodBasicBehaviorSource >> behavior: anObject [
	behavior := anObject
]

{ #category : #'api - accessing' }
GtPharoMethodBasicBehaviorSource >> compiledMethodWithSelector: aSelector [
	"Return a compiled method that is defined in the given behavior. If the behavior does not define such method, return nil."

	<return: #Behavior or: nil>
	^ self behavior
		ifNotNil: [ :aBehavior | aBehavior compiledMethodAt: aSelector ifAbsent: [ nil ] ]
		ifNil: [ nil ]
]

{ #category : #printing }
GtPharoMethodBasicBehaviorSource >> gtDisplayOn: aStream [
	aStream
		nextPutAll: self label;
		nextPutAll: ': ';
		print: self behavior
]

{ #category : #accessing }
GtPharoMethodBasicBehaviorSource >> label [
	^ self className
]
