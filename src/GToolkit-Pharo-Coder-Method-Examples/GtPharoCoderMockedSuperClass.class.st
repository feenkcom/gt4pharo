Class {
	#name : #GtPharoCoderMockedSuperclass,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Method-Examples-Mocks'
}

{ #category : #'class - accessing' }
GtPharoCoderMockedSuperclass class >> classMethodA [
	"Should not be overridden"

	^ 'A'
]

{ #category : #'class - accessing' }
GtPharoCoderMockedSuperclass class >> classMethodB [
	"Must be overridden"

	^ self subclassResponsibility
]

{ #category : #'instance - accessing' }
GtPharoCoderMockedSuperclass >> instanceMethodA [
	"Must be overriden by subclasses"

	^ self subclassResponsibility
]

{ #category : #'instance - accessing' }
GtPharoCoderMockedSuperclass >> instanceMethodB [
	"Should not be overridden by subclasses"

	^ $B
]
