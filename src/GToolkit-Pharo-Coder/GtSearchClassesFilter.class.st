Class {
	#name : #GtSearchClassesFilter,
	#superclass : #GtSearchTypedEntitiesFilter,
	#category : #'GToolkit-Pharo-Coder-Filters'
}

{ #category : #accessing }
GtSearchClassesFilter class >> resultType [
	^ GtSearchClassGroupResult
]

{ #category : #accessing }
GtSearchClassesFilter >> defaultFilterScope [
	^ GtSearchImageClassesFilter new
]

{ #category : #testing }
GtSearchClassesFilter >> includesClass: aClass [
	self subclassResponsibility
]

{ #category : #testing }
GtSearchClassesFilter >> matches: anObject [
	^ anObject isClass and: [ 
		self includesClass: anObject ]
]
