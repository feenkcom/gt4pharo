Class {
	#name : #GtCachedSearchReferencesFilter,
	#superclass : #GtSearchReferencesFilter,
	#category : #'GToolkit-Pharo-SearchFilters-Filters'
}

{ #category : #accessing }
GtCachedSearchReferencesFilter >> defaultFilterScope [
	"Only works for selectors and global variables"

	^ ((object isSymbol
		ifTrue: [ GtPharoCompletionStrategy sendersOf: object ]
		ifFalse: [ GtPharoCompletionStrategy globalVariableReferencesTo: object ])
		sorted: GtMethodsSortFunction new) asAsyncStream
]

{ #category : #testing }
GtCachedSearchReferencesFilter >> includesMethod: aCompiledMethod [
	^ true
]
