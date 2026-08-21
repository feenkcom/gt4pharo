"
Creation-code examples for concrete subclasses of GtSearchMethodsContainedInClassFilter.
"
Class {
	#name : #GtSearchMethodsContainedInClassFilterCreationStringExamples,
	#superclass : #GtSearchFiltersCreationStringExamples,
	#category : #'GToolkit-Pharo-SearchFilters-Examples-Examples'
}

{ #category : #examples }
GtSearchMethodsContainedInClassFilterCreationStringExamples >> classSlotReferenceFilterWithDefaultOptionsCreationCode [
	<gtExample>
	^ self
		assertCreatioCodeFor: (GtSearchClassSlotReferenceFilter forClass: Object andVariable: 'name')
		equals: '(GtSearchClassSlotReferenceFilter forClass: Object andVariable: ''name'') withSubclasses'.
]

{ #category : #examples }
GtSearchMethodsContainedInClassFilterCreationStringExamples >> classSlotReferenceFilterWithNonDefaultOptionsCreationCode [
	<gtExample>
	| filter |
	filter := GtSearchClassSlotReferenceFilter forClass: Object andVariable: 'name'.
	filter
		withoutSubclasses;
		withSuperclasses;
		includeReaders: false;
		includeWriters: false.
	^ self
		assertCreatioCodeFor: filter
		equals: '(GtSearchClassSlotReferenceFilter forClass: Object andVariable: ''name'') withSuperclasses; includeReaders: false; includeWriters: false'.
]

{ #category : #examples }
GtSearchMethodsContainedInClassFilterCreationStringExamples >> inheritedMethodsFilterCreationCode [
	<gtExample>
	^ self
		assertCreatioCodeFor: (GtSearchInheritedMethodsFilter forClass: Object)
		equals: 'GtSearchInheritedMethodsFilter forClass: Object'.
]

{ #category : #examples }
GtSearchMethodsContainedInClassFilterCreationStringExamples >> inheritedMethodsFilterWithSubclassesCreationCode [
	<gtExample>
	| filter |
	filter := GtSearchInheritedMethodsFilter forClass: Object.
	filter withSubclasses.
	^ self
		assertCreatioCodeFor: filter
		equals: '(GtSearchInheritedMethodsFilter forClass: Object) withSubclasses'.
]

{ #category : #examples }
GtSearchMethodsContainedInClassFilterCreationStringExamples >> instanceSlotReferenceFilterWithDefaultOptionsCreationCode [
	<gtExample>
	^ self
		assertCreatioCodeFor: (GtSearchInstanceSlotReferenceFilter forClass: Object andVariable: 'name')
		equals: '(GtSearchInstanceSlotReferenceFilter forClass: Object andVariable: ''name'') withSubclasses'.
]

{ #category : #examples }
GtSearchMethodsContainedInClassFilterCreationStringExamples >> instanceSlotReferenceFilterWithNonDefaultOptionsCreationCode [
	<gtExample>
	| filter |
	filter := GtSearchInstanceSlotReferenceFilter forClass: Object andVariable: 'name'.
	filter
		withoutSubclasses;
		withSuperclasses;
		includeReaders: false;
		includeWriters: false.
	^ self
		assertCreatioCodeFor: filter
		equals: '(GtSearchInstanceSlotReferenceFilter forClass: Object andVariable: ''name'') withSuperclasses; includeReaders: false; includeWriters: false'.
]

{ #category : #examples }
GtSearchMethodsContainedInClassFilterCreationStringExamples >> methodsInClassFilterWithDefaultOptionsCreationCode [
	<gtExample>
	^ self
		assertCreatioCodeFor: (GtSearchMethodsInClassFilter forClass: Object)
		equals: 'GtSearchMethodsInClassFilter forClass: Object'.
]

{ #category : #examples }
GtSearchMethodsContainedInClassFilterCreationStringExamples >> methodsInClassFilterWithMultipleOptionsCreationCode [
	<gtExample>
	| filter |
	filter := GtSearchMethodsInClassFilter forClass: Object.
	filter
		withSubclasses;
		withSuperclasses.
	^ self
		assertCreatioCodeFor: filter
		equals: '(GtSearchMethodsInClassFilter forClass: Object) withSubclasses; withSuperclasses'.
]

{ #category : #examples }
GtSearchMethodsContainedInClassFilterCreationStringExamples >> methodsInClassFilterWithSubclassesCreationCode [
	<gtExample>
	| filter |
	filter := GtSearchMethodsInClassFilter forClass: Object.
	filter withSubclasses.
	^ self
		assertCreatioCodeFor: filter
		equals: '(GtSearchMethodsInClassFilter forClass: Object) withSubclasses'.
]

{ #category : #examples }
GtSearchMethodsContainedInClassFilterCreationStringExamples >> methodsInClassFilterWithSuperclassesCreationCode [
	<gtExample>
	| filter |
	filter := GtSearchMethodsInClassFilter forClass: Object.
	filter withSuperclasses.
	^ self
		assertCreatioCodeFor: filter
		equals: '(GtSearchMethodsInClassFilter forClass: Object) withSuperclasses'.
]

{ #category : #examples }
GtSearchMethodsContainedInClassFilterCreationStringExamples >> methodsInClassFilterWithSuperclassesUpToCreationCode [
	<gtExample>
	| filter |
	filter := GtSearchMethodsInClassFilter forClass: String.
	filter withSuperclassesUpTo: Object.
	^ self
		assertCreatioCodeFor: filter
		equals: '(GtSearchMethodsInClassFilter forClass: String) withSuperclassesUpTo: Object'.
]

{ #category : #examples }
GtSearchMethodsContainedInClassFilterCreationStringExamples >> methodsInInstanceAndClassSideFilterCreationCode [
	<gtExample>
	^ self
		assertCreatioCodeFor: (GtSearchMethodsInInstanceAndClassSideFilter forClass: Object)
		equals: 'GtSearchMethodsInInstanceAndClassSideFilter forClass: Object'.
]
