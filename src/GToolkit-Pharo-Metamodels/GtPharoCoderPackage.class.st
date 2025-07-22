Class {
	#name : #GtPharoCoderPackage,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Metamodels-Meta'
}

{ #category : #'instance creation' }
GtPharoCoderPackage class >> explicit: aPackage [
	^ GtPharoCoderExplicitPackage new package: aPackage
]

{ #category : #'instance creation' }
GtPharoCoderPackage class >> named: aPackageName [
	^ GtPharoCoderNamedPackage new packageName: aPackageName
]

{ #category : #'instance creation' }
GtPharoCoderPackage class >> unspecified [
	^ GtPharoCoderUnspecifiedPackage new
]

{ #category : #transformation }
GtPharoCoderPackage >> affectByPackageRegistered: aRPackageRegistered [
	^ self subclassResponsibility
]

{ #category : #transformation }
GtPharoCoderPackage >> affectByPackageRenamed: aRPackageRenamed [
	^ self subclassResponsibility
]

{ #category : #transformation }
GtPharoCoderPackage >> affectByPackageUnregistered: aRPackageUnregistered [
	^ self subclassResponsibility
]

{ #category : #testing }
GtPharoCoderPackage >> affectedByPackageRegistered: aRPackageRegistered [
	^ self subclassResponsibility
]

{ #category : #testing }
GtPharoCoderPackage >> affectedByPackageRenamed: aRPackageRenamed [
	^ self subclassResponsibility
]

{ #category : #testing }
GtPharoCoderPackage >> affectedByPackageUnregistered: aRPackageUnregistered [
	^ self subclassResponsibility
]

{ #category : #testing }
GtPharoCoderPackage >> exists [
	"Return true if there is a real package in the system corresponding to my definition"
	<return: #Boolean>
	
	^ self subclassResponsibility
]

{ #category : #accessing }
GtPharoCoderPackage >> packageNameDo: aBlock [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtPharoCoderPackage >> packageNameDo: aBlock ifAbsent: anAbsentBlock [
	self packageNameDo: [ :aBehavior | ^ aBlock value: aBehavior ].
	^ anAbsentBlock value
]

{ #category : #accessing }
GtPharoCoderPackage >> realPackageDo: aBlock [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtPharoCoderPackage >> realPackageDo: aBlock ifAbsent: anAbsentBlock [
	self realPackageDo: [ :aBehavior | ^ aBlock value: aBehavior ].
	^ anAbsentBlock value
]

{ #category : #accessing }
GtPharoCoderPackage >> renamePackageTo: aNewName [
	self subclassResponsibility
]

{ #category : #accessing }
GtPharoCoderPackage >> tags [
	<return: #Collection of: #PackageTag>

	^ self explicitRequirement
]
