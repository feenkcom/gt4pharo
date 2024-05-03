Class {
	#name : #GtSearchMethodsInInstanceAndClassSideFilter,
	#superclass : #GtSearchMethodsContainedInClassFilter,
	#category : #'GToolkit-Pharo-SearchFilters-Filters'
}

{ #category : #printing }
GtSearchMethodsInInstanceAndClassSideFilter >> gtDisplayOn: stream [
	stream
		print: filterClass;
		nextPutAll: ' methodsInBothClassSides'
]

{ #category : #testing }
GtSearchMethodsInInstanceAndClassSideFilter >> includesMethod: aCompiledMethod [
	| methodClass |
	methodClass := aCompiledMethod methodClass.
	^ (methodClass = filterClass instanceSide) or: [ 
		methodClass = filterClass classSide ]
]

{ #category : #enumerating }
GtSearchMethodsInInstanceAndClassSideFilter >> methodsDo: aBlock [
	filterClass instanceSide methods do: aBlock.

	"#methods includes ones from TraitedClass"
	filterClass classSide visibleMethods do: aBlock
]
