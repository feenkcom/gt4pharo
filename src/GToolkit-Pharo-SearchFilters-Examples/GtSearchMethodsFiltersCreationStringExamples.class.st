Class {
	#name : #GtSearchMethodsFiltersCreationStringExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-SearchFilters-Examples'
}

{ #category : #assertions }
GtSearchMethodsFiltersCreationStringExamples >> assertCreatioCodeFor: aFilter equals: aString [
	| creationCode|
	creationCode := aFilter creationCode.
	self assert: (RBParser parseExpression: creationCode) formattedCode
		equals: (RBParser parseExpression: aString) formattedCode.
	^ self wrappedCreationCodeFor: aFilter 
]

{ #category : #examples }
GtSearchMethodsFiltersCreationStringExamples >> classMethodsFilterCreationCode [
	<gtExample>
	^ self
			assertCreatioCodeFor: GtSearchClassMethodsFilter new
			equals: 'GtSearchClassMethodsFilter new'.
]

{ #category : #'examples - composed filters' }
GtSearchMethodsFiltersCreationStringExamples >> composedAndFilterSubstringAndExampleCreationCode [
	<gtExample>
	| filter |
	filter := 'home' gtSubstringLiteralMatch & #gtExample gtPragmas.
	^ self assertCreatioCodeFor: filter
		equals: ('''home'' gtSubstringLiteralMatch & #gtExample gtPragmas')
]

{ #category : #'examples - textual' }
GtSearchMethodsFiltersCreationStringExamples >> pragmasFiltersCreationCode [
	<gtExample>
	^ self 
			assertCreatioCodeFor: #gtExample gtPragmas
			equals: '#gtExample gtPragmas'
]

{ #category : #'examples - textual' }
GtSearchMethodsFiltersCreationStringExamples >> stringLiteralMatchCaseSensitiveDefaultCreationCode [
	<gtExample>
	^ self
			assertCreatioCodeFor: 'home' gtStringLiteralCaseSensitiveMatch
			equals: '''home'' gtStringLiteralCaseSensitiveMatch'.
]

{ #category : #'examples - textual' }
GtSearchMethodsFiltersCreationStringExamples >> stringLiteralMatchDefaultCreationCode [
	<gtExample>
	^ self
			assertCreatioCodeFor: 'home' gtStringLiteralMatch
			equals: '''home'' gtStringLiteralMatch'.
]

{ #category : #'examples - textual' }
GtSearchMethodsFiltersCreationStringExamples >> substringLiteralMatchCaseSensitiveCreationCode [
	<gtExample>
	^ self 
		assertCreatioCodeFor: 'home' gtSubstringLiteralCaseSensitiveMatch
		equals: '''home'' gtSubstringLiteralCaseSensitiveMatch'
]

{ #category : #'examples - textual' }
GtSearchMethodsFiltersCreationStringExamples >> substringLiteralMatchDefaultCreationCode [
	<gtExample>
	^ self
			assertCreatioCodeFor: 'home' gtSubstringLiteralMatch
			equals: '''home'' gtSubstringLiteralMatch'.
]

{ #category : #'examples - textual' }
GtSearchMethodsFiltersCreationStringExamples >> substringMatchDefaultCreationCode [
	<gtExample>
	^ self
			assertCreatioCodeFor: 'home' gtSubstringMatch
			equals: '''home'' gtSubstringMatch'.
]

{ #category : #'examples - textual' }
GtSearchMethodsFiltersCreationStringExamples >> substringMatchIncludingNotSearchableMethodsCreationCode [
	<gtExample>
	^ self
			assertCreatioCodeFor: 'home' gtSubstringMatch includeNotSearchableMethods
			equals: '''home'' gtSubstringMatch includeNotSearchableMethods'.
]

{ #category : #utils }
GtSearchMethodsFiltersCreationStringExamples >> wrappedCreationCodeFor: aFilter [
	^ LePharoSnippet code: aFilter creationCode
]
