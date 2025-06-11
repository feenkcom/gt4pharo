Class {
	#name : #GtSearchPragmasFilter,
	#superclass : #GtSearchMethodsFilter,
	#instVars : [
		'symbol'
	],
	#category : #'GToolkit-Pharo-SearchFilters-Filters'
}

{ #category : #'instance creation' }
GtSearchPragmasFilter class >> forPragma: aSymbol [
	^ self new
		symbol: aSymbol;
		yourself
]

{ #category : #comparing }
GtSearchPragmasFilter >> = anObject [
	^ self class = anObject class and: [ self symbol = anObject symbol ]
]

{ #category : #accessing }
GtSearchPragmasFilter >> filterValueString [
	^ self symbol
]

{ #category : #printing }
GtSearchPragmasFilter >> gtDisplayOn: stream [
	stream 
		nextPutAll: self symbol printString;
		nextPutAll: ' pragmas'
]

{ #category : #comparing }
GtSearchPragmasFilter >> hash [
	^ self class hash bitXor: self symbol hash
]

{ #category : #testing }
GtSearchPragmasFilter >> includesMethod: aCompiledMethod [
	symbol ifNil: [ ^ true ].
	^ aCompiledMethod hasPragmaNamed: symbol
]

{ #category : #testing }
GtSearchPragmasFilter >> isMethodPragmaFilter [
	^ self className = #GtSearchPragmasFilter
]

{ #category : #printing }
GtSearchPragmasFilter >> printOn: aStream [
	aStream 
		nextPutAll: self symbol printString;
		nextPutAll: ' gtPragmas'
]

{ #category : #accessing }
GtSearchPragmasFilter >> symbol [
	^ symbol
]

{ #category : #accessing }
GtSearchPragmasFilter >> symbol: aSymbol [
	symbol := aSymbol
]
