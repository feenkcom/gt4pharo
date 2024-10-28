Class {
	#name : #GtCoderDummySuperclass,
	#superclass : #Object,
	#instVars : [
		'slotA'
	],
	#classVars : [
		'classVarA'
	],
	#classInstVars : [
		'classSlotA'
	],
	#category : #'GT-PackageWithSuperclasses-Classes'
}

{ #category : #initialization }
GtCoderDummySuperclass class >> initialize [
	"Class side initialization"
]

{ #category : #'instance creation' }
GtCoderDummySuperclass class >> instanceCreationMethod [
	^ self new
]

{ #category : #'methods reading slots' }
GtCoderDummySuperclass class >> methodReadingClassSlotA [
	^ classSlotA
]

{ #category : #initialization }
GtCoderDummySuperclass >> initialize [
	"Instance side initialization"
]

{ #category : #api }
GtCoderDummySuperclass >> methodInApiProtocol [
]

{ #category : #'methods reading slots' }
GtCoderDummySuperclass >> methodReadingClassVarA [
	^ classVarA
]

{ #category : #'methods reading slots' }
GtCoderDummySuperclass >> methodReadingSlotA [
	^ slotA
]

{ #category : #api }
GtCoderDummySuperclass >> methodWithSubclassResponsibility [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
GtCoderDummySuperclass >> unclassifiedMethod [
]
