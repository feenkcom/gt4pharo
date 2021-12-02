Class {
	#name : #GtSearchTestClassesFilter,
	#superclass : #GtSearchClassesFilter,
	#category : #'GToolkit-Pharo-SearchFilters-Filters'
}

{ #category : #comparing }
GtSearchTestClassesFilter >> = anObject [
	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ true
]

{ #category : #comparing }
GtSearchTestClassesFilter >> hash [
	^ self class hash
]

{ #category : #testing }
GtSearchTestClassesFilter >> includesClass: aClass [
	^ aClass isTestCase
]
