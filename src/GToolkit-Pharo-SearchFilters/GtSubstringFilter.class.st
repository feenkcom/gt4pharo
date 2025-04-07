Class {
	#name : #GtSubstringFilter,
	#superclass : #GtSearchMethodsFilter,
	#instVars : [
		'substring',
		'includesNotSearchableMethods'
	],
	#category : #'GToolkit-Pharo-SearchFilters-Filters'
}

{ #category : #'instance creation' }
GtSubstringFilter class >> substring: aString [
	^ self new substring: aString
]

{ #category : #comparing }
GtSubstringFilter >> = anObject [
	^ self class = anObject class
		and: [ self substring asLowercase = anObject substring asLowercase ]
]

{ #category : #configuring }
GtSubstringFilter >> excludeNotSearchableMethods [
	includesNotSearchableMethods := false
]

{ #category : #accessing }
GtSubstringFilter >> filterValueString [
	^ self substring
]

{ #category : #printing }
GtSubstringFilter >> gtDisplayOn: stream [
	stream
		print: self substring;
		nextPutAll: ' substringMatch'
]

{ #category : #comparing }
GtSubstringFilter >> hash [
	^ self class hash bitXor: self substring asLowercase hash
]

{ #category : #configuring }
GtSubstringFilter >> includeNotSearchableMethods [
	includesNotSearchableMethods := true
]

{ #category : #testing }
GtSubstringFilter >> includesMethod: aCompiledMethod [
	(self shouldExcludeNotSearchableMethods and: [
		aCompiledMethod isSourceSearchable not ])  ifTrue: [ ^ false ].
		
	^ (aCompiledMethod sourceCode
		findString: self substring
		startingAt: 1
		caseSensitive: false) > 0
]

{ #category : #printing }
GtSubstringFilter >> printOn: aStream [
	aStream
		print: self substring;
		nextPutAll: ' gtSubstringMatch'
]

{ #category : #testing }
GtSubstringFilter >> shouldExcludeNotSearchableMethods [
	^ self shouldIncludeNotSearchableMethods not
]

{ #category : #testing }
GtSubstringFilter >> shouldIncludeNotSearchableMethods [
	^ includesNotSearchableMethods ifNil: [ false ]
]

{ #category : #accessing }
GtSubstringFilter >> substring [
	^ substring
]

{ #category : #accessing }
GtSubstringFilter >> substring: aString [
	substring := aString
]
