Class {
	#name : #GtSearchSubclassResponsibilityMethodsFilter,
	#superclass : #GtSearchMethodsFilter,
	#category : #'GToolkit-Pharo-SearchFilters-Filters'
}

{ #category : #testing }
GtSearchSubclassResponsibilityMethodsFilter >> includesMethod: aCompiledMethod [
	^ aCompiledMethod isAbstract
]

{ #category : #storing }
GtSearchSubclassResponsibilityMethodsFilter >> storeCreationCodeOn: aStream [
	aStream
		nextPutAll: self class name;
		nextPutAll: ' new'.
]
