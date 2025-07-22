Class {
	#name : #GtPharoCoderExplicitPackage,
	#superclass : #GtPharoCoderPackage,
	#instVars : [
		'package',
		'packageName'
	],
	#category : #'GToolkit-Pharo-Metamodels-Meta'
}

{ #category : #comparing }
GtPharoCoderExplicitPackage >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ package = anObject package
]

{ #category : #transformation }
GtPharoCoderExplicitPackage >> affectByPackageRegistered: aRPackageRegistered [
	^ (self affectedByPackageRegistered: aRPackageRegistered)
		ifTrue: [ self class explicit: aRPackageRegistered package ]
		ifFalse: [ self ]
]

{ #category : #transformation }
GtPharoCoderExplicitPackage >> affectByPackageRenamed: aRPackageRenamed [
	^ (self affectedByPackageRenamed: aRPackageRenamed)
		ifTrue: [ self class explicit: aRPackageRenamed package ]
		ifFalse: [ self ]
]

{ #category : #transformation }
GtPharoCoderExplicitPackage >> affectByPackageUnregistered: aRPackageUnregistered [
	^ (self affectedByPackageUnregistered: aRPackageUnregistered)
		ifTrue: [ (self class named: aRPackageUnregistered package name) package: self package ]
		ifFalse: [ self ]
]

{ #category : #testing }
GtPharoCoderExplicitPackage >> affectedByPackageRegistered: aRPackageRegistered [
	^ self package = aRPackageRegistered package
		or: [ self packageName = aRPackageRegistered package name ]
]

{ #category : #testing }
GtPharoCoderExplicitPackage >> affectedByPackageRenamed: aRPackageRenamed [
	^ self package = aRPackageRenamed package
		or: [ self packageName = aRPackageRenamed oldName
			or: [ self packageName = aRPackageRenamed newName ] ]
]

{ #category : #testing }
GtPharoCoderExplicitPackage >> affectedByPackageUnregistered: aRPackageUnregistered [
	^ self package = aRPackageUnregistered package
		or: [ self packageName = aRPackageUnregistered package name ]
]

{ #category : #testing }
GtPharoCoderExplicitPackage >> exists [
	"Return true if there is a real package in the system corresponding to my definition"
	<return: #Boolean>
	
	^ self package organizer includesPackage: self package
]

{ #category : #comparing }
GtPharoCoderExplicitPackage >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ package hash
]

{ #category : #accessing }
GtPharoCoderExplicitPackage >> package [
	^ package
]

{ #category : #accessing }
GtPharoCoderExplicitPackage >> package: aRPackage [
	self
		assert: [ package isNil ]
		description: [ 'I am immutable and can not be changed' ].

	package := aRPackage.
	packageName := aRPackage name
]

{ #category : #accessing }
GtPharoCoderExplicitPackage >> packageName [
	^ packageName
]

{ #category : #accessing }
GtPharoCoderExplicitPackage >> packageNameDo: aBlock [
	^ aBlock value: package name
]

{ #category : #printing }
GtPharoCoderExplicitPackage >> printOn: aStream [
	aStream print: self packageName
]

{ #category : #accessing }
GtPharoCoderExplicitPackage >> realPackageDo: aBlock [
	^ aBlock value: self package
]

{ #category : #accessing }
GtPharoCoderExplicitPackage >> renamePackageTo: aNewName [
	packageName := aNewName asSymbol.
	GtPharoCodeModifier renamePackage: package to: aNewName
]

{ #category : #accessing }
GtPharoCoderExplicitPackage >> tags [
	<return: #Collection of: #PackageTag>
	
	^ self package classTags
]
