Class {
	#name : #GtSearchClassMethodsFilter,
	#superclass : #GtSearchMethodsFilter,
	#category : #'GToolkit-Pharo-SearchFilters-Filters'
}

{ #category : #comparing }
GtSearchClassMethodsFilter >> = anObject [
	^ self class = anObject class
]

{ #category : #printing }
GtSearchClassMethodsFilter >> gtDisplayOn: stream [
	stream nextPutAll: 'class methods'
]

{ #category : #comparing }
GtSearchClassMethodsFilter >> hash [
	^ self class hash
]

{ #category : #testing }
GtSearchClassMethodsFilter >> includesMethod: aCompiledMethod [
	^ aCompiledMethod methodClass isClassSide
]
