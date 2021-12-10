Class {
	#name : #GtPharoCoderMockedClass,
	#superclass : #GtPharoCoderMockedSuperclass,
	#traits : 'TGtPharoCoderMockedTrait',
	#classTraits : 'TGtPharoCoderMockedTrait classTrait',
	#category : #'GToolkit-Pharo-Coder-Method-Examples-Mocks'
}

{ #category : #'class - accessing' }
GtPharoCoderMockedClass class >> classMethodB [
	"Must be overridden"

	^ 'B'
]

{ #category : #'instance - accessing' }
GtPharoCoderMockedClass >> instanceMethodA [
	^ 'A'
]

{ #category : #'instance - accessing' }
GtPharoCoderMockedClass >> instanceMethodB [
	^ 'B'
]

{ #category : #'instance - accessing' }
GtPharoCoderMockedClass >> instanceMethodC [
	"Should not be overridden by subclasses"

	^ 'C'
]

{ #category : #'trait - accessing' }
GtPharoCoderMockedClass >> traitMethodB [
	^ 'B'
]
