Class {
	#name : #GtSearchImageMethodsFilter,
	#superclass : #GtSearchMethodsFilter,
	#category : #'GToolkit-Pharo-SearchFilters-Filters'
}

{ #category : #accessing }
GtSearchImageMethodsFilter class >> allMethods [
	<gtSearchFilter>
	^ self new labeled: 'All Methods'
]

{ #category : #comparing }
GtSearchImageMethodsFilter >> = anObject [
	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ true
]

{ #category : #enumerating }
GtSearchImageMethodsFilter >> classesDo: aBlock [
	GtPharoSystemTraverser default allClassesAndTraitsDo: aBlock
]

{ #category : #accessing }
GtSearchImageMethodsFilter >> hash [
	^ self class hash
]

{ #category : #testing }
GtSearchImageMethodsFilter >> includesMethod: aCompiledMethod [
	^ true
]

{ #category : #enumerating }
GtSearchImageMethodsFilter >> itemsDo: aBlock [
	^ self methodsDo: aBlock
]

{ #category : #enumerating }
GtSearchImageMethodsFilter >> methodsDo: aBlock [
	self classesDo: [ :aClass |
		aClass instanceSide methods do: aBlock.
		aClass classSide methods do: aBlock. ]
]
