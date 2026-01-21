Class {
	#name : #GtRBChangeGroupElement,
	#superclass : #BrVerticalPane,
	#instVars : [
		'group',
		'filterModel',
		'filteredGroup'
	],
	#category : #'GToolkit-Pharo-GtRefactorings-Changes-View'
}

{ #category : #private }
GtRBChangeGroupElement >> allChangesIn: aCollection [
	^ aCollection
		flatCollectAsSet: [ :each | 
			(each isKindOf: GtRBChangeGroup)
				ifTrue: [ each allChanges ]
				ifFalse: [ each gtAllChanges ] ]
]

{ #category : #accessing }
GtRBChangeGroupElement >> applyChanges: aCollection [
	| applyButton progress composite |
	applyButton := self childNamed: #applyButton.
	progress := self childNamed: #progress.
	applyButton disable.
	(aCollection size = 1 and: [ aCollection first == group changes ])
		ifTrue: [ composite := group changes ]
		ifFalse: [ composite := RBCompositeRefactoryChange new.
			composite
				name: (aCollection size = 1
						ifTrue: [ aCollection first name ]
						ifFalse: [ group changes name ]).
			group changes gtBasicChanges
				do: [ :each | (aCollection identityIncludes: each) ifTrue: [ composite addChange: each ] ] ].
	composite changesSize > 1 ifTrue: [ progress visibility: BlVisibility visible ].
	progress fraction: 0.
	(composite
		gtExecuteWithNotificationWithProgress: [ :fraction | progress enqueueTask: (BlTaskAction new action: [ progress fraction: fraction ]) ])
		then: [ :undo | 
			self
				enqueueTask: [ self updateGroupTreeItems.
					progress visibility: BlVisibility hidden.
					applyButton enable ] asBlTask ]
		otherwise: [ :error | 
			self processError: error.
			progress visibility: BlVisibility hidden.
			applyButton enable ]
]

{ #category : #accessing }
GtRBChangeGroupElement >> childrenBlock [
	^ [ :each | (each isKindOf: RBRefactoryChange) ifTrue: [ #() ] ifFalse: [ each items ] ]
]

{ #category : #initialization }
GtRBChangeGroupElement >> dynamicMenuItemsFor: aCollection [
	| items changes change allChanges |
	items := BrMenuItems new.
	changes := self allChangesIn: aCollection.
	allChanges := filteredGroup allChanges.
	changes size = 1
		ifTrue: [ change := changes any.
			items
				addItemLabel: 'Apply' asRopedText
						, ((' ' , change gtDescription) asRopedText
								glamorousCodeFont;
								foreground: Color gray;
								glamorousCodeTinySize)
				action: [ :each | self applyChanges: {change} ] ]
		ifFalse: [ (changes size > 1 and: [ changes size < allChanges size ])
				ifTrue: [ items
						addItemLabel: 'Apply' asRopedText
								, ((' ' , changes size printString , ' changes') asRopedText
										glamorousCodeFont;
										foreground: Color gray;
										glamorousCodeTinySize)
						action: [ :each | self applyChanges: changes ] ] ].
	items
		addItemLabel: 'Apply all' asRopedText
				, ((' ' , allChanges size printString , ' changes') asRopedText
						glamorousCodeFont;
						foreground: Color gray;
						glamorousCodeTinySize)
		action: [ :each | self applyChanges: {group changes} ].
	^ items
]

{ #category : #accessing }
GtRBChangeGroupElement >> group [
	^ group
]

{ #category : #accessing }
GtRBChangeGroupElement >> group: changeGroup [
	group := changeGroup.
	self updateFilters
]

{ #category : #private }
GtRBChangeGroupElement >> groupTree [
	^ (self childNamed: #group)
		allChildrenBreadthFirstDetect: [ :each | each class = BrColumnedTree ]
		ifFound: [ :each | each ]
		ifNone: [ nil ]
]

{ #category : #initialization }
GtRBChangeGroupElement >> initialize [
	super initialize.
	self matchParent.
	group := GtRBCompositeChangeGroup new changes: RBCompositeRefactoryChange new.
	filteredGroup := group.
	self initializeFilters.
	self initializeGroupTree.
	self initializeApplyBar
]

{ #category : #initialization }
GtRBChangeGroupElement >> initializeApplyBar [
	| progress applyButton |
	progress := BrProgress new.
	progress aptitude: BrGlamorousProgressBarAptitude.
	progress
		margin: (BlInsets
				top: 5
				left: 10
				bottom: 15
				right: 10).
	progress
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	progress visibility: BlVisibility hidden.
	applyButton := BrButton new
			icon: BrGlamorousVectorIcons accept;
			beSmallSize;
			aptitude: BrGlamorousButtonWithIconAptitude new;
			label: 'Apply all';
			margin: (BlInsets
					top: 0
					left: 10
					bottom: 10
					right: 0);
			action: [ self applyChanges: (self allChangesIn: {filteredGroup}) ];
			yourself.
	self
		addChild: (BrHorizontalPane new
				vFitContent;
				hMatchParent;
				addChild: applyButton as: #applyButton;
				addChild: progress as: #progress)
]

{ #category : #initialization }
GtRBChangeGroupElement >> initializeFilters [
	| filters |
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
	self addChild: filters as: #filters
]

{ #category : #initialization }
GtRBChangeGroupElement >> initializeGroupTree [
	| tree |
	tree := (GtPhlowEmptyView new columnedTree
			title: 'Items';
			priority: 10;
			withMultipleSelection;
			items: [ #() ];
			children: self childrenBlock;
			column: 'Type'
				do: [ :column | 
					column
						width: 32;
						cellStencil: [ BrHorizontalPane new
								id: #type;
								fitContent ];
						dataBinder: [ :pane :change | 
							pane userData at: #change put: change.
							change gtChangeIcon
								ifNotNil: [ :icon | 
									pane
										removeChildren;
										addChild: icon asElement ] ] ];
			column: 'Description'
				text: [ :each | each name asRopedText ]
				weight: 0.75;
			column: '# of changes'
				text: [ :each | 
					(each isKindOf: RBRefactoryChange)
						ifTrue: [ '' ]
						ifFalse: [ each gtNumberOfChanges printString ] ]
				weight: 0.12;
			column: 'Applied'
				text: [ :each | each gtAppliedText ]
				weight: 0.13;
			dynamicContextItems: [ :element :aCollection | self dynamicMenuItemsFor: aCollection ])
			asElement.
	self addChild: tree as: #group
]

{ #category : #'error handling' }
GtRBChangeGroupElement >> processError: error [
	| context |
	context := error signalerContext.
	[ context notNil ]
		whileTrue: [ (context receiver isKindOf: RBRefactoryChange)
				ifTrue: [ ^ context receiver attributeNamed: #error put: error ].
			context := context sender ]
]

{ #category : #accessing }
GtRBChangeGroupElement >> updateFilteredChanges [
	| filterBlock |
	filterBlock := filterModel items
			inject: [ :each | true ]
			into: [ :sum :each | each creator cull: sum cull: each ].
	filteredGroup := group filter: filterBlock.
	self updateGroupTreeItems
]

{ #category : #accessing }
GtRBChangeGroupElement >> updateFilters [
	filterModel
		availableFiltersBuilder: (GtRefactoryChangeFiltersBuilder new
				changes: (RBCompositeRefactoryChange new changes: group allChanges)).
	self updateFilteredChanges
]

{ #category : #accessing }
GtRBChangeGroupElement >> updateGroupTreeItems [
	self groupTree items: filteredGroup items lazy: self childrenBlock
]
