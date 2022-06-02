Class {
	#name : #GtCachedSearchReferencesFilter,
	#superclass : #GtSearchReferencesFilter,
	#category : #'GToolkit-Pharo-SearchFilters-Filters'
}

{ #category : #accessing }
GtCachedSearchReferencesFilter >> defaultFilterScope [
	"Only works for selectors and global variables"

	| references |
	references := object isSymbol
			ifTrue: [ GtPharoCompletionStrategy sendersOf: object ]
			ifFalse: [ GtPharoCompletionStrategy globalVariableReferencesTo: object ].
	
	"50,000 items sort in less < 1/2 second so it should be quick enough for searching in coder" 
	references size < 50000 ifTrue: [ references sort: GtMethodsSortFunction new ].
	^ references asAsyncStream
]
