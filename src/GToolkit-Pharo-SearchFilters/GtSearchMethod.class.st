Class {
	#name : #GtSearchMethod,
	#superclass : #Object,
	#instVars : [
		'method',
		'group'
	],
	#category : #'GToolkit-Pharo-SearchFilters-Filters'
}

{ #category : #accessing }
GtSearchMethod >> group [

	^ group
]

{ #category : #accessing }
GtSearchMethod >> group: aGroupResult [

	group := aGroupResult
]

{ #category : #accessing }
GtSearchMethod >> gtCodeStructureChildren [

	^ #(  )
]

{ #category : #accessing }
GtSearchMethod >> gtCodeStructureName [

	^ self method selector 
]

{ #category : #accessing }
GtSearchMethod >> gtFilter [
	^ self method
]

{ #category : #accessing }
GtSearchMethod >> method [

	^ method
]

{ #category : #accessing }
GtSearchMethod >> method: aMethod [

	method := aMethod
]
