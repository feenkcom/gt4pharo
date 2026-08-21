Class {
	#name : #GtSearchMethodsFiltersCreationStringExamples,
	#superclass : #GtSearchFiltersCreationStringExamples,
	#category : #'GToolkit-Pharo-SearchFilters-Examples-Examples'
}

{ #category : #'examples - stateless' }
GtSearchMethodsFiltersCreationStringExamples >> classMethodsFilterCreationCode [
	<gtExample>
	^ self
			assertCreatioCodeFor: GtSearchClassMethodsFilter new
			equals: 'GtSearchClassMethodsFilter new'.
]

{ #category : #'examples - parameterized' }
GtSearchMethodsFiltersCreationStringExamples >> classPatternFilterCreationCode [
	<gtExample>
	^ self
		assertCreatioCodeFor: 'GtSearch*' gtClassMatches
		equals: '''GtSearch*'' gtClassMatches'.
]

{ #category : #'examples - parameterized' }
GtSearchMethodsFiltersCreationStringExamples >> commentsFilterWithDefaultOptionsCreationCode [
	<gtExample>
	| filter |
	filter := GtSearchCommentsFilter new
		text: 'search text';
		yourself.
	^ self
		assertCreatioCodeFor: filter
		equals: '(GtSearchCommentsFilter new text: ''search text'')'.
]

{ #category : #'examples - parameterized' }
GtSearchMethodsFiltersCreationStringExamples >> commentsFilterWithNonDefaultCaseSensitiveCreationCode [
	<gtExample>
	| filter |
	filter := GtSearchCommentsFilter new
		text: 'search text';
		caseSensitive: false;
		yourself.
	^ self
		assertCreatioCodeFor: filter
		equals: '(GtSearchCommentsFilter new text: ''search text''; caseSensitive: false)'.
]

{ #category : #'examples - parameterized' }
GtSearchMethodsFiltersCreationStringExamples >> commentsFilterWithNonDefaultOptionsCreationCode [
	<gtExample>
	| filter |
	filter := GtSearchCommentsFilter new
		text: 'search text';
		wholeWord: false;
		caseSensitive: false;
		yourself.
	^ self
		assertCreatioCodeFor: filter
		equals: '(GtSearchCommentsFilter new text: ''search text''; wholeWord: false; caseSensitive: false)'.
]

{ #category : #'examples - parameterized' }
GtSearchMethodsFiltersCreationStringExamples >> commentsFilterWithNonDefaultWholeWordCreationCode [
	<gtExample>
	| filter |
	filter := GtSearchCommentsFilter new
		text: 'search text';
		wholeWord: false;
		yourself.
	^ self
		assertCreatioCodeFor: filter
		equals: '(GtSearchCommentsFilter new text: ''search text''; wholeWord: false)'.
]

{ #category : #'examples - composed filters' }
GtSearchMethodsFiltersCreationStringExamples >> composedAndFilterSubstringAndExampleCreationCode [
	<gtExample>
	| filter |
	filter := 'home' gtSubstringLiteralMatch & #gtExample gtPragmas.
	^ self assertCreatioCodeFor: filter
		equals: ('''home'' gtSubstringLiteralMatch & #gtExample gtPragmas')
]

{ #category : #'examples - stateless' }
GtSearchMethodsFiltersCreationStringExamples >> definedMethodsFilterCreationCode [
	<gtExample>
	^ self
		assertCreatioCodeFor: GtSearchDefinedMethodsFilter new
		equals: 'GtSearchDefinedMethodsFilter new'.
]

{ #category : #'examples - stateless' }
GtSearchMethodsFiltersCreationStringExamples >> deprecatedMethodsFilterCreationCode [
	<gtExample>
	^ self
		assertCreatioCodeFor: GtSearchDeprecatedMethodsFilter new
		equals: 'GtSearchDeprecatedMethodsFilter new'.
]

{ #category : #'examples - stateless' }
GtSearchMethodsFiltersCreationStringExamples >> imageMethodsFilterCreationCode [
	<gtExample>
	^ self
		assertCreatioCodeFor: GtSearchImageMethodsFilter new
		equals: 'GtSearchImageMethodsFilter new'.
]

{ #category : #'examples - parameterized' }
GtSearchMethodsFiltersCreationStringExamples >> implementorPatternFilterCreationCode [
	<gtExample>
	^ self
		assertCreatioCodeFor: (GtSearchImplementorPatternFilter pattern: 'at:')
		equals: 'GtSearchImplementorPatternFilter pattern: ''at:'''.
]

{ #category : #'examples - parameterized' }
GtSearchMethodsFiltersCreationStringExamples >> implementorsFilterCreationCode [
	<gtExample>
	^ self
		assertCreatioCodeFor: #at: gtImplementors
		equals: '#at: gtImplementors'.
]

{ #category : #'examples - stateless' }
GtSearchMethodsFiltersCreationStringExamples >> instanceMethodsFilterCreationCode [
	<gtExample>
	^ self
		assertCreatioCodeFor: GtSearchInstanceMethodsFilter new
		equals: 'GtSearchInstanceMethodsFilter new'.
]

{ #category : #'examples - parameterized' }
GtSearchMethodsFiltersCreationStringExamples >> literalNumberValueFilterCreationCode [
	<gtExample>
	^ self
		assertCreatioCodeFor: 42 gtLiteralValueMatch
		equals: '42 gtLiteralValueMatch'.
]

{ #category : #'examples - parameterized' }
GtSearchMethodsFiltersCreationStringExamples >> literalValueFilterCreationCode [
	<gtExample>
	^ self
		assertCreatioCodeFor: (GtSearchLiteralValueFilter forValue: 'a literal')
		equals: 'GtSearchLiteralValueFilter forValue: ''a literal''.'
]

{ #category : #'examples - parameterized' }
GtSearchMethodsFiltersCreationStringExamples >> methodCategoryFilterCreationCode [
	<gtExample>
	^ self
		assertCreatioCodeFor: (GtSearchMethodCategoryFilter forCategory: #accessing)
		equals: 'GtSearchMethodCategoryFilter forCategory: #accessing'.
]

{ #category : #'examples - parameterized' }
GtSearchMethodsFiltersCreationStringExamples >> methodsInPackageFilterCreationCode [
	<gtExample>
	| filter |
	filter := GtSearchMethodsInPackageFilter new.
	filter package: 'GToolkit-Pharo-SearchFilters' asPackage.
	^ self
		assertCreatioCodeFor: filter
		equals: 'GtSearchMethodsInPackageFilter new package: ''GToolkit-Pharo-SearchFilters'' asPackage'.
]

{ #category : #'examples - stateless' }
GtSearchMethodsFiltersCreationStringExamples >> nonTraitMethodsFilterCreationCode [
	<gtExample>
	^ self
		assertCreatioCodeFor: GtSearchNonTraitMethodsFilter new
		equals: 'GtSearchNonTraitMethodsFilter new'.
]

{ #category : #'examples - parameterized' }
GtSearchMethodsFiltersCreationStringExamples >> packagePatternFilterCreationCode [
	<gtExample>
	^ self
		assertCreatioCodeFor: 'GToolkit-Pharo*' gtPackageMatches
		equals: '''GToolkit-Pharo*'' gtPackageMatches'.
]

{ #category : #'examples - textual' }
GtSearchMethodsFiltersCreationStringExamples >> pragmasFiltersCreationCode [
	<gtExample>
	^ self 
			assertCreatioCodeFor: #gtExample gtPragmas
			equals: '#gtExample gtPragmas'
]

{ #category : #'examples - parameterized' }
GtSearchMethodsFiltersCreationStringExamples >> rbASTExpressionFilterCreationCode [
	<gtExample>
	^ self
		assertCreatioCodeFor: (GtSearchRBASTFilter sourceExpression: '`@receiver at: `@argument')
		equals: '''`@receiver at: `@argument'' gtASTMatches'.
]

{ #category : #'examples - parameterized' }
GtSearchMethodsFiltersCreationStringExamples >> rbASTMethodFilterCreationCode [
	<gtExample>
	| source |
	source := 'example: anObject
	^ anObject at: 1'.
	^ self
		assertCreatioCodeFor: (GtSearchRBASTFilter sourceMethod: source)
		equals: '''example: anObject
	^ anObject at: 1'' gtASTMethodMatches'.
]

{ #category : #'examples - parameterized' }
GtSearchMethodsFiltersCreationStringExamples >> rbPatternFilterCreationCode [
	<gtExample>
	^ self
		assertCreatioCodeFor: '`@receiver at: `@argument' gtRBPatternMatches
		equals: '''`@receiver at: `@argument'' gtRBPatternMatches'.
]

{ #category : #'examples - parameterized' }
GtSearchMethodsFiltersCreationStringExamples >> repositoryPatternFilterCreationCode [
	<gtExample>
	^ self
		assertCreatioCodeFor: 'gtoolkit' gtRepositoryMatches
		equals: '''gtoolkit'' gtRepositoryMatches'.
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

{ #category : #'examples - stateless' }
GtSearchMethodsFiltersCreationStringExamples >> subclassResponsibilityMethodsFilterCreationCode [
	<gtExample>
	^ self
		assertCreatioCodeFor: GtSearchSubclassResponsibilityMethodsFilter new
		equals: 'GtSearchSubclassResponsibilityMethodsFilter new'.
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

{ #category : #'examples - stateless' }
GtSearchMethodsFiltersCreationStringExamples >> traitMethodsFilterCreationCode [
	<gtExample>
	^ self
		assertCreatioCodeFor: GtSearchTraitMethodsFilter new
		equals: 'GtSearchTraitMethodsFilter new'.
]
