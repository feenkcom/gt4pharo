Class {
	#name : #GtSearchInstanceMethodsFilter,
	#superclass : #GtSearchMethodsFilter,
	#category : #'GToolkit-Pharo-SearchFilters-Filters'
}

{ #category : #comparing }
GtSearchInstanceMethodsFilter >> = anObject [
	^ self class = anObject class
]

{ #category : #accessing }
GtSearchInstanceMethodsFilter >> filterType [
	^ GtSearchClassMethodsFilter
]

{ #category : #printing }
GtSearchInstanceMethodsFilter >> gtDisplayOn: stream [
	stream nextPutAll: 'instance methods'
]

{ #category : #comparing }
GtSearchInstanceMethodsFilter >> hash [
	^ self class hash
]

{ #category : #testing }
GtSearchInstanceMethodsFilter >> includesMethod: aCompiledMethod [
	^ aCompiledMethod methodClass isInstanceSide
]
