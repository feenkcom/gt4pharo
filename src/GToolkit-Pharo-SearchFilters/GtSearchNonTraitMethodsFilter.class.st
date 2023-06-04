Class {
	#name : #GtSearchNonTraitMethodsFilter,
	#superclass : #GtSearchMethodsFilter,
	#category : #'GToolkit-Pharo-SearchFilters-Filters'
}

{ #category : #comparing }
GtSearchNonTraitMethodsFilter >> = anObject [
	^ self class = anObject class
]

{ #category : #comparing }
GtSearchNonTraitMethodsFilter >> hash [
	^ self class hash
]

{ #category : #testing }
GtSearchNonTraitMethodsFilter >> includesMethod: aCompiledMethod [
	^ aCompiledMethod isFromTrait not
]
