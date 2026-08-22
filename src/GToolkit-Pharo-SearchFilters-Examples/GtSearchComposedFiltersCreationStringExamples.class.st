"
Examples for creation code emitted by composed search filters.
"
Class {
	#name : #GtSearchComposedFiltersCreationStringExamples,
	#superclass : #GtSearchFiltersCreationStringExamples,
	#category : #'GToolkit-Pharo-SearchFilters-Examples'
}

{ #category : #examples }
GtSearchComposedFiltersCreationStringExamples >> classHierarchyAndLabeledImplementorsCreationCode [
	<gtExample>
	| filter |
	filter := (GtSearchMethodsInClassFilter forClass: GtCoderModel) withSuperclasses
		& (#gtAstCoderAddOns: gtPragmas
			| #initializeAddOns: gtImplementors
			| #initializeAddOns:viewModel: gtImplementors) labeled: 'Examples related'.
	^ self
		assertCreatioCodeFor: filter
		equals: '((GtSearchMethodsInClassFilter forClass: GtCoderModel) withSuperclasses & (#gtAstCoderAddOns: gtPragmas | #initializeAddOns: gtImplementors | #initializeAddOns:viewModel: gtImplementors)) labeled: ''Examples related'''
]

{ #category : #examples }
GtSearchComposedFiltersCreationStringExamples >> examplesWithoutNoTestCreationCode [
	<gtExample>
	| filter |
	filter := ('home' gtStringLiteralCaseSensitiveMatch & #gtExample gtPragmas)
		select: [ :each | (each hasPragmaNamed: #noTest) not ].
	^ self
		assertCreatioCodeFor: filter
		equals: '((''home'' gtStringLiteralCaseSensitiveMatch) & (#gtExample gtPragmas)) & (GtSearchBlockFilter forBlock: [ :each | (each hasPragmaNamed: #noTest) not ])'
]

{ #category : #examples }
GtSearchComposedFiltersCreationStringExamples >> packagePragmasAndNegationCreationCode [
	<gtExample>
	| filter |
	filter := 'Bloc-Examples' gtPackageMatches
		& #gtExample gtPragmas
		& #noTest gtPragmas not
		& #return: gtPragmas.
	^ self
		assertCreatioCodeFor: filter
		equals: '((((''Bloc-Examples'' gtPackageMatches) & (#gtExample gtPragmas)) & ((#noTest gtPragmas) not)) & (#return: gtPragmas))'
]

{ #category : #examples }
GtSearchComposedFiltersCreationStringExamples >> referencesImplementorsAndClassPatternCreationCode [
	<gtExample>
	| filter |
	filter := (#runGitWithArgs: gtReferences | #runGitWithArgsAsync: gtReferences)
		& #gtViewGitCallsIn: gtImplementors not
		& 'PureGitCommandLineInterface' gtClassMatches.
	^ self
		assertCreatioCodeFor: filter
		equals: '(((#runGitWithArgs: gtReferences) | (#runGitWithArgsAsync: gtReferences)) & ((#gtViewGitCallsIn: gtImplementors) not)) & (''PureGitCommandLineInterface'' gtClassMatches)'
]

{ #category : #examples }
GtSearchComposedFiltersCreationStringExamples >> referencesScopedMethodsAndMethodFiltersCreationCode [
	<gtExample>
	| filter |
	filter := BlElement gtReferences
		& ((GtSearchScopedMethodsFilter new scope: GtSearchScopedMethodsAllScope default)
			& 'Bloc-Examples' gtPackageMatches
			& 'return:' gtPragmas
			& '``@any background: ``@any1' gtASTMatches
			& 'BlChildrenWrappingGeometryExamples' gtClassMatches
			& GtSearchDefinedMethodsFilter new
			& '50 @ 50' gtSubstringMatch).
	^ self
		assertCreatioCodeFor: filter
		equals: 'BlElement gtReferences & ((GtSearchScopedMethodsFilter new scope: GtSearchScopedMethodsAllScope default) & ''Bloc-Examples'' gtPackageMatches & #return: gtPragmas & ''``@any background: ``@any1'' gtASTMatches & ''BlChildrenWrappingGeometryExamples'' gtClassMatches & GtSearchDefinedMethodsFilter new & ''50 @ 50'' gtSubstringMatch)'
]
