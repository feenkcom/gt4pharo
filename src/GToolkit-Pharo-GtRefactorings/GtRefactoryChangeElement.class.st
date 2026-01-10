Class {
	#name : #GtRefactoryChangeElement,
	#superclass : #BrVerticalPane,
	#instVars : [
		'changes',
		'filteredChanges',
		'filterModel'
	],
	#category : #'GToolkit-Pharo-GtRefactorings-Changes-View'
}

{ #category : #'instance creation' }
GtRefactoryChangeElement class >> forChanges: compositeChanges [
	^ self new
		changes: compositeChanges;
		yourself
]

{ #category : #executing }
GtRefactoryChangeElement >> applyChanges: aCollection [
	| applyButton progress composite |
	applyButton := self childNamed: #applyButton.
	progress := self childNamed: #progress.
	applyButton disable.
	(aCollection size = 1 and: [ aCollection first == changes ])
		ifTrue: [ composite := changes ]
		ifFalse: [ composite := RBCompositeRefactoryChange new.
			composite
				name: (aCollection size = 1
						ifTrue: [ aCollection first name ]
						ifFalse: [ changes name ]).
			changes gtBasicChanges
				do: [ :each | (aCollection identityIncludes: each) ifTrue: [ composite addChange: each ] ] ].
	composite changesSize > 1 ifTrue: [ progress visibility: BlVisibility visible ].
	progress fraction: 0.
	(composite
		gtExecuteWithNotificationWithProgress: [ :fraction | progress enqueueTask: (BlTaskAction new action: [ progress fraction: fraction ]) ])
		then: [ :undo | 
			self
				enqueueTask: [ self updateChangesList.
					progress visibility: BlVisibility hidden.
					applyButton enable ] asBlTask ]
]

{ #category : #accessing }
GtRefactoryChangeElement >> changes [
	^ changes
]

{ #category : #accessing }
GtRefactoryChangeElement >> changes: compositeChanges [
	changes := compositeChanges.
	self updateFilters
]

{ #category : #initialization }
GtRefactoryChangeElement >> initialize [
	super initialize.
	changes := RBCompositeRefactoryChange new.
	self matchParent.
	self initializeFilter.
	self initializeList.
	self initializeApplyBar
]

{ #category : #initialization }
GtRefactoryChangeElement >> initializeApplyBar [
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
			label: 'Apply';
			margin: (BlInsets
					top: 0
					left: 10
					bottom: 10
					right: 0);
			action: [ filteredChanges asyncSimilarCopy toArray await
					then: [ :col | self applyChanges: col ] ];
			yourself.
	self
		addChild: (BrHorizontalPane new
				vFitContent;
				hMatchParent;
				addChild: applyButton as: #applyButton;
				addChild: progress as: #progress)
]

{ #category : #initialization }
GtRefactoryChangeElement >> initializeFilter [
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
GtRefactoryChangeElement >> initializeList [
	| list |
	list := BrColumnedList new.
	list matchParent.
	list aptitude: BrColumnedMultiListAptitude.
	list column
		title: 'Type';
		cellStencil: [ BlElement new
				id: #type;
				layout: BlLinearLayout horizontal alignCenter;
				constraintsDo: [ :c | 
					c horizontal fitContent.
					c vertical fitContent ] ];
		dataBinder: [ :element :change | 
			element userData at: #change put: change.
			element
				removeChildren;
				addChild: change gtChangeIcon asElement ];
		width: 32.
	list column
		title: 'Description';
		matchParent;
		cellStencil: [ :each | BrLabel new aptitude: BrGlamorousLabelAptitude new ];
		dataBinder: [ :label :change | label text: change gtDescription ].
	list column
		width: 150;
		title: 'Performed';
		cellStencil: [ :each | BrLabel new aptitude: BrGlamorousLabelAptitude new ];
		dataBinder: [ :label :change | 
			label
				text: ((change attributeNamed: #timestamp)
						ifNil: [ '' asRopedText ]
						ifNotNil: [ :ts | ts printToSeconds ]) ].
	list addEventHandler: GtPhlowListToSelectHandler new.
	list
		rowStencil: (GtPhlowColumnedListItemElementWithContextMenuDecorator new
				stencilBuilder: (BrGlamorousColumnedListSelectableRowElementStencilBuilder new cellSpacing: 10);
				contextMenuStencil: [ :element :item | 
					| contextMenuItems change selectedChanges |
					change := element
							childNamed: #type
							ifFound: [ :e | e userData at: #change ifAbsent: [  ] ]
							ifNone: [  ].
					contextMenuItems := OrderedCollection new.
					contextMenuItems
						add: ('Apply' asRopedText
								, ((' ' , change gtDescription) asRopedText
										glamorousCodeFont;
										foreground: Color gray;
										glamorousCodeTinySize)) -> [ :e | self applyChanges: {change} ].
					selectedChanges := list selectedItems.
					(selectedChanges notEmpty
						and: [ selectedChanges size < changes gtBasicChanges size
								and: [ selectedChanges size > 1 or: [ selectedChanges first ~~ change ] ] ])
						ifTrue: [ contextMenuItems
								add: 'Apply selected' -> [ :e | self applyChanges: selectedChanges ] ].
					contextMenuItems
						add: 'Apply all'
								-> [ :e | 
									filteredChanges asyncSimilarCopy toArray await
										then: [ :col | self applyChanges: col ] ].
					BrGlamorousSimpleContextMenuContent new items: contextMenuItems ]).
	self addChild: list as: #changes.
	list addAptitude: (BrColumnedListHeaderAptitude new cellSpacing: 10)
]

{ #category : #accessing }
GtRefactoryChangeElement >> updateChangesList [
	(self childNamed: #changes) stream: filteredChanges asyncSimilarCopy
]

{ #category : #accessing }
GtRefactoryChangeElement >> updateFilteredChanges [
	| items |
	items := changes gtBasicChanges asAsyncStream.
	filterModel items do: [ :each | items := each creator cull: items cull: each ].
	filteredChanges := items.
	self updateChangesList
]

{ #category : #accessing }
GtRefactoryChangeElement >> updateFilters [
	filterModel
		availableFiltersBuilder: (GtRefactoryChangeFiltersBuilder new changes: changes).
	self updateFilteredChanges
]
