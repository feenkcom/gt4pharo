Class {
	#name : #GtSearchRBPatternFilter,
	#superclass : #GtSearchMethodsFilter,
	#instVars : [
		'pattern'
	],
	#category : #'GToolkit-Pharo-SearchFilters-Filters'
}

{ #category : #accessing }
GtSearchRBPatternFilter class >> pattern: aString [
	^ self new
		pattern: aString;
		yourself
]

{ #category : #comparing }
GtSearchRBPatternFilter >> = anObject [
	^ self class = anObject class
		and: [ self pattern = anObject pattern ]
]

{ #category : #accessing }
GtSearchRBPatternFilter >> filterValueString [
	^ self pattern
]

{ #category : #comparing }
GtSearchRBPatternFilter >> hash [
	^ self class hash bitXor: self pattern hash
]

{ #category : #testing }
GtSearchRBPatternFilter >> includesMethod: aCompiledMethod [
	(RBParseTreeSearcher
		treeMatching: self pattern
		in: aCompiledMethod ast) ifNotNil: [ ^ true ].
	^ false
]

{ #category : #accessing }
GtSearchRBPatternFilter >> pattern [
	^ pattern
]

{ #category : #accessing }
GtSearchRBPatternFilter >> pattern: anObject [
	pattern := anObject
]
