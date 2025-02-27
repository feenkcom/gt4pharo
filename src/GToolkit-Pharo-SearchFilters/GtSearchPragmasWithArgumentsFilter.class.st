Class {
	#name : #GtSearchPragmasWithArgumentsFilter,
	#superclass : #GtSearchPragmasFilter,
	#instVars : [
		'arguments'
	],
	#category : #'GToolkit-Pharo-SearchFilters-Filters'
}

{ #category : #'instance creation' }
GtSearchPragmasWithArgumentsFilter class >> forPragma: aSymbol withArguments: anArray [
	^ self new
		symbol: aSymbol;
		arguments: anArray
]

{ #category : #accessing }
GtSearchPragmasWithArgumentsFilter >> arguments [
	^ arguments
]

{ #category : #accessing }
GtSearchPragmasWithArgumentsFilter >> arguments: anObject [
	arguments := anObject
]

{ #category : #accessing }
GtSearchPragmasWithArgumentsFilter >> includesMethod: aCompiledMethod [
	symbol ifNil: [ ^ true ].
	^ (super includesMethod: aCompiledMethod)
		and: [ (aCompiledMethod pragmaAt: symbol) arguments includesAll: self arguments ]
]

{ #category : #accessing }
GtSearchPragmasWithArgumentsFilter >> initialize [
	arguments := {}
]
