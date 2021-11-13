Class {
	#name : #GtSearchClassesInPackageFilter,
	#superclass : #GtSearchClassesFilter,
	#instVars : [
		'package'
	],
	#category : #'GToolkit-Pharo-Coder-Filters'
}

{ #category : #'instance creation' }
GtSearchClassesInPackageFilter class >> forPackageNamed: aPackageName [
	^ self new
		package: aPackageName asPackage
]

{ #category : #comparing }
GtSearchClassesInPackageFilter >> = anObject [

	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ package = anObject package
]

{ #category : #enumerating }
GtSearchClassesInPackageFilter >> classesDo: aBlock [
	package definedClasses do: aBlock
]

{ #category : #accessing }
GtSearchClassesInPackageFilter >> defaultFilterScope [
	^ AsyncPackageBehaviorsStream package: self package
]

{ #category : #comparing }
GtSearchClassesInPackageFilter >> hash [

	"Answer an integer value that is related to the identity of the receiver."

	^ package hash
]

{ #category : #testing }
GtSearchClassesInPackageFilter >> includesClass: aClass [
	^ aClass package = package
]

{ #category : #enumerating }
GtSearchClassesInPackageFilter >> itemsDo: aBlock [
	^ self classesDo: aBlock
]

{ #category : #accessing }
GtSearchClassesInPackageFilter >> package [
	^ package
]

{ #category : #accessing }
GtSearchClassesInPackageFilter >> package: aPackage [
	package := aPackage
]
