Class {
	#name : #GtSearchMethodAdviceFilter,
	#superclass : #GtSearchMethodsFilter,
	#instVars : [
		'advice'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-MethodAdvices'
}

{ #category : #accessing }
GtSearchMethodAdviceFilter >> advice: aMethodAdvice [
	advice := aMethodAdvice
]

{ #category : #accessing }
GtSearchMethodAdviceFilter >> defaultFilterScope [
	^ advice potentialFilter ifNil: [ super defaultFilterScope ]
]

{ #category : #testing }
GtSearchMethodAdviceFilter >> includesMethod: aCompiledMethod [
	^ GtSearchMethodAdviceFilterRunner does: advice includeMethod: aCompiledMethod
]
