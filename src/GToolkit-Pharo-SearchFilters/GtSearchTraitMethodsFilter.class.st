Class {
	#name : #GtSearchTraitMethodsFilter,
	#superclass : #GtSearchMethodsFilter,
	#category : #'GToolkit-Pharo-SearchFilters-Filters'
}

{ #category : #comparing }
GtSearchTraitMethodsFilter >> = anObject [
	^ self class = anObject class
]

{ #category : #accessing }
GtSearchTraitMethodsFilter >> filterType [
	^ GtSearchNonTraitMethodsFilter
]

{ #category : #comparing }
GtSearchTraitMethodsFilter >> hash [
	^ self class hash
]

{ #category : #testing }
GtSearchTraitMethodsFilter >> includesMethod: aCompiledMethod [
	^ aCompiledMethod isFromTrait
]
