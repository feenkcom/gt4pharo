Class {
	#name : #GtSearchDefinedMethodsFilter,
	#superclass : #GtSearchMethodsFilter,
	#category : #'GToolkit-Pharo-SearchFilters-Filters'
}

{ #category : #testing }
GtSearchDefinedMethodsFilter >> includesMethod: aCompiledMethod [
	^ aCompiledMethod isAbstract not
]
