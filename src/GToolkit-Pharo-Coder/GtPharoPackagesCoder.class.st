Class {
	#name : #GtPharoPackagesCoder,
	#superclass : #GtPackagesCoder,
	#category : #'GToolkit-Pharo-Coder-Coders'
}

{ #category : #'instance creation' }
GtPharoPackagesCoder class >> forAllPackages [
	^ self forPackages: self packageOrganizer gtSortedPackages
]

{ #category : #'instance creation' }
GtPharoPackagesCoder class >> forPackages: aCollectionOfPackages [
	^ self forItems: aCollectionOfPackages
]

{ #category : #private }
GtPharoPackagesCoder >> asNewCoderModelWithSameSubject [
	"Return new coder model with same subject (e.g., package, class, method)"

	<return: #GtCoderModel>
	^ self class forItems: items
]

{ #category : #private }
GtPharoPackagesCoder >> newCoderFor: aPackage [
	^ GtPharoPackageCoder forPackage: aPackage
]
