Class {
	#name : #GtFilteredChangesElement,
	#superclass : #BrVerticalPane,
	#instVars : [
		'filterModel',
		'changes'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings'
}

{ #category : #operations }
GtFilteredChangesElement >> applyChanges [
	^ self changesElement applyChanges
]

{ #category : #operations }
GtFilteredChangesElement >> applyChangesWithProgress: aBlock [
	^ self changesElement applyChangesWithProgress: aBlock
]

{ #category : #accessing }
GtFilteredChangesElement >> changes [
	^ changes
]

{ #category : #accessing }
GtFilteredChangesElement >> changes: aCompositeChange [
	changes := aCompositeChange.
	self updateFilters
]

{ #category : #private }
GtFilteredChangesElement >> changesElement [
	^ self childNamed: #changes
]

{ #category : #'api - expansion' }
GtFilteredChangesElement >> expandUpTo: anInteger [
	^ self changesElement expandUpTo: anInteger
]

{ #category : #initialization }
GtFilteredChangesElement >> initialize [
	| changesElement filters |
	super initialize.
	changes := RBCompositeRefactoryChange new.

	filterModel := GtFilterItemsModel new.
	filterModel weak
		when: GtFiltersModelAnnouncement
		send: #updateFilteredChanges
		to: self.

	filters := filterModel asFiltersElement.
	filters
		hMatchParent;
		constraintsDo: [ :c | c linear vertical alignCenter ];
		margin: (BlInsets
				top: 5
				left: 10
				bottom: 0
				right: 10).
	self addChild: filters as: #filters.

	changesElement := GtChangesElement new.
	self addChild: changesElement as: #changes
]

{ #category : #accessing }
GtFilteredChangesElement >> updateFilteredChanges [
	| filterBlock filteredChanges |
	filterBlock := filterModel items
			inject: [ :each | true ]
			into: [ :sum :each | each creator cull: sum cull: each ].
	filteredChanges := changes gtFilter: filterBlock.
	self changesElement changes: filteredChanges
]

{ #category : #accessing }
GtFilteredChangesElement >> updateFilters [
	filterModel
		availableFiltersBuilder: (GtRefactoryChangeFiltersBuilder new changes: changes).
	self updateFilteredChanges
]
