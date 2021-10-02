Class {
	#name : #GtCoderPharoEnvironment,
	#superclass : #GtCoderSmalltalkEnvironment,
	#instVars : [
		'driver'
	],
	#category : #'GToolkit-Coder-Environment-Pharo'
}

{ #category : #accessing }
GtCoderPharoEnvironment >> driver [
	^ driver
]

{ #category : #accessing }
GtCoderPharoEnvironment >> driver: anObject [

	driver := anObject
]
