Class {
	#name : #GtSearchOverridingMethodsFilter,
	#superclass : #GtSearchMethodsFilter,
	#instVars : [
		'method'
	],
	#category : #'GToolkit-Pharo-Coder-Filters'
}

{ #category : #converting }
GtSearchOverridingMethodsFilter >> asAsyncStream [
	^ self defaultFilterScope
]

{ #category : #accessing }
GtSearchOverridingMethodsFilter >> defaultFilterScope [
	^ AsyncOverridingMethodsStream forCompiledMethod: method
]

{ #category : #testing }
GtSearchOverridingMethodsFilter >> includesMethod: aCompiledMethod [
	"Does aCompiledMethod override the method"
	
	aCompiledMethod = method
		ifTrue: [ ^ false ].
		
	aCompiledMethod selector = method selector
		ifFalse: [ ^ false ].
		
	aCompiledMethod methodClass
		allSuperclassesDo: [ :eachSuperclass |
			eachSuperclass = method methodClass
				ifTrue: [ ^ true ] ].

	^ false
]

{ #category : #accessing }
GtSearchOverridingMethodsFilter >> method [

	^ method
]

{ #category : #accessing }
GtSearchOverridingMethodsFilter >> method: anObject [

	method := anObject
]
