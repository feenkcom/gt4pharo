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
	| creationCode |
	creationCode := aFilter creationCode.
	self assert: (RBParser parseExpression: creationCode) formattedCode
		equals: (RBParser parseExpression: aString) formattedCode.
	^ self wrappedCreationCodeFor: aFilter
]

{ #category : #asserting }
GtSearchFiltersCreationStringExamples >> wrappedCreationCodeFor: aFilter [
	^ LePharoSnippet code: (RBParser 
			parseExpression: aFilter creationCode) formattedCode
]
