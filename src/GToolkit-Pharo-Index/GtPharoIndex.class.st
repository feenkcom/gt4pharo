Class {
	#name : #GtPharoIndex,
	#superclass : #Object,
	#instVars : [
		'globalCache',
		'selectorCache'
	],
	#classInstVars : [
		'current'
	],
	#category : #'GToolkit-Pharo-Index'
}

{ #category : #accessing }
GtPharoIndex class >> cacheSizeInMemory [
	^ self current cacheSizeInMemory
]

{ #category : #accessing }
GtPharoIndex class >> current [
	^ current ifNil: [ current := self new ]
]

{ #category : #accessing }
GtPharoIndex class >> initializeCache [
	self current initializeCache
]

{ #category : #private }
GtPharoIndex >> addSendsFrom: aMethod [
	| seen globalBlock selectorBlock |
	seen := Set new.
	globalBlock := [ :global | 
		| node |
		node := globalCache add: global name weight: 1.
		(seen includes: global)
			ifFalse: [ seen add: global.
				node addReference: aMethod ] ].
	selectorBlock := [ :selector :count | 
		| node |
		node := selectorCache add: selector weight: count.
		(seen includes: selector)
			ifFalse: [ seen add: selector.
				node addReference: aMethod ].
		selector first isUppercase
			ifTrue: [ Smalltalk globals associationAt: selector ifPresent: globalBlock ] ].
	aMethod
		pragmasDo: [ :each | self processPragma: each selectorsDo: selectorBlock ].
	GtMessageSendIterator
		messageSendsIn: aMethod
		doReferences: selectorBlock
		andGlobals: globalBlock
]

{ #category : #private }
GtPharoIndex >> addSymbolReferencesTo: newClassName [	| addedRefs |
	addedRefs := IdentitySet new.
	(self sendersOf: newClassName)
		do: [ :each | 
			GtMessageSendIterator
				messageSendsIn: each
				doReferences: [ :selector :count | 
					| node |
					selector = newClassName
						ifTrue: [ node := globalCache add: newClassName weight: count.
							(addedRefs includes: each)
								ifFalse: [ addedRefs add: each.
									node addReference: each ] ] ]
				andGlobals: [ :global |  ] ].
	^ addedRefs
]

{ #category : #accessing }
GtPharoIndex >> cacheSizeInMemory [
	^ globalCache gtSpecificSizeInMemory + selectorCache gtSpecificSizeInMemory
]

{ #category : #iterating }
GtPharoIndex >> cachedSelectorsDo: aBlock [
	"Evaluate aBlock with the name of the selector, implementers of that selector, and senders of that selector, 
	for all cached symbols in the image."

	selectorCache
		do: [ :each :weight :node | 
			aBlock
				cull: each asSymbol
				cull: (node implementers
						ifNil: [ #() ]
						ifNotNil: [ :i | i asOrderedCollection ])
				cull: (node references
						ifNil: [ #() ]
						ifNotNil: [ :r | r asOrderedCollection ]) ]
]

{ #category : #private }
GtPharoIndex >> classAdded: anAnnouncement [
	globalCache add: anAnnouncement classAdded name.
	self addSymbolReferencesTo: anAnnouncement classAdded name
]

{ #category : #private }
GtPharoIndex >> classRemoved: anAnnouncement [
	| className |
	className := anAnnouncement classRemoved name
			copyReplaceAll: 'AnObsolete'
			with: ''.
	(globalCache nodeFor: className)
		ifNotNil: [ :node | 
			node references: nil.
			globalCache remove: className weight: node weight ].
	anAnnouncement classRemoved instanceSide
		methodsDo: [ :each | self removeMethodFromCache: each ].
	anAnnouncement classRemoved classSide
		methodsDo: [ :each | self removeMethodFromCache: each ]
]

{ #category : #private }
GtPharoIndex >> classRenamed: anAnnouncement [
	| oldRefs addedRefs newClassName |
	"First remove the old entry"
	(globalCache nodeFor: anAnnouncement oldName)
		ifNil: [ oldRefs := #() ]
		ifNotNil: [ :node | 
			oldRefs := node references asOrderedCollection.
			node references: nil.
			globalCache remove: anAnnouncement oldName weight: node weight ].
			
	"Add new entry"
	newClassName := anAnnouncement newName.
	globalCache add: newClassName weight: 1.
	
	"Any symbol references to the new name should be marked as class references."
	addedRefs := self addSymbolReferencesTo: newClassName.
	
	"Update methods that have the variable reference to point to new variable. 
	At this point the source of the method and the method itself are out of sync. 
	The source of the method will have the old name and the method will have the renamed class."
	oldRefs
		do: [ :each | 
			GtMessageSendIterator
				messageSendsIn: each
				doReferences: [ :selector :count |  ]
				andGlobals: [ :global | 
					| node |
					global name = newClassName
						ifTrue: [ node := globalCache add: newClassName weight: 1.
							(addedRefs includes: each)
								ifFalse: [ addedRefs add: each.
									node addReference: each ] ] ] ]
]

{ #category : #accessing }
GtPharoIndex >> globalCache [
	^ globalCache
]

{ #category : #accessing }
GtPharoIndex >> globalVariableReferencesTo: aVariable [
	^ (globalCache referencesTo: aVariable name) asOrderedCollection
]

{ #category : #iterating }
GtPharoIndex >> implementersDo: aBlock [
	selectorCache
		do: [ :each :weight :node | (node implementers ifNil: [ #() ]) isEmpty ifFalse: [ aBlock value: each ] ]
]

{ #category : #accessing }
GtPharoIndex >> implementersOf: aSelector [
	^ selectorCache implementersOf: aSelector
]

{ #category : #initialization }
GtPharoIndex >> initialize [
	super initialize.
	selectorCache := GtCachingPrefixTree new.
	globalCache := GtCachingPrefixTree new
]

{ #category : #initialization }
GtPharoIndex >> initializeCache [
	| compactBlock |
	self unsubscribeFromSystem.
	selectorCache := GtCachingPrefixTree new.
	globalCache := GtCachingPrefixTree withAll: Smalltalk globals keys.
	Smalltalk
		allClassesDo: [ :each | 
			each methodsDo: [ :method | self methodAdded: method ].
			each class methodsDo: [ :method | self methodAdded: method ] ].
	compactBlock := [ :each | 
		each references isCollection
			ifTrue: [ each references: each references asArray ] ].
	selectorCache allNodesDo: compactBlock.
	globalCache allNodesDo: compactBlock.
	self subscribeToSystem
]

{ #category : #private }
GtPharoIndex >> methodAdded: anAnnouncement [
	| node |
	node := selectorCache add: anAnnouncement method selector weight: 1.
	node addImplementer: anAnnouncement method.
	self addSendsFrom: anAnnouncement method
]

{ #category : #private }
GtPharoIndex >> methodModified: anAnnouncement [
	(selectorCache nodeFor: anAnnouncement newMethod selector)
		ifNotNil: [ :node | 
			node
				removeImplementer: anAnnouncement oldMethod;
				addImplementer: anAnnouncement newMethod ].
	self removeSendsFrom: anAnnouncement oldMethod.
	self addSendsFrom: anAnnouncement newMethod
]

{ #category : #private }
GtPharoIndex >> methodRemoved: anAnnouncement [
	self removeMethodFromCache: anAnnouncement method
]

{ #category : #private }
GtPharoIndex >> processPragma: aPragma selectorsDo: selectorBlock [
	| todo item |
	selectorBlock cull: aPragma selector cull: 1.
	todo := OrderedCollection with: aPragma arguments.
	[ todo notEmpty ]
		whileTrue: [ item := todo removeFirst.
			item isSymbol
				ifTrue: [ item numArgs >= 0 ifTrue: [ selectorBlock cull: item cull: 1 ] ]
				ifFalse: [ item isArray ifTrue: [ todo addAll: item ] ] ]
]

{ #category : #private }
GtPharoIndex >> removeMethodFromCache: method [
	(selectorCache remove: method selector weight: 1)
		ifNotNil: [ :node | node removeImplementer: method ].
	self removeSendsFrom: method
]

{ #category : #private }
GtPharoIndex >> removeSendsFrom: aMethod [
	| seen globalBlock selectorBlock |
	seen := Set new.
	globalBlock := [ :global | 
		| node |
		node := globalCache remove: global name weight: 1.
		(seen includes: global)
			ifFalse: [ seen add: global.
				node ifNotNil: [ node removeReference: aMethod ] ] ].
	selectorBlock := [ :selector :count | 
		(selectorCache remove: selector weight: count)
			ifNotNil: [ :node | 
				(seen includes: selector)
					ifFalse: [ seen add: selector.
						node removeReference: aMethod ] ].
		selector first isUppercase
			ifTrue: [ Smalltalk globals associationAt: selector ifPresent: globalBlock ] ].
	aMethod
		pragmasDo: [ :each | self processPragma: each selectorsDo: selectorBlock ].
	GtMessageSendIterator
		messageSendsIn: aMethod
		doReferences: selectorBlock
		andGlobals: globalBlock
]

{ #category : #accessing }
GtPharoIndex >> selectorCache [
	^ selectorCache
]

{ #category : #accessing }
GtPharoIndex >> sendersOf: aSelector [
	^ (selectorCache referencesTo: aSelector) asOrderedCollection
]

{ #category : #private }
GtPharoIndex >> subscribeToSystem [
	SystemAnnouncer uniqueInstance weak
		when: MethodAdded send: #methodAdded: to: self;
		when: MethodModified send: #methodModified: to: self;
		when: MethodRemoved send: #methodRemoved: to: self;
		when: ClassAdded send: #classAdded: to: self;
		when: ClassRemoved send: #classRemoved: to: self;
		when: ClassRenamed send: #classRenamed: to: self
]

{ #category : #private }
GtPharoIndex >> unsubscribeFromSystem [
	SystemAnnouncer uniqueInstance unsubscribe: self
]
