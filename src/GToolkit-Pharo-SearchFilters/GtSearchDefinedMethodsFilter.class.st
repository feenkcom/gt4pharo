Class {
	#name : #GtSearchDefinedMethodsFilter,
	#superclass : #GtSearchMethodsFilter,
	#category : #'GToolkit-Pharo-SearchFilters-Filters'
}

{ #category : #accessing }
GtSearchDefinedMethodsFilter >> filterType [
	^ GtSearchSubclassResponsibilityMethodsFilter
]

{ #category : #testing }
GtSearchDefinedMethodsFilter >> includesMethod: aCompiledMethod [
	^ aCompiledMethod isAbstract not
]

{ #category : #storing }
GtSearchDefinedMethodsFilter >> storeCreationCodeOn: aStream [
	aStream
		nextPutAll: self class name;
		nextPutAll: ' new'.
]
