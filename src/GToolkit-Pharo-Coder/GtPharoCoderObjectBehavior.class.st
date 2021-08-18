Class {
	#name : 'GtPharoCoderObjectBehavior',
	#superclass : 'GtPharoCoderBehavior',
	#instVars : [
		'object',
		'customBehavior'
	],
	#category : 'GToolkit-Pharo-Coder-Meta'
}

{ #category : 'accessing' }
GtPharoCoderObjectBehavior >> customBehavior [
	^ customBehavior
]

{ #category : 'accessing' }
GtPharoCoderObjectBehavior >> customBehavior: anObject [
	customBehavior := anObject
]

{ #category : 'testing' }
GtPharoCoderObjectBehavior >> exists [
	"Return true if there is a real Behavior in the system corresponding to my definition"
	<return: #Boolean>
	
	(self hasCustomBehavior and: [ self customBehavior isObsolete ])
		ifTrue: [ ^ false ].

	self object class isObsolete
		ifTrue: [ ^ false ].

	^ true
]

{ #category : 'testing' }
GtPharoCoderObjectBehavior >> hasCustomBehavior [
	^ customBehavior notNil
]

{ #category : 'accessing' }
GtPharoCoderObjectBehavior >> object [
	^ object
]

{ #category : 'accessing' }
GtPharoCoderObjectBehavior >> object: anObject [
	self
		assert: [ object isNil ]
		description: [ 'I am immutable and can not be changed' ].

	object := anObject
]
