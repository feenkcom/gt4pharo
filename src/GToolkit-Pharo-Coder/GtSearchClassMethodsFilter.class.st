Class {
	#name : #GtSearchClassMethodsFilter,
	#superclass : #GtSearchMethodsFilter,
	#category : #'GToolkit-Pharo-Coder-Filters'
}

{ #category : #comparing }
GtSearchClassMethodsFilter >> = anObject [
	^ self class = anObject class
]

{ #category : #comparing }
GtSearchClassMethodsFilter >> hash [
	^ self class hash
]

{ #category : #testing }
GtSearchClassMethodsFilter >> includesMethod: aCompiledMethod [
	^ aCompiledMethod methodClass isClassSide
]
