Class {
	#name : #GtBehaviorCoderHeaderSuperclassError,
	#superclass : #GtBehaviorCoderHeaderError,
	#instVars : [
		'superclassName'
	],
	#category : #'GToolkit-Pharo-Metamodels-Behavior - Errors'
}

{ #category : #signalling }
GtBehaviorCoderHeaderSuperclassError class >> signalFor: aTraitName [
	(self new superclassName: aTraitName) signal
]

{ #category : #accessing }
GtBehaviorCoderHeaderSuperclassError >> superclassName [
	^ superclassName
]

{ #category : #accessing }
GtBehaviorCoderHeaderSuperclassError >> superclassName: anObject [
	superclassName := anObject
]
