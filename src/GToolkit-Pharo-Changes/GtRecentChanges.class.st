Class {
	#name : #GtRecentChanges,
	#superclass : #Object,
	#instVars : [
		'changeList',
		'groupedChanges'
	],
	#category : #'GToolkit-Pharo-Changes'
}

{ #category : #accessing }
GtRecentChanges >> computeRecentlyChanged [
	| allEntries changes lastSaved |
	allEntries := GtEpicea allInSessionStore flatCollect: [ :each | each entries ].
	lastSaved := (allEntries
			select: [ :each | each content isKindOf: EpSessionSnapshot ]) first
			tagAt: #time.
	changes := allEntries
			select: [ :each | 
				(each content isKindOf: EpMethodChange)
					and: [ (each tagAt: #time) >= lastSaved ] ].
	changes := (changes groupedBy: [ :each | each content methodAffected ])
			reject: [ :each | each value last content isKindOf: EpMethodRemoval ].
	changeList := changes keys asOrderedCollection.
	groupedChanges := ((changeList groupedBy: #methodClass) associations collect: [:each | GtRecentChange class: each key methods: each value asOrderedCollection ]) asOrderedCollection
]

{ #category : #accessing }
GtRecentChanges >> gtEventsFor: aView [
	<gtView>
	^ aView list
		title: 'Change List';
		priority: 3;
		items: [ changeList ]
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
		to: self
]
