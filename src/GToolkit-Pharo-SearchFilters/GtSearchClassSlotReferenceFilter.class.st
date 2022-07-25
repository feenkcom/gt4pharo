Class {
	#name : #GtSearchClassSlotReferenceFilter,
	#superclass : #GtSearchReferencesFilter,
	#instVars : [
		'class',
		'variableName'
	],
	#category : #'GToolkit-Pharo-SearchFilters-Filters'
}

{ #category : #'instance creation' }
GtSearchClassSlotReferenceFilter class >> createFilterFor: aMethodCoder [
	^ self forClass: aMethodCoder classOrMetaClass
]

{ #category : #'instance creation' }
GtSearchClassSlotReferenceFilter class >> forClass: aClass [
	^ self new
		forClass: aClass;
		yourself
]

{ #category : #'instance creation' }
GtSearchClassSlotReferenceFilter class >> forClass: aClass andVariable: aString [
	^ (self forClass: aClass)
		variableName: aString;
		yourself
]

{ #category : #accessing }
GtSearchClassSlotReferenceFilter >> filterValueString [
	^ self variableName
]

{ #category : #'initialize-release' }
GtSearchClassSlotReferenceFilter >> forClass: aClass [
	class := aClass
]

{ #category : #testing }
GtSearchClassSlotReferenceFilter >> includesMethod: aCompiledMethod [
	self object isNil
		ifTrue: [ ^ false ].
	^ super includesMethod: aCompiledMethod
]

{ #category : #accessing }
GtSearchClassSlotReferenceFilter >> object [
	object
		ifNil: [ object := class bindingOf: variableName.
			isVariable := object isKindOf: Variable ].
	^ object
]

{ #category : #accessing }
GtSearchClassSlotReferenceFilter >> variableName [
	^ variableName
]

{ #category : #accessing }
GtSearchClassSlotReferenceFilter >> variableName: aSymbol [
	variableName := aSymbol asSymbol.
	object := nil
]
