Class {
	#name : #GtSearchInheritedMethodsFilter,
	#superclass : #GtSearchMethodsInClassFilter,
	#category : #'GToolkit-Pharo-SearchFilters-Filters'
}

{ #category : #accessing }
GtSearchInheritedMethodsFilter >> defaultFilterScope [
	^ AsyncBehaviorAllSortedInheritedMethodsStream forBehavior: class
]

{ #category : #accessing }
GtSearchInheritedMethodsFilter >> filterValueString [
	^ upToSuperclass name
]
