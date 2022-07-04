Class {
	#name : #GtSearchImplementorsFilter,
	#superclass : #GtSearchMethodsFilter,
	#instVars : [
		'selector'
	],
	#category : #'GToolkit-Pharo-SearchFilters-Filters'
}

{ #category : #accessing }
GtSearchImplementorsFilter class >> classImplementorsExample [
	<gtExample>
	
	| filter |
	filter := self new selector: thisContext selector.
	self assert: (filter contents includes: thisContext method).
	^ filter
]

{ #category : #'instance creation' }
GtSearchImplementorsFilter class >> selector: aSymbol [
	^ self new
		selector: aSymbol;
		yourself
]

{ #category : #comparing }
GtSearchImplementorsFilter >> = anObject [
	^ self class = anObject class
		and: [ self selector = anObject selector ]
]

{ #category : #accessing }
GtSearchImplementorsFilter >> defaultFilterScope [
	| implementers |
	implementers := GtPharoIndex current implementersOf: selector.
	
	"50,000 items sort in less < 1/2 second so it should be quick enough for searching in coder"
	implementers size < 50000
		ifTrue: [ implementers sort: GtMethodsSortFunction new ].
	^ implementers asAsyncStream
]

{ #category : #ui }
GtSearchImplementorsFilter >> gtDisplayOn: stream [
	stream
		nextPutAll: self selector printString;
		nextPutAll: ' implementors'
]

{ #category : #comparing }
GtSearchImplementorsFilter >> hash [
	^ self class hash bitXor: self selector hash
]

{ #category : #testing }
GtSearchImplementorsFilter >> includesMethod: aCompiledMethod [
	^ aCompiledMethod selector = selector
]

{ #category : #ui }
GtSearchImplementorsFilter >> printOn: stream [
	stream 
		nextPutAll: self selector printString; 
		nextPutAll: ' gtImplementors'
]

{ #category : #accessing }
GtSearchImplementorsFilter >> selector [
	^ selector
]

{ #category : #accessing }
GtSearchImplementorsFilter >> selector: aSymbol [
	selector := aSymbol
]

{ #category : #accessing }
GtSearchImplementorsFilter >> shouldFilterOutTraitMethods [
	^ true
]
