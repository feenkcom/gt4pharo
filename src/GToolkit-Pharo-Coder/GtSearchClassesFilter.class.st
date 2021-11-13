Class {
	#name : #GtSearchClassesFilter,
	#superclass : #GtSearchTypedEntitiesFilter,
	#category : #'GToolkit-Pharo-Coder-Filters'
}

{ #category : #accessing }
GtSearchClassesFilter class >> resultType [
	^ GtAsyncSearchClassGroupStream
]

{ #category : #accessing }
GtSearchClassesFilter >> defaultFilterScope [
	^ AsyncImageBehaviorsStream new
]

{ #category : #testing }
GtSearchClassesFilter >> includesClass: aClass [
	self subclassResponsibility
]

{ #category : #testing }
GtSearchClassesFilter >> matches: anObject [
	^ (anObject isClass or: [ anObject isTrait ]) and: [ self includesClass: anObject ]
]
