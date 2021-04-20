Class {
	#name : #GtPharoPackagesCoder,
	#superclass : #GtPackagesCoder,
	#category : #'GToolkit-Pharo-Coder-Coders'
}

{ #category : #'instance creation' }
GtPharoPackagesCoder class >> forAllPackages [
	^ self forPackages: RPackageOrganizer default packages
]

{ #category : #'instance creation' }
GtPharoPackagesCoder class >> forPackages: aCollectionOfPackages [
	^ self forItems: (aCollectionOfPackages asSortedCollection: [ :a :b | a name < b name ])
]

{ #category : #private }
GtPharoPackagesCoder >> newCoderFor: aPackage [
	^ GtPharoPackageCoder forPackage: aPackage
]
