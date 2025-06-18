Class {
	#name : #GtPharoCoderNamedPackage,
	#superclass : #GtPharoCoderPackage,
	#instVars : [
		'package',
		'packageName'
	],
	#category : #'GToolkit-Pharo-Metamodels-Meta'
}

{ #category : #comparing }
GtPharoCoderNamedPackage >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ packageName = anObject packageName
]

{ #category : #transformation }
GtPharoCoderNamedPackage >> affectByPackageRegistered: aRPackageRegistered [
	^ (self affectedByPackageRegistered: aRPackageRegistered)
		ifTrue: [ self class explicit: aRPackageRegistered package ]
		ifFalse: [ self ]
]

{ #category : #transformation }
GtPharoCoderNamedPackage >> affectByPackageRenamed: aRPackageRenamed [
	^ (self affectedByPackageRenamed: aRPackageRenamed)
		ifTrue: [ self class explicit: aRPackageRenamed package ]
		ifFalse: [ self ]
]

{ #category : #transformation }
GtPharoCoderNamedPackage >> affectByPackageUnregistered: aRPackageUnregistered [
	^ (self affectedByPackageUnregistered: aRPackageUnregistered)
		ifTrue: [ self class named: self packageName ]
		ifFalse: [ self ]
]

{ #category : #testing }
GtPharoCoderNamedPackage >> affectedByPackageRegistered: aRPackageRegistered [
	self packageNameDo: [ :aPackageName | ^ aPackageName = aRPackageRegistered package name ].
	^ false
]

{ #category : #testing }
GtPharoCoderNamedPackage >> affectedByPackageRenamed: aRPackageRenamed [
	self packageNameDo: [ :aPackageName |
		^ (aPackageName = aRPackageRenamed oldName)
			or: [ aPackageName = aRPackageRenamed newName ] ].
	^ false
]

{ #category : #testing }
GtPharoCoderNamedPackage >> affectedByPackageUnregistered: aRPackageUnregistered [
	^ package
		ifNil: [ false ]
		ifNotNil: [ :aPackage | aPackage name = aRPackageUnregistered package name ]
]

{ #category : #testing }
GtPharoCoderNamedPackage >> exists [
	"Return true if there is a real Package in the system corresponding to my definition"
	<return: #Boolean>
	
	^ self packageOrganizer includesPackageNamed: self packageName
]

{ #category : #comparing }
GtPharoCoderNamedPackage >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ packageName hash
]

{ #category : #accessing }
GtPharoCoderNamedPackage >> package [
	^ package
]

{ #category : #accessing }
GtPharoCoderNamedPackage >> package: anObject [
	package := anObject
]

{ #category : #accessing }
GtPharoCoderNamedPackage >> packageName [
	^ packageName
]

{ #category : #accessing }
GtPharoCoderNamedPackage >> packageName: aPackageName [
	self
		assert: [ packageName isNil ]
		description: [ 'I am immutable and can not be changed' ].

	packageName := aPackageName asSymbol.
	
	package := self packageOrganizer
		packageNamed: packageName
		ifAbsent: [ nil ]
]

{ #category : #accessing }
GtPharoCoderNamedPackage >> packageNameDo: aBlock [
	| aRealPackage |

	aRealPackage := self packageOrganizer
		packageNamed: packageName
		ifAbsent: [ package ifNil: [ nil ] ].

	^ aBlock value: (aRealPackage ifNil: [ packageName ] ifNotNil: [ :aPackage | aPackage name ] )
]

{ #category : #accessing }
GtPharoCoderNamedPackage >> realPackageDo: aBlock [
	^ aBlock value: (self packageOrganizer
		packageNamed: packageName
		ifAbsent: [ package ifNil: [ ^ nil ] ])
]

{ #category : #accessing }
GtPharoCoderNamedPackage >> renamePackageTo: aNewName [
	packageName := aNewName asSymbol.
	self realPackageDo: [ :aPackage | GtPharoCodeModifier renamePackage: aPackage to: aNewName ]
]
