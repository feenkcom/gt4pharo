Class {
	#name : #GtSearchDeprecatedMethodsFilter,
	#superclass : #GtSearchMethodsFilter,
	#category : #'GToolkit-Pharo-SearchFilters-Filters'
}

{ #category : #comparing }
GtSearchDeprecatedMethodsFilter >> = anObject [
	^ self class = anObject class
]

{ #category : #comparing }
GtSearchDeprecatedMethodsFilter >> hash [
	^ self class hash
]

{ #category : #testing }
GtSearchDeprecatedMethodsFilter >> includesMethod: aMethod [
	^ aMethod isFromTrait not and: [ aMethod isDeprecated ]
]
