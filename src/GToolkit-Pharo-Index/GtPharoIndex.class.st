Class {
	#name : #GtPharoIndex,
	#superclass : #Object,
	#instVars : [
		'globalCache',
		'selectorCache',
		'active',
		'shouldRecomputeSubclasses'
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

{ #category : #testing }
GtPharoIndex class >> isActive [
	^ current ifNil: [ false ] ifNotNil: [ current isActive ]
]

{ #category : #private }
GtPharoIndex >> addSendsFrom: aMethod [
	| seen globalBlock selectorBlock method |
	method := aMethod gtOriginalMethod.
	seen := Set new.
	globalBlock := [ :global | 
		| node |
		(self isVariableForClass: global)
			ifTrue: [ node := globalCache add: global name weight: 1.
				(seen includes: global)
					ifFalse: [ seen add: global.
						node addReference: method ] ] ].
	selectorBlock := [ :selector :count | 
		| node |
		node := selectorCache add: selector weight: count.
		(seen includes: selector)
			ifFalse: [ seen add: selector.
				node addReference: method ].
		selector first isUppercase
			ifTrue: [ Smalltalk globals associationAt: selector ifPresent: globalBlock ] ].
	method
		pragmasDo: [ :each | self processPragma: each selectorsDo: selectorBlock ].
	GtMessageSendIterator
		messageSendsIn: method
		doReferences: selectorBlock
		andVariables: globalBlock
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
				andVariables: [ :global |  ] ].
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
				cull: node implementersCollection
				cull: node referencesCollection ]
]

{ #category : #private }
GtPharoIndex >> classAdded: anAnnouncement [
	globalCache add: anAnnouncement classAdded name.
	self addSymbolReferencesTo: anAnnouncement classAdded name
]

{ #category : #private }
GtPharoIndex >> classModified: anAnnouncement [
	| class |
	class := anAnnouncement classAffected.
	shouldRecomputeSubclasses
		ifTrue: [ class withAllSubclassesDo: [ :each | self recompileMethodsIn: each ] ]
		ifFalse: [ self recompileMethodsIn: class ]
]

{ #category : #accessing }
GtPharoIndex >> classModifiedClassDefinition: anAnnouncement [
	"Adding class variables or pool variables only announce the class as being changed, 
	but the subclasses are recompiled, so we need to know if we should also recache the 
	subclasses when we get the modified event."

	| oldClass newClass |
	oldClass := anAnnouncement oldClassDefinition.
	newClass := anAnnouncement newClassDefinition.
	shouldRecomputeSubclasses := newClass isClassSide not
			and: [ oldClass instVarNames = newClass instVarNames
					and: [ oldClass classVarNames ~= newClass classVarNames
							or: [ oldClass sharedPools ~= newClass sharedPools ] ] ]
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
			oldRefs := node referencesCollection.
			node references: nil.
			globalCache remove: anAnnouncement oldName weight: node weight ].	"Add new entry"
	newClassName := anAnnouncement newName.
	globalCache add: newClassName weight: 1.	"Any symbol references to the new name should be marked as class references."
	addedRefs := self addSymbolReferencesTo: newClassName.	"Update methods that have the variable reference to point to new variable. 
	At this point the source of the method and the method itself are out of sync. 
	The source of the method will have the old name and the method will have the renamed class."
	oldRefs
		do: [ :each | 
			GtMessageSendIterator
				messageSendsIn: each
				doReferences: [ :selector :count |  ]
				andVariables: [ :global | 
					| node |
					(self isVariableForClass: global)
						ifTrue: [ global name = newClassName
								ifTrue: [ node := globalCache add: newClassName weight: 1.
									(addedRefs includes: each)
										ifFalse: [ addedRefs add: each.
											node addReference: each ] ] ] ] ]
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
	selectorCache := GtReferencesAndImplementersPrefixTree new.
	globalCache := GtReferencesPrefixTree new.
	active := false.
	shouldRecomputeSubclasses := false
]

{ #category : #initialization }
GtPharoIndex >> initializeCache [
	self unsubscribeFromSystem.
	selectorCache := GtReferencesAndImplementersPrefixTree new.
	globalCache := GtReferencesPrefixTree withAll: Smalltalk globals keys.
	Smalltalk
		allClassesDo: [ :each | 
			each methodsDo: [ :method | self methodAdded: method ].
			each class methodsDo: [ :method | self methodAdded: method ] ].
	selectorCache allNodesDo: #compressData.
	globalCache allNodesDo: #compressData.
	self subscribeToSystem
]

{ #category : #testing }
GtPharoIndex >> isActive [
	^ active
]

{ #category : #testing }
GtPharoIndex >> isVariableForClass: aVariable [
	^ (aVariable isKindOf: GlobalVariable)
		and: [ aVariable value isBehavior
				and: [ (self class environment bindingOf: aVariable name) == aVariable ] ]
]

{ #category : #private }
GtPharoIndex >> methodAdded: anAnnouncement [
	| node |
	anAnnouncement method isFromTrait ifTrue: [ ^ self ].
	node := selectorCache add: anAnnouncement method selector weight: 1.
	node addImplementer: anAnnouncement method gtOriginalMethod.
	self addSendsFrom: anAnnouncement method
]

{ #category : #private }
GtPharoIndex >> methodModified: anAnnouncement [
	anAnnouncement newMethod isFromTrait ifTrue: [ ^ self ].
	(selectorCache nodeFor: anAnnouncement newMethod selector)
		ifNotNil: [ :node | 
			node
				removeImplementer: anAnnouncement oldMethod gtOriginalMethod;
				addImplementer: anAnnouncement newMethod gtOriginalMethod ].
	self removeSendsFrom: anAnnouncement oldMethod.
	self addSendsFrom: anAnnouncement newMethod
]

{ #category : #private }
GtPharoIndex >> methodRemoved: anAnnouncement [
	anAnnouncement method isFromTrait ifTrue: [ ^ self ].
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
GtPharoIndex >> recompileMethodsIn: aBehavior [
	aBehavior instanceSide methodsDo: [ :method | self recompiledMethod: method ].
	aBehavior classSide methodsDo: [ :method | self recompiledMethod: method ]
]

{ #category : #accessing }
GtPharoIndex >> recompiledMethod: aMethod [
	| seen selectorBlock globalBlock method |
	aMethod isFromTrait ifTrue: [ ^ self ].
	method := aMethod gtOriginalMethod.
	(selectorCache nodeFor: method selector)
		ifNotNil: [ :node | node updateImplementer: method ].
	seen := Set new.
	globalBlock := [ :global | 
		(self isVariableForClass: global)
			ifTrue: [ (seen includes: global)
					ifFalse: [ seen add: global.
						(globalCache nodeFor: global name)
							ifNotNil: [ :node | node updateReference: method ] ] ] ].
	selectorBlock := [ :selector :count | 
		(seen includes: selector)
			ifFalse: [ seen add: selector.
				(selectorCache nodeFor: selector)
					ifNotNil: [ :node | node updateReference: method ] ].
		selector first isUppercase
			ifTrue: [ Smalltalk globals associationAt: selector ifPresent: globalBlock ] ].
	method
		pragmasDo: [ :each | self processPragma: each selectorsDo: selectorBlock ].
	GtMessageSendIterator
		messageSendsIn: method
		doReferences: selectorBlock
		andVariables: globalBlock
]

{ #category : #private }
GtPharoIndex >> removeMethodFromCache: method [
	method isFromTrait ifTrue: [ ^ self ].
	(selectorCache remove: method selector weight: 1)
		ifNotNil: [ :node | node removeImplementer: method gtOriginalMethod ].
	self removeSendsFrom: method
]

{ #category : #private }
GtPharoIndex >> removeSendsFrom: aMethod [
	| seen globalBlock selectorBlock method |
	method := aMethod gtOriginalMethod.
	seen := Set new.
	globalBlock := [ :global | 
		| node |
		(self isVariableForClass: global)
			ifTrue: [ node := globalCache remove: global name weight: 1.
				(seen includes: global)
					ifFalse: [ seen add: global.
						node ifNotNil: [ node removeReference: method ] ] ] ].
	selectorBlock := [ :selector :count | 
		(selectorCache remove: selector weight: count)
			ifNotNil: [ :node | 
				(seen includes: selector)
					ifFalse: [ seen add: selector.
						node removeReference: method ] ].
		selector first isUppercase
			ifTrue: [ Smalltalk globals associationAt: selector ifPresent: globalBlock ] ].
	method
		pragmasDo: [ :each | self processPragma: each selectorsDo: selectorBlock ].
	GtMessageSendIterator
		messageSendsIn: method
		doReferences: selectorBlock
		andVariables: globalBlock
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
		when: ClassRenamed send: #classRenamed: to: self;
		when: ClassModifiedClassDefinition send: #classModifiedClassDefinition: to: self;
		when: ClassModificationApplied send: #classModified: to: self.
	active := true
]

{ #category : #private }
GtPharoIndex >> unsubscribeFromSystem [
	SystemAnnouncer uniqueInstance unsubscribe: self.
	active := false
]
