Class {
	#name : #GtSearchSubclassResponsibilityMethodsFilter,
	#superclass : #GtSearchMethodsFilter,
	#category : #'GToolkit-Pharo-SearchFilters-Filters'
}

{ #category : #testing }
GtSearchSubclassResponsibilityMethodsFilter >> includesMethod: aCompiledMethod [
	^ aCompiledMethod isAbstract
]
