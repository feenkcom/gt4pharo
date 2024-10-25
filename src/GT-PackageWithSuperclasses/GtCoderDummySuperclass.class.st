Class {
	#name : #GtCoderDummySuperclass,
	#superclass : #Object,
	#instVars : [
		'varA'
	],
	#classVars : [
		'staticVarA'
	],
	#classInstVars : [
		'classVarA'
	],
	#category : #'GT-PackageWithSuperclasses-Classes'
}

{ #category : #'instance creation' }
GtCoderDummySuperclass class >> instanceCreationMethod [
	^ self new
]

{ #category : #'methods reading slots' }
GtCoderDummySuperclass class >> methodReadingClassVarA [
	^ classVarA
]

{ #category : #api }
GtCoderDummySuperclass >> methodInApiProtocol [
]

{ #category : #'methods reading slots' }
GtCoderDummySuperclass >> methodReadingStaticVarA [
	^ staticVarA
]

{ #category : #'methods reading slots' }
GtCoderDummySuperclass >> methodReadingVarA [
	^ varA
]

{ #category : #api }
GtCoderDummySuperclass >> methodWithSubclassResponsibility [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
GtCoderDummySuperclass >> unclassifiedMethod [
]
