Class {
	#name : 'GtSearchPackagesFilter',
	#superclass : 'GtSearchTypedEntitiesFilter',
	#category : 'GToolkit-Pharo-Coder-Filters'
}

{ #category : 'accessing' }
GtSearchPackagesFilter class >> resultType [
	^ GtSearchPackageGroupResult 
]

{ #category : 'accessing' }
GtSearchPackagesFilter class >> resultTypeStream [
	^ GtAsyncSearchPackageGroupStream 
]

{ #category : 'accessing' }
GtSearchPackagesFilter >> defaultFilterScope [
	^ GtSearchImagePackagesFilter new
]

{ #category : 'accessing' }
GtSearchPackagesFilter >> defaultFilterScopeStream [
	^ AsyncImagePackagesStream new
]

{ #category : 'testing' }
GtSearchPackagesFilter >> includesPackage: aPackage [
	self subclassResponsibility
]

{ #category : 'testing' }
GtSearchPackagesFilter >> matches: anObject [
	^ anObject class = RPackage and: [ 
		self includesPackage: anObject ]
]
