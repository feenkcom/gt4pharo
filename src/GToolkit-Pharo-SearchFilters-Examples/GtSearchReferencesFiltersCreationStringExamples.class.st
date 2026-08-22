"
Creation-code examples for reference search filters.
"
Class {
	#name : #GtSearchReferencesFiltersCreationStringExamples,
	#superclass : #GtSearchFiltersCreationStringExamples,
	#category : #'GToolkit-Pharo-SearchFilters-Examples'
}

{ #category : #'examples - specialized' }
GtSearchReferencesFiltersCreationStringExamples >> cachedReferencesFilterCreationCode [
	<gtExample>
	| filter |
	filter := GtCachedSearchReferencesFilter new object: #at:; yourself.
	self
		assertCreatioCodeFor: filter
		equals: '#at: gtReferences'.
	self assert: filter object equals: #at:.
	^ self creationCodeForFilter: filter
]

{ #category : #'examples - specialized' }
GtSearchReferencesFiltersCreationStringExamples >> classReferencesFilterCreationCode [
	<gtExample>
	| filter |
	filter := Object gtReferences.
	self
		assertCreatioCodeFor: filter
		equals: 'Object gtReferences'.
	self assert: filter object equals: Object binding.
	^ self creationCodeForFilter: filter
]

{ #category : #'examples - class variable' }
GtSearchReferencesFiltersCreationStringExamples >> classVariableReferenceFilterCreationCode [
	<gtExample>
	| filter |
	filter := GtSearchClassVariableReferenceFilter forClass: Object.
	self
		assertCreatioCodeFor: filter
		equals: 'GtSearchClassVariableReferenceFilter forClass: Object andVariable: #'''''.
	self assert: filter variableName equals: #''.
	^ self creationCodeForFilter: filter
]

{ #category : #'examples - class variable' }
GtSearchReferencesFiltersCreationStringExamples >> classVariableReferenceFilterForExistingVariableCreationCode [
	<gtExample>
	| aClass variable filter |
	aClass := Smalltalk allClasses
		detect: [ :each | each classVariables isNotEmpty ].
	variable := aClass classVariables anyOne.
	filter := GtSearchClassVariableReferenceFilter
		forClass: aClass
		andVariable: variable name.
	self
		assertCreatioCodeFor: filter
		equals: (String streamContents: [ :aStream |
			aStream
				nextPutAll: 'GtSearchClassVariableReferenceFilter forClass: ';
				nextPutAll: aClass name;
				nextPutAll: ' andVariable: ';
				print: variable name ]).
	self assert: filter object equals: variable.
	^ self creationCodeForFilter: filter
]

{ #category : #'examples - class variable' }
GtSearchReferencesFiltersCreationStringExamples >> classVariableReferenceFilterWithVariableCreationCode [
	<gtExample>
	| filter |
	filter := GtSearchClassVariableReferenceFilter
		forClass: Object
		andVariable: 'MissingClassVariable'.
	self
		assertCreatioCodeFor: filter
		equals: 'GtSearchClassVariableReferenceFilter forClass: Object andVariable: #MissingClassVariable'.
	self assert: filter variableName equals: #MissingClassVariable.
	^ self creationCodeForFilter: filter
]

{ #category : #'examples - specialized' }
GtSearchReferencesFiltersCreationStringExamples >> globalVariableReferencesFilterCreationCode [
	<gtExample>
	| binding filter |
	binding := Smalltalk globals associationAt: #Undeclared.
	filter := binding gtReferences.
	self
		assertCreatioCodeFor: filter
		equals: '(Smalltalk globals associationAt: #Undeclared) gtReferences'.
	self assert: filter object equals: binding.
	^ self creationCodeForFilter: filter
]

{ #category : #'examples - literals' }
GtSearchReferencesFiltersCreationStringExamples >> literalArrayFilterCreationCode [
	<gtExample>
	| filter |
	filter := GtSearchReferencesFilter literal: #(one 2).
	self
		assertCreatioCodeFor: filter
		equals: '#(#one 2) gtReferences'.
	self assert: filter object equals: #(one 2).
	^ self creationCodeForFilter: filter
]

{ #category : #'examples - literals' }
GtSearchReferencesFiltersCreationStringExamples >> literalNumberFilterCreationCode [
	<gtExample>
	| filter |
	filter := GtSearchReferencesFilter literal: 42.
	self
		assertCreatioCodeFor: filter
		equals: '42 gtReferences'.
	self assert: filter object equals: 42.
	^ self creationCodeForFilter: filter
]

{ #category : #'examples - literals' }
GtSearchReferencesFiltersCreationStringExamples >> literalStringFilterCreationCode [
	<gtExample>
	| filter |
	filter := GtSearchReferencesFilter literal: 'a reference'.
	self
		assertCreatioCodeFor: filter
		equals: '''a reference'' gtReferences'.
	self assert: filter object equals: 'a reference'.
	^ self creationCodeForFilter: filter
]
