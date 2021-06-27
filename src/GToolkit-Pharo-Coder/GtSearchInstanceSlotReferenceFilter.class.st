Class {
	#name : #GtSearchInstanceSlotReferenceFilter,
	#superclass : #GtSearchMethodsInClassFilter,
	#instVars : [
		'variableName'
	],
	#category : #'GToolkit-Pharo-Coder-Filters'
}

{ #category : #'instance creation' }
GtSearchInstanceSlotReferenceFilter class >> forClass: aClass andVariable: aString [
	^ self new
		forClass: aClass andVariable: aString;
		yourself
]

{ #category : #'instance creation' }
GtSearchInstanceSlotReferenceFilter class >> forClassAndSubclasses: aClass andVariable: aString [
	^ aClass withAllSubclasses
		inject: GtSearchNullFilter new
		into: [ :sum :each | sum | (self forClass: each andVariable: aString) ]
]

{ #category : #comparing }
GtSearchInstanceSlotReferenceFilter >> = anObject [
	^ super = anObject and: [ self variableName = anObject variableName ]
]

{ #category : #accessing }
GtSearchInstanceSlotReferenceFilter >> filterValueString [
	^ self variableName
]

{ #category : #'initialize-release' }
GtSearchInstanceSlotReferenceFilter >> forClass: aClass andVariable: aString [
	self forClass: aClass.
	variableName := aString
]

{ #category : #comparing }
GtSearchInstanceSlotReferenceFilter >> hash [
	^ super hash bitXor: self variableName
]

{ #category : #testing }
GtSearchInstanceSlotReferenceFilter >> includesMethod: aCompiledMethod [
	| index |
	(super includesMethod: aCompiledMethod)
		ifFalse: [ ^ false ].
	index := class instVarIndexFor: variableName ifAbsent: [ ^ false ].
	^ (aCompiledMethod readsField: index) or: [ aCompiledMethod writesField: index ]
]

{ #category : #'initialize-release' }
GtSearchInstanceSlotReferenceFilter >> initialize [
	super initialize.
	includeSubclasses := true
]

{ #category : #accessing }
GtSearchInstanceSlotReferenceFilter >> variableName [
	^ variableName
]

{ #category : #accessing }
GtSearchInstanceSlotReferenceFilter >> variableName: aString [
	variableName := aString
]
