"
Examples for creation code emitted by scoped method search scopes.
"
Class {
	#name : #GtSearchScopedMethodsScopesCreationStringExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-SearchFilters-Examples'
}

{ #category : #examples }
GtSearchScopedMethodsScopesCreationStringExamples >> allScopeCreationCode [
	<gtExample>
	^ self
		assertCreationCodeForScope: GtSearchScopedMethodsAllScope default
		equals: 'GtSearchScopedMethodsAllScope default'
]

{ #category : #asserting }
GtSearchScopedMethodsScopesCreationStringExamples >> assertCreationCodeForScope: aScope equals: aString [
	| creationCode |
	creationCode := String streamContents: [ :aStream |
		aScope storeCreationCodeOn: aStream ].
	self assert: (RBParser parseExpression: creationCode) formattedCode
		equals: (RBParser parseExpression: aString) formattedCode.
	^ LePharoSnippet code: (RBParser parseExpression: creationCode) formattedCode
]

{ #category : #examples }
GtSearchScopedMethodsScopesCreationStringExamples >> classHierarchyScopeCreationCode [
	<gtExample>
	| scope |
	scope := GtSearchScopedMethodsClassHierarchyScope new itemClass: Object.
	^ self
		assertCreationCodeForScope: scope
		equals: '(GtSearchScopedMethodsClassHierarchyScope new) itemClass: Object'
]

{ #category : #examples }
GtSearchScopedMethodsScopesCreationStringExamples >> classScopeCreationCode [
	<gtExample>
	| scope |
	scope := GtSearchScopedMethodsClassScope new itemClass: Object.
	^ self
		assertCreationCodeForScope: scope
		equals: '(GtSearchScopedMethodsClassScope new) itemClass: Object'
]

{ #category : #examples }
GtSearchScopedMethodsScopesCreationStringExamples >> packagePatternScopeCustomOrderCreationCode [
	<gtExample>
	| scope |
	scope := GtSearchScopedMethodsPackagePatternScope new
		pattern: 'GToolkit-*';
		order: 17.
	^ self
		assertCreationCodeForScope: scope
		equals: '(GtSearchScopedMethodsPackagePatternScope new) pattern: ''GToolkit-*''; order: 17'
]

{ #category : #examples }
GtSearchScopedMethodsScopesCreationStringExamples >> packagePatternScopeDefaultOrderCreationCode [
	<gtExample>
	| scope |
	scope := GtSearchScopedMethodsPackagePatternScope new pattern: 'GToolkit-*'.
	^ self
		assertCreationCodeForScope: scope
		equals: '(GtSearchScopedMethodsPackagePatternScope new) pattern: ''GToolkit-*'''
]

{ #category : #examples }
GtSearchScopedMethodsScopesCreationStringExamples >> packageScopeCreationCode [
	<gtExample>
	| scope |
	scope := GtSearchScopedMethodsPackageScope new package: 'GToolkit-Pharo-SearchFilters' asPackage.
	^ self
		assertCreationCodeForScope: scope
		equals: '(GtSearchScopedMethodsPackageScope new) package: ''GToolkit-Pharo-SearchFilters'' asPackage'
]
