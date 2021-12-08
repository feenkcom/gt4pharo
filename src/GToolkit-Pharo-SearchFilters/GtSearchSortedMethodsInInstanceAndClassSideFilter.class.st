Class {
	#name : #GtSearchSortedMethodsInInstanceAndClassSideFilter,
	#superclass : #GtSearchMethodsContainedInClassFilter,
	#category : #'GToolkit-Pharo-SearchFilters-Filters'
}

{ #category : #accessing }
GtSearchSortedMethodsInInstanceAndClassSideFilter >> defaultFilterScope [
	^ AsyncBehaviorAllSortedMethodsStream forBehavior: class
]

{ #category : #testing }
GtSearchSortedMethodsInInstanceAndClassSideFilter >> includesMethod: aCompiledMethod [
	| methodClass |
	methodClass := aCompiledMethod methodClass.
	^ (methodClass = class instanceSide) or: [ 
		methodClass = class classSide ]
]

{ #category : #enumerating }
GtSearchSortedMethodsInInstanceAndClassSideFilter >> methodsDo: aBlock [
	class instanceSide methods do: aBlock.

	"#methods includes ones from TraitedClass"
	class classSide visibleMethods do: aBlock
]
