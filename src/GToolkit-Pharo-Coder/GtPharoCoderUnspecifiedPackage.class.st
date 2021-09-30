Class {
	#name : #GtPharoCoderUnspecifiedPackage,
	#superclass : #GtPharoCoderPackage,
	#category : 'GToolkit-Pharo-Coder-Meta'
}

{ #category : #transformation }
GtPharoCoderUnspecifiedPackage >> affectByPackageRegistered: aRPackageRegistered [
	^ self
]

{ #category : #transformation }
GtPharoCoderUnspecifiedPackage >> affectByPackageRenamed: aRPackageRenamed [
	^ self
]

{ #category : #transformation }
GtPharoCoderUnspecifiedPackage >> affectByPackageUnregistered: aRPackageUnregistered [
	^ self
]

{ #category : #testing }
GtPharoCoderUnspecifiedPackage >> affectedByPackageRegistered: aRPackageRegistered [
	^ false
]

{ #category : #testing }
GtPharoCoderUnspecifiedPackage >> affectedByPackageRenamed: aRPackageRenamed [
	^ false
]

{ #category : #testing }
GtPharoCoderUnspecifiedPackage >> affectedByPackageUnregistered: aRPackageUnregistered [
	^ false
]

{ #category : #testing }
GtPharoCoderUnspecifiedPackage >> exists [
	"Return true if there is a real package in the system corresponding to my definition"
	<return: #Boolean>
	
	^ false
]

{ #category : #accessing }
GtPharoCoderUnspecifiedPackage >> packageNameDo: aBlock [
	^ nil
]

{ #category : #accessing }
GtPharoCoderUnspecifiedPackage >> realPackageDo: aBlock [
	^ nil
]

{ #category : #accessing }
GtPharoCoderUnspecifiedPackage >> renamePackageTo: aNewName [
]
