Class {
	#name : #GtPharoCoderMockedClass,
	#superclass : #GtPharoCoderMockedSuperClass,
	#traits : 'TGtPharoCoderMockedTrait',
	#classTraits : 'TGtPharoCoderMockedTrait classTrait',
	#category : #'GToolkit-Pharo-Coder-Method-Examples-Mocks'
}

{ #category : #'class - accessing' }
GtPharoCoderMockedClass >> instanceMethodA [
	^ 'A'
]

{ #category : #'class - accessing' }
GtPharoCoderMockedClass >> instanceMethodB [
	^ 'B'
]

{ #category : #'trait - accessing' }
GtPharoCoderMockedClass >> traitMethodB [
	^ 'B'
]
