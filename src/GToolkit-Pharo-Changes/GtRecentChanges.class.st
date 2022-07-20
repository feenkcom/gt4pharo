Class {
	#name : #GtRecentChanges,
	#superclass : #Object,
	#instVars : [
		'changeList',
		'groupedChanges'
	],
	#category : #'GToolkit-Pharo-Changes-Model'
}

{ #category : #accessing }
GtRecentChanges >> applyFiltersFrom: aFilterElement [
	| items |
	items := groupedChanges copy.
	"for every filter we apply it; it gives us back a list filter which we immediately apply also"
	aFilterElement
		filtersDo: [ :descriptor :value | items := (descriptor newFilterWithValue: value) value: items ].
	^ items
]

{ #category : #accessing }
GtRecentChanges >> changedClasses [
	^ (changeList collect: [:each | each method methodClass name ]) asSet
]

{ #category : #accessing }
GtRecentChanges >> classFilter [
	<gtRecentChangeFilter>
	^ GtFilterDescriptor new
		creator: [ :value | [ :aCollection | aCollection select: [ :aChange | aChange theClass name = value ] ] ];
		named: 'In Class';
		order: 12;
		completion: [ GtStringsCompletionStrategy new
				completions: [ GtPrefixTree withAll: self changedClasses ] ];
		beNotDefault
]

{ #category : #accessing }
GtRecentChanges >> computeRecentlyChanged [
	| allEntries changes lastSaved allSaved |
	allEntries := GtEpicea current entries.
	allSaved := allEntries
			select: [ :each | each content isKindOf: EpSessionSnapshot ].
	"the last save is the cut-off"
	lastSaved := allSaved size > 0
			ifTrue: [ allSaved first tagAt: #time ]
			ifFalse: [ DateAndTime epoch ].
	"we get all method changes that are recent enough and the class of which still exists"
	changes := allEntries
			select: [ :each | 
				(each content isKindOf: EpMethodChange)
					and: [ (each tagAt: #time) >= lastSaved
							and: [ each content methodAffected methodClass isNotNil ] ] ].
	"group the methods; if the last action is a removal, we get rid of it"
	changes := (changes groupedBy: [ :each | each content methodAffected ])
			reject: [ :each | each value last content isKindOf: EpMethodRemoval ].
	"the keys are the methods"
	changeList := changes keys asSet.
	"we then generate a list of RecentChange objects that map classes and methods"
	groupedChanges := ((changeList groupedBy: #methodClass) associations
			collect: [ :each | GtRecentChange class: each key methods: each value asOrderedCollection ])
			asOrderedCollection
]

{ #category : #accessing }
GtRecentChanges >> filterDescriptors [
	^ (GtPhlowCollector new
		fromObject: self;
		pragmaName: #gtRecentChangeFilter;
		collectAllPragmas)
		collect: [ :aPragma | self perform: aPragma methodSelector ]
]

{ #category : #accessing }
GtRecentChanges >> groupedChanges [
	^ groupedChanges
]

{ #category : #accessing }
GtRecentChanges >> gtEventsFor: aView [
	<gtView>
	^ aView list
		title: 'Change List';
		priority: 3;
		items: [ changeList asOrderedCollection ]
]

{ #category : #accessing }
GtRecentChanges >> gtTreeFor: aView [
	<gtView>
	^ aView tree
		title: 'Change Tree';
		expandUpTo: 1;
		priority: 3;
		items: [ groupedChanges ];
		children: #gtChildren;
		itemText: [ :each | each displayForTree ]
]

{ #category : #accessing }
GtRecentChanges >> initialize [
	super initialize.
	
	self setupListener.
	self computeRecentlyChanged
]

{ #category : #accessing }
GtRecentChanges >> onChangeOrAdd: anAnnouncement [
	(changeList includes: anAnnouncement method) ifTrue: [ ^ self ].
	changeList add: anAnnouncement method.
	groupedChanges
		detect: [ :each | each theClass = anAnnouncement method methodClass ]
		ifFound: [ :each | each add: anAnnouncement method asRingDefinition ]
		ifNone: [ groupedChanges
				add: (GtRecentChange
						class: anAnnouncement method methodClass
						methods: (OrderedCollection with: anAnnouncement method asRingDefinition)) ]
]

{ #category : #accessing }
GtRecentChanges >> onClassRemove: anAnnouncement [
	changeList := changeList reject: [ :each | each method isNil ].
	groupedChanges := groupedChanges
			reject: [ :each | each theClass = anAnnouncement classAffected ]
]

{ #category : #accessing }
GtRecentChanges >> onRemove: anAnnouncement [
	(changeList includes: anAnnouncement method) ifFalse: [ ^ self ].
	changeList remove: anAnnouncement method.
	groupedChanges
		detect: [ :each | each theClass = anAnnouncement method methodClass ]
		ifFound: [ :each | 
			each remove: anAnnouncement method asRingDefinition.
			each ifEmpty: [ groupedChanges remove: each ] ]
]

{ #category : #accessing }
GtRecentChanges >> setupListener [
	SystemAnnouncer uniqueInstance weak
		when: MethodAdded
		send: #onChangeOrAdd:
		to: self.
	SystemAnnouncer uniqueInstance weak
		when: MethodModified
		send: #onChangeOrAdd:
		to: self.
	SystemAnnouncer uniqueInstance weak
		when: MethodRemoved
		send: #onRemove:
		to: self.
	SystemAnnouncer uniqueInstance weak
		when: ClassRemoved
		send: #onClassRemove:
		to: self
]
