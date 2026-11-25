Class {
	#name : #GtRefactoryChangeFiltersBuilderExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-GtRefactorings-Examples'
}

{ #category : #examples }
GtRefactoryChangeFiltersBuilderExamples >> changes [
	"Changes that are not applied: a method added to and a method removed from Object,
	an instance variable of LookupKey renamed, OrderedCollection renamed"

	<gtExample>
	<return: #RBCompositeRefactoryChange>
	| changes |
	changes := RBCompositeRefactoryChange named: 'Changes'.
	changes
		addChange: (RBAddMethodChange
				compile: 'gtExampleMethod ^ 42'
				in: Object
				classified: #accessing);
		addChange: (RBRemoveMethodChange remove: #printString from: Object);
		addChange: (RBRenameInstanceVariableChange
				rename: 'key'
				to: 'renamedKey'
				in: LookupKey);
		addChange: (RBRenameClassChange
				rename: #OrderedCollection
				to: #GtExampleRenamedCollection).
	self assert: changes changes size equals: 4.
	^ changes
]

{ #category : #examples }
GtRefactoryChangeFiltersBuilderExamples >> classFilterWithTypedClassName [
	"The In class filter keeps the changes of the class whose name is typed in the filter,
	including renames of its variables and of the class itself"

	<gtExample>
	<return: #RBCompositeRefactoryChange>
	| changes |
	changes := self changes.
	self
		assert: (self
				classesOfChanges: changes
				filteredBy: 'In class'
				text: 'Object')
		equals: {RBAddMethodChange.
				RBRemoveMethodChange}.
	self
		assert: (self
				classesOfChanges: changes
				filteredBy: 'In class'
				text: 'LookupKey')
		equals: {RBRenameInstanceVariableChange}.
	self
		assert: (self
				classesOfChanges: changes
				filteredBy: 'In class'
				text: 'OrderedCollection')
		equals: {RBRenameClassChange}.
	^ changes
]

{ #category : #private }
GtRefactoryChangeFiltersBuilderExamples >> classesOfChanges: aCompositeChange filteredBy: aFilterName text: aString [
	"Filter the changes as the filters of a changes element do (GtFilteredChangesElement>>#updateFilteredChanges),
	with aString typed in the filter named aFilterName"

	| filter |
	filter := (GtRefactoryChangeFiltersBuilder new
			changes: aCompositeChange;
			yourself) availableFilters detect: [ :each | each name = aFilterName ].
	filter text: aString.
	^ ((aCompositeChange gtFilter: (filter creator cull: [ :each | true ] cull: filter))
		changes collect: [ :each | each class ]) asArray
]

{ #category : #examples }
GtRefactoryChangeFiltersBuilderExamples >> selectorFilterWithTypedSelector [
	"The Selector filter keeps the changes of the method whose selector is typed in the filter"

	<gtExample>
	<return: #RBCompositeRefactoryChange>
	| changes |
	changes := self changes.
	self
		assert: (self
				classesOfChanges: changes
				filteredBy: 'Selector'
				text: 'gtExampleMethod')
		equals: {RBAddMethodChange}.
	self
		assert: (self
				classesOfChanges: changes
				filteredBy: 'Selector'
				text: 'printString')
		equals: {RBRemoveMethodChange}.
	^ changes
]
