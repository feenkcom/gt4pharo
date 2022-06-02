Class {
	#name : #GtCachedSearchReferencesFilter,
	#superclass : #GtSearchReferencesFilter,
	#category : #'GToolkit-Pharo-SearchFilters-Filters'
}

{ #category : #examples }
GtCachedSearchReferencesFilter class >> combinedReferencesExample [
	<gtExample>
	
	| baz combined |
	baz := ('b' , 'az') asSymbol.
	combined := #foo gtReferences & #bar gtReferences.
	self assert: (combined contents includes: thisContext method).
	self
		assert: ((#foo gtReferences & baz gtReferences) contents includes: thisContext method)
				not.
	^ combined
]

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
