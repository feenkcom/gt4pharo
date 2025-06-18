Class {
	#name : #GtSearchImagePackagesFilter,
	#superclass : #GtSearchPackagesFilter,
	#category : #'GToolkit-Pharo-SearchFilters-Filters'
}

{ #category : #comparing }
GtSearchImagePackagesFilter >> = anObject [
	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ true
]

{ #category : #testing }
GtSearchImagePackagesFilter >> includesPackage: aPackage [
	^ self packageOrganizer includesPackage: aPackage 
]

{ #category : #enumerating }
GtSearchImagePackagesFilter >> itemsDo: aBlock [
	^ self packagesDo: aBlock
]

{ #category : #enumerating }
GtSearchImagePackagesFilter >> packagesDo: aBlock [
	RPackageOrganizer default packages do: aBlock
]
