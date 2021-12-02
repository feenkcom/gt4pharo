Class {
	#name : #GtSearchOverriddenMethodsFilter,
	#superclass : #GtSearchMethodsFilter,
	#instVars : [
		'method'
	],
	#category : #'GToolkit-Pharo-Coder-Filters'
}

{ #category : #converting }
GtSearchOverriddenMethodsFilter >> asAsyncStream [
	^ self defaultFilterScope
]

{ #category : #accessing }
GtSearchOverriddenMethodsFilter >> defaultFilterScope [
	^ AsyncOverriddenMethodsStream forCompiledMethod: method
]

{ #category : #testing }
GtSearchOverriddenMethodsFilter >> includesMethod: aCompiledMethod [
	"Does method override aCompiledMethod?"
	
	aCompiledMethod = method
		ifTrue: [ ^ false ].
		
	aCompiledMethod selector = method selector
		ifFalse: [ ^ false ].
		
	method methodClass
		allSuperclassesDo: [ :eachSuperclass |
			eachSuperclass = aCompiledMethod methodClass
				ifTrue: [ ^ true ] ].

	^ false
]

{ #category : #accessing }
GtSearchOverriddenMethodsFilter >> method [

	^ method
]

{ #category : #accessing }
GtSearchOverriddenMethodsFilter >> method: anObject [

	method := anObject
]
