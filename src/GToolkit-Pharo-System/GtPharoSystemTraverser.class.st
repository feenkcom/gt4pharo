"
# Pharo system traverser
Is an utility for thread safe traversal of the system classes, traits, packages and methods.

"
Class {
	#name : #GtPharoSystemTraverser,
	#superclass : #Object,
	#instVars : [
		'environment'
	],
	#classInstVars : [
		'default'
	],
	#category : #'GToolkit-Pharo-System'
}

{ #category : #cleanup }
GtPharoSystemTraverser class >> cleanUp [
	default := nil
]

{ #category : #accessing }
GtPharoSystemTraverser class >> default [
	^ default ifNil: [ default := self new ]
]

{ #category : #enumerating }
GtPharoSystemTraverser >> allClassesAndTraitsDo: aBlock [
	"Evaluate a given block closure with all classes and traits in the evironment in arbitrary order"
	| theCurrentClassAndTraitNames |
	
	theCurrentClassAndTraitNames := self environment classAndTraitNames copy.
	theCurrentClassAndTraitNames do: [ :eachClassOrTraitName |
		self environment
			at: eachClassOrTraitName
			ifPresent: aBlock ]
]

{ #category : #accessing }
GtPharoSystemTraverser >> environment [
	<return: #SystemDictionary>

	^ environment
]

{ #category : #accessing }
GtPharoSystemTraverser >> environment: aSystemDictionary [
	environment := aSystemDictionary
]

{ #category : #initialization }
GtPharoSystemTraverser >> initialize [
	super initialize.
	
	environment := Smalltalk globals
]
