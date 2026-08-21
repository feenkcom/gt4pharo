"
Common creation-code assertions for search filter examples.
"
Class {
	#name : #GtSearchFiltersCreationStringExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-SearchFilters-Examples'
}

{ #category : #asserting }
GtSearchFiltersCreationStringExamples >> assertCreatioCodeFor: aFilter equals: aString [
	|creationCode  codeString |
	creationCode := self creationCodeForFilter:aFilter.
	codeString := creationCode codeString.
	self assert: (RBParser parseExpression: codeString) formattedCode
		equals: (RBParser parseExpression: aString) formattedCode.
	^ creationCode
]

{ #category : #asserting }
GtSearchFiltersCreationStringExamples >> creationCodeForFilter: aFilter [
	^ aFilter creationCode
]
