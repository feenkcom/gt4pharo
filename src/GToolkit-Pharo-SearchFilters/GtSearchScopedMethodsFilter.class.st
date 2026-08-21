Class {
	#name : #GtSearchScopedMethodsFilter,
	#superclass : #GtSearchMethodsFilter,
	#instVars : [
		'scope'
	],
	#category : #'GToolkit-Pharo-SearchFilters-Filters'
}

{ #category : #comparing }
GtSearchScopedMethodsFilter >> = anObject [
	^ super = anObject and: [ self scope = anObject scope ]
]

{ #category : #comparing }
GtSearchScopedMethodsFilter >> hash [
	^ super hash bitXor: self scope hash
]

{ #category : #testing }
GtSearchScopedMethodsFilter >> includesMethod: aCompiledMethod [
	scope ifNil: [ ^ true ].
	^ scope includesMethod: aCompiledMethod
]

{ #category : #initialization }
GtSearchScopedMethodsFilter >> initialize [
	super initialize.
	scope := GtSearchScopedMethodsAllScope default
]

{ #category : #accessing }
GtSearchScopedMethodsFilter >> scope [
	<return: #GtSearchScopedMethodsScope>
	^ scope
]

{ #category : #accessing }
GtSearchScopedMethodsFilter >> scope: anObject [
	scope := anObject
]

{ #category : #storing }
GtSearchScopedMethodsFilter >> storeCreationCodeOn: aStream [
	aStream
		nextPutAll: self class name;
		nextPutAll: ' new scope: '.
	aStream parenthesize: [ self scope storeCreationCodeOn: aStream ]
]
