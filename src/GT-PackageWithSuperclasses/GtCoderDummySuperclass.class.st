Class {
	#name : #GtCoderDummySuperclass,
	#superclass : #Object,
	#category : #'GT-PackageWithSuperclasses-Classes'
}

{ #category : #'instance creation' }
GtCoderDummySuperclass class >> instanceCreationMethod [
	^ self new
]

{ #category : #api }
GtCoderDummySuperclass >> methodInApiProtocol [
]

{ #category : #api }
GtCoderDummySuperclass >> methodWithSubclassResponsibility [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
GtCoderDummySuperclass >> unclassifiedMethod [
]
