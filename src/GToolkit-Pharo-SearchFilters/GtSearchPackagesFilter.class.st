Class {
	#name : #GtSearchPackagesFilter,
	#superclass : #GtSearchTypedEntitiesFilter,
	#category : #'GToolkit-Pharo-SearchFilters-Filters'
}

{ #category : #accessing }
GtSearchPackagesFilter class >> resultType [
	^ GtAsyncSearchPackageGroupStream 
]

{ #category : #accessing }
GtSearchPackagesFilter >> defaultFilterScope [
	^ AsyncImagePackagesStream new
]

{ #category : #testing }
GtSearchPackagesFilter >> includesPackage: aPackage [
	self subclassResponsibility
]

{ #category : #testing }
GtSearchPackagesFilter >> matches: anObject [
	^ (anObject isPharoPackageModel) and: [ self includesPackage: anObject ]
]
