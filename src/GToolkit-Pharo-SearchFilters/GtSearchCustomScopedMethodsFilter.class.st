Class {
	#name : #GtSearchCustomScopedMethodsFilter,
	#superclass : #GtSearchMethodsFilter,
	#instVars : [
		'defaultFilterScope',
		'label'
	],
	#category : #'GToolkit-Pharo-SearchFilters-Filters'
}

{ #category : #accesing }
GtSearchCustomScopedMethodsFilter >> defaultFilterScope [
	^ defaultFilterScope ifNil: [
		super defaultFilterScope ]
]

{ #category : #accesing }
GtSearchCustomScopedMethodsFilter >> defaultFilterScope: aFilterScope [
	defaultFilterScope := aFilterScope
]

{ #category : #'as yet unclassified' }
GtSearchCustomScopedMethodsFilter >> filterLabel [
	^ label
]

{ #category : #'as yet unclassified' }
GtSearchCustomScopedMethodsFilter >> filterLabel: aLabel [
	label := aLabel
]

{ #category : #printing }
GtSearchCustomScopedMethodsFilter >> gtDisplayOn: stream [
	label
		ifNil: [ super gtDisplayOn: stream ]
		ifNotNil: [ :aLabel |
			stream
				nextPutAll: aLabel ]
]

{ #category : #'as yet unclassified' }
GtSearchCustomScopedMethodsFilter >> includesMethod: aCompiledMethod [
	^ true 
]
