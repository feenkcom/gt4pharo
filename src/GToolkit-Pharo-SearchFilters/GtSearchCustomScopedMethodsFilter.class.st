Class {
	#name : #GtSearchCustomScopedMethodsFilter,
	#superclass : #GtSearchMethodsFilter,
	#instVars : [
		'defaultFilterScope',
		'label',
		'highlighter'
	],
	#category : #'GToolkit-Pharo-SearchFilters-Filters'
}

{ #category : #accessing }
GtSearchCustomScopedMethodsFilter >> defaultFilterScope [
	^ defaultFilterScope ifNil: [
		super defaultFilterScope ]
]

{ #category : #accessing }
GtSearchCustomScopedMethodsFilter >> defaultFilterScope: aFilterScope [
	defaultFilterScope := aFilterScope
]

{ #category : #accessing }
GtSearchCustomScopedMethodsFilter >> filterLabel [
	^ label
]

{ #category : #accessing }
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

{ #category : #accessing }
GtSearchCustomScopedMethodsFilter >> highlighter [
	^ highlighter
]

{ #category : #accessing }
GtSearchCustomScopedMethodsFilter >> highlighter: aHighlighter [
	highlighter := aHighlighter
]

{ #category : #testing }
GtSearchCustomScopedMethodsFilter >> includesMethod: aCompiledMethod [
	^ true 
]
