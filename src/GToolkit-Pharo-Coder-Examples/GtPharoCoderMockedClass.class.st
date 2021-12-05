Class {
	#name : #GtPharoCoderMockedClass,
	#superclass : #GtPharoCoderMockedSuperClass,
	#traits : 'TGtPharoCoderMockedTrait',
	#classTraits : 'TGtPharoCoderMockedTrait classTrait',
	#category : #'GToolkit-Pharo-Coder-Examples-Mocks'
}

{ #category : #'class - accessing' }
GtPharoCoderMockedClass >> classMethodA [
	^ 'A'
]

{ #category : #'class - accessing' }
GtPharoCoderMockedClass >> classMethodB [
	^ 'B'
]

{ #category : #'trait - accessing' }
GtPharoCoderMockedClass >> traitMethodB [
	^ 'B'
]
