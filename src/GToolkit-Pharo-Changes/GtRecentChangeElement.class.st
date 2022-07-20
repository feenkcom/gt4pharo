Class {
	#name : #GtRecentChangeElement,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable',
	#classTraits : 'TBrLayoutResizable classTrait',
	#instVars : [
		'model',
		'filters',
		'tree',
		'navigationModel'
	],
	#category : #'GToolkit-Pharo-Changes-Element'
}

{ #category : #accessing }
GtRecentChangeElement >> filters [
	^ filters
]

{ #category : #accessing }
GtRecentChangeElement >> initialize [
	super initialize.
	self layout: BlLinearLayout vertical.
	self matchParent.
	
	model := GtRecentChanges new.
	
	self updateFilters.
	self updateTree.
	
	self addChild: self filters as: #filters.
	self addChild: self tree as: #tree.
	
	self setupListener
]

{ #category : #accessing }
GtRecentChangeElement >> navigationModel [
	^ navigationModel
]

{ #category : #accessing }
GtRecentChangeElement >> navigationModel: aNavigationModel [
	navigationModel := aNavigationModel
]

{ #category : #accessing }
GtRecentChangeElement >> onAnnouncement: anAnnouncement [
	self updateFilters.
	self updateTree.

	self removeChildNamed: #filters.
	self removeChildNamed: #tree.

	self addChild: self filters as: #filters.
	self addChild: self tree as: #tree
]

{ #category : #accessing }
GtRecentChangeElement >> setupListener [
	model weak when: GtRecentChangesUpdated send: #onAnnouncement: to: self
]

{ #category : #accessing }
GtRecentChangeElement >> tree [
	^ tree
]

{ #category : #accessing }
GtRecentChangeElement >> updateFilters [
	filters := GtFiltersElement new.
	filters descriptors: model filterDescriptors.
	filters
		when: GtFiltersChangedEvent
		do: [ :event | 
			self updateTreeWith: (model applyFiltersFrom: event filterElement).
			self removeChildNamed: #tree.
			self addChild: self tree as: #tree ]
]

{ #category : #accessing }
GtRecentChangeElement >> updateTree [
	self updateTreeWith: model groupedChanges
]

{ #category : #accessing }
GtRecentChangeElement >> updateTreeWith: aListOfChanges [
	tree := BrSimpleTree new matchParent.

	tree
		when: BrSelectionChanged
		do: [ :anEvent | 
			anEvent indices
				ifNotEmpty: [ | aWidgetElement selectedObject |
					aWidgetElement := anEvent currentTarget.
					selectedObject := (aWidgetElement viewModel itemAt: anEvent indices first)
							value.
					selectedObject navigateToUsingModel: self navigationModel ] ].

	tree
		nodeStencil: [ BrLabel new
				aptitude: BrGlamorousLabelAptitude;
				beSmallSize ];
		nodeDataBinder: [ :aNodeElement :anItem | aNodeElement text: anItem displayForTree ];
		items: aListOfChanges lazy: #gtChildren;
		rowStencil: BrGlamorousSimpleTreeSelectableRowElementStencilBuilder new;
		expandAll
]
