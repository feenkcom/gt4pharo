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
	| changesElement filters pane |
	super initialize.
	changes := RBCompositeRefactoryChange new.

	filterModel := GtFilterItemsModel new.
	filterModel weak
		when: GtFiltersModelAnnouncement
		send: #updateFilteredChanges
		to: self.

	pane := BrHorizontalPane new.
	pane hMatchParent.
	pane vFitContent.
	self addChild: pane.

	filters := filterModel asFiltersElement.
	filters
		hMatchParent;
		constraintsDo: [ :c | c linear vertical alignCenter ];
		padding: (BlInsets all: 0).
	pane addChild: filters as: #filters.

	changesElement := GtChangesElement new.
	changesElement padding: (BlInsets all: 0).
	changesElement vFitContentLimited.
	self addChild: changesElement as: #changes.

	pane
		addChild: (BrButton new
				beTinySize;
				aptitude: BrGlamorousButtonWithIconAptitude new;
				icon: BrGlamorousVectorIcons inspect;
				id: #'inspect-changes';
				label: 'Inspect changes';
				padding: (BlInsets left: 5);
				action: [ :aButton | aButton phlow spawnObject: changesElement changes ];
				yourself)
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
