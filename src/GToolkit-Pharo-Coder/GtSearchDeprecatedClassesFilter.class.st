Class {
	#name : #GtSearchDeprecatedClassesFilter,
	#superclass : #GtSearchClassesFilter,
	#category : #'GToolkit-Pharo-Coder-Filters'
}

{ #category : #comparing }
GtSearchDeprecatedClassesFilter >> = anObject [
	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ true
]

{ #category : #comparing }
GtSearchDeprecatedClassesFilter >> hash [
	^ self class hash
]

{ #category : #testing }
GtSearchDeprecatedClassesFilter >> includesClass: aClass [
	^ aClass isDeprecated
]
