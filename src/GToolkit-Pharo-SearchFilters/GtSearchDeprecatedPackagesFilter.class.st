Class {
	#name : #GtSearchDeprecatedPackagesFilter,
	#superclass : #GtSearchPackagesFilter,
	#category : #'GToolkit-Pharo-SearchFilters-Filters'
}

{ #category : #testing }
GtSearchDeprecatedPackagesFilter >> includesPackage: aPackage [
	^ aPackage isDeprecated
]

{ #category : #storing }
GtSearchDeprecatedPackagesFilter >> storeCreationCodeOn: aStream [
	aStream
		nextPutAll: self class name;
		nextPutAll: ' new'.
]
