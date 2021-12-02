Class {
	#name : #GtSearchDeprecatedPackagesFilter,
	#superclass : #GtSearchPackagesFilter,
	#category : #'GToolkit-Pharo-SearchFilters-Filters'
}

{ #category : #testing }
GtSearchDeprecatedPackagesFilter >> includesPackage: aPackage [
	^ aPackage isDeprecated
]
