Class {
	#name : #GtPharoIndex,
	#superclass : #GtIndex,
	#instVars : [
		'globalCache',
		'selectorCache',
		'selectorWordCache',
		'classWordCache'
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
GtPharoIndex class >> disableDebugMode [
	GtReferencesAndImplementersPrefixTree disableDebugMode
]

{ #category : #accessing }
GtPharoIndex class >> enableDebugMode [
	GtReferencesAndImplementersPrefixTree enableDebugMode
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
GtPharoIndex >> addClassWordsFor: newClassName [
	self
		wordsIn: newClassName
		do: [ :word | (classWordCache add: word asLowercase weight: 1) addName: newClassName ]
]

{ #category : #private }
GtPharoIndex >> addSendsFrom: aMethod [
	| seen globalBlock selectorBlock method indexMethod |
	method := aMethod gtOriginalMethod.
	indexMethod := aMethod gtIndexMethod.
	seen := Set new.
	globalBlock := [ :global | 
		| node |
		(self isGlobalVariable: global)
			ifTrue: [ node := globalCache add: global name weight: 1.
				(seen includes: global)
					ifFalse: [ seen add: global.
						node addReference: indexMethod ] ] ].
	selectorBlock := [ :selector :count | 
		| node |
		node := selectorCache add: selector weight: count.
		(seen includes: selector)
			ifFalse: [ node weight = count
					ifTrue: [ self
							wordsIn: selector
							do: [ :word | (selectorWordCache add: word asLowercase weight: 1) addName: selector ] ].
				seen add: selector.
				node addReference: indexMethod ] ].
	method
		pragmasDo: [ :each | self processPragma: each selectorsDo: selectorBlock ].
	GtMessageSendIterator
		messageSendsIn: method
		doReferences: selectorBlock
		andVariables: globalBlock
]

{ #category : #private }
GtPharoIndex >> addSymbolReferencesTo: newClassName [
	| addedRefs |
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

{ #category : #'accessing - implementers' }
GtPharoIndex >> allImplementersOf: aSelector [
	^ selectorCache implementersOf: aSelector
]

{ #category : #'accessing - senders' }
GtPharoIndex >> allSendersOf: aSelector [
	^ (selectorCache referencesTo: aSelector) asOrderedCollection
]

{ #category : #'accessing - implementers' }
GtPharoIndex >> asyncAllImplementersForWord: aString [
	^ ((self asyncSelectorsForWord: aString)
		collect: [ :each | 
			(selectorCache nodeFor: each)
				ifNil: [ #() asAsyncStream ]
				ifNotNil: [ :node | node implementersCollection asAsyncStream ] ]) flatten
]

{ #category : #'accessing - senders' }
GtPharoIndex >> asyncAllSendersForWord: aString [
	^ ((self asyncSelectorsForWord: aString)
		collect: [ :each | 
			(selectorCache nodeFor: each)
				ifNil: [ #() asAsyncStream ]
				ifNotNil: [ :node | node referencesCollection asAsyncStream ] ]) flatten
		withoutDuplicates
]

{ #category : #accessing }
GtPharoIndex >> asyncClassNamesForWord: aString [
	^ self
		asyncNamesForWord: aString
		usingPrefixCache: globalCache
		andWordCache: classWordCache
]

{ #category : #accessing }
GtPharoIndex >> asyncClassesForWord: aString [
	^ ((self asyncClassNamesForWord: aString)
		collect: [ :each | Smalltalk at: each asSymbol ifAbsent: [  ] ])
		select: [ :each | each notNil ]
]

{ #category : #'accessing - implementers' }
GtPharoIndex >> asyncImplementersForWord: aString [
	^ self asyncInstalledImplementersForWord: aString
]

{ #category : #'accessing - implementers' }
GtPharoIndex >> asyncImplementersForWord: aString convertUsing: aWordToCompiledMethodBlock [
	"Return an async stream with compiled methods.
	aWordToCompiledMethodBlock receives a selector and returns compiled method or nil."

	^ ((self
		asyncSearchForWords: aString
		in: selectorWordCache)
		collect: aWordToCompiledMethodBlock)
		select: [ :aCompiledMethodOrNil | 
			aCompiledMethodOrNil notNil and: [ aCompiledMethodOrNil gtIsActive ] ].
]

{ #category : #'accessing - implementers' }
GtPharoIndex >> asyncInstalledImplementersForWord: aString [
	^ (self asyncAllImplementersForWord: aString)
		select: [ :aCompiledMethod | aCompiledMethod gtIsActive ]
]

{ #category : #'accessing - senders' }
GtPharoIndex >> asyncInstalledSendersForWord: aString [
	^ (self asyncAllSendersForWord: aString)
		select: [ :aCompiledaMethod | aCompiledaMethod gtIsActive ]
]

{ #category : #accessing }
GtPharoIndex >> asyncKeywordImplementorsFor: anArray [
	^ (self asyncSelectorsForWord: (' ' join: anArray))
		select: [ :each | 
			(self hasImplementersOf: each)
				and: [ (self map: each toKeywords: anArray) notNil ] ]
]

{ #category : #private }
GtPharoIndex >> asyncNamesForWord: aString usingPrefixCache: prefixCache andWordCache: wordCache [
	"Ordered the results by first ones with exact matches, and then with case-insensitve prefix match, 
	and finally by word matches."

	| wordStream trimmedString includesString |
	trimmedString := aString trim.
	wordStream := self asyncOrderedSearchForWords: trimmedString in: wordCache.
	includesString := prefixCache includes: trimmedString.
	^ (((includesString
		ifTrue: [ {trimmedString} ]
		ifFalse: [ (prefixCache exactMatchFor: trimmedString caseSensitive: false)
				ifNil: [ #() ]
				ifNotNil: [ :str | {str} ] ]) asAsyncStream
		merge: (prefixCache asyncWeightedStreamStartingWith: trimmedString caseSensitive: false))
		merge: wordStream) withoutDuplicates
			useContentComparison
]

{ #category : #accessing }
GtPharoIndex >> asyncSelectorsForWord: aString [
	^ self
		asyncNamesForWord: aString
		usingPrefixCache: selectorCache
		andWordCache: selectorWordCache
]

{ #category : #'accessing - senders' }
GtPharoIndex >> asyncSendersForWord: aString [
	^ self asyncInstalledSendersForWord: aString
]

{ #category : #private }
GtPharoIndex >> basicSubscribe [
	SystemAnnouncer uniqueInstance weak
		when: MethodAdded
			send: #methodAdded:
			to: self;
		when: MethodModified , GtReflectiveMethodInstalled , GtMethodRecompiled
			send: #methodModified:
			to: self;
		when: MethodRemoved
			send: #methodRemoved:
			to: self;
		when: ClassAdded
			send: #classAdded:
			to: self;
		when: ClassRemoved
			send: #classRemoved:
			to: self;
		when: ClassRenamed
			send: #classRenamed:
			to: self;
		when: GtClassRecompiled
			send: #classRecompiled:
			to: self
]

{ #category : #private }
GtPharoIndex >> basicUnsubscribe [
	SystemAnnouncer uniqueInstance unsubscribe: self
]

{ #category : #'accessing - metrics' }
GtPharoIndex >> cacheSizeInMemory [
	| strings size |
	size := 0.
	strings := IdentitySet new.
	{
		globalCache.
		selectorCache.
		selectorWordCache.
		classWordCache
	}
		do: [ :tree | 
			tree allNodesDo: [ :each | 
				each prefix isSymbol 
					ifFalse: [ strings add: each prefix ] ].
			size := size + tree gtSpecificSizeInMemory ].
	
	strings do: [ :each | size := size + each sizeInMemory ].
	^ size
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
	| newName |
	newName := anAnnouncement classAdded name.
	globalCache add: newName.
	self addClassWordsFor: newName
]

{ #category : #accessing }
GtPharoIndex >> classNameTree [
	^ GtPrefixTreeFilter new
		tree: globalCache;
		filter: [ :each | (Smalltalk at: each asSymbol ifAbsent: [  ]) isBehavior ];
		yourself
]

{ #category : #private }
GtPharoIndex >> classRecompiled: anAnnouncement [
	self recompileMethodsIn: anAnnouncement classAffected
]

{ #category : #private }
GtPharoIndex >> classRemoved: anAnnouncement [
	| className |
	className := anAnnouncement classRemoved name
			copyReplaceAll: 'AnObsolete'
			with: ''.
	(globalCache nodeFor: className)
		ifNotNil: [ :node | globalCache remove: className ].
	self removeClassWordsFor: className.
	anAnnouncement classRemoved instanceSide
		methodsDo: [ :each | self removeMethodFromCache: each ].
	anAnnouncement classRemoved classSide
		methodsDo: [ :each | self removeMethodFromCache: each ]
]

{ #category : #private }
GtPharoIndex >> classRenamed: anAnnouncement [
	| oldRefs addedRefs newClassName oldClassName |
	oldClassName := anAnnouncement oldName.
	newClassName := anAnnouncement newName.
	
	"Fix references using dictionaries"
	selectorCache classRenamedFrom: oldClassName to: newClassName.
	globalCache classRenamedFrom: oldClassName to: newClassName.
	
	"Remove the old entry"
	(globalCache nodeFor: oldClassName)
		ifNil: [ oldRefs := #() ]
		ifNotNil: [ :node | 
			oldRefs := node referencesCollection.
			node references: nil.
			globalCache remove: oldClassName weight: node weight ].
	self removeClassWordsFor: oldClassName.
	
	"Add new entry"
	globalCache add: newClassName weight: 1.
	self addClassWordsFor: newClassName.
	
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
				andVariables: [ :global | 
					| node |
					(self isGlobalVariable: global)
						ifTrue: [ global name = newClassName
								ifTrue: [ node := globalCache add: newClassName weight: 1.
									(addedRefs includes: each)
										ifFalse: [ addedRefs add: each.
											node addReference: each ] ] ] ] ]
]

{ #category : #'accessing - metrics' }
GtPharoIndex >> classWordCacheSpecificSize [
	^ classWordCache gtSpecificSizeInMemory
]

{ #category : #initialization }
GtPharoIndex >> computeIndex [
	| compressBlock prefixes |
	selectorCache := GtReferencesAndImplementersPrefixTree new.
	globalCache := GtReferencesPrefixTree withAll: Smalltalk globals keys.
	selectorWordCache := GtNamesPrefixTree new.
	classWordCache := GtNamesPrefixTree new.
	Smalltalk
		allClassesDo: [ :each | 
			self addClassWordsFor: each name.
			each methodsDo: [ :method | self methodAdded: method ].
			each class methodsDo: [ :method | self methodAdded: method ] ].
	prefixes := Dictionary new.
	compressBlock := [ :each | 
		each compressData.
		each prefix: (prefixes at: each prefix ifAbsentPut: [ each prefix ]) ].
	selectorCache allNodesDo: compressBlock.
	globalCache allNodesDo: compressBlock.
	selectorWordCache allNodesDo: compressBlock.
	classWordCache allNodesDo: compressBlock
]

{ #category : #accessing }
GtPharoIndex >> globalCache [
	^ globalCache
]

{ #category : #'accessing - metrics' }
GtPharoIndex >> globalCacheSpecificSize [
	^ globalCache gtSpecificSizeInMemory
]

{ #category : #accessing }
GtPharoIndex >> globalVariableReferencesTo: aVariable [
	| indirectReferences directReferences allRefs |
	directReferences := (globalCache referencesTo: aVariable name)
			asOrderedCollection.
	indirectReferences := self allSendersOf: aVariable name.
	indirectReferences isEmpty ifTrue: [ ^ directReferences ].
	directReferences isEmpty ifTrue: [ ^ indirectReferences ].
	allRefs := IdentitySet new: directReferences size + indirectReferences size.
	allRefs addAll: directReferences.
	allRefs addAll: indirectReferences.
	^ allRefs asOrderedCollection
]

{ #category : #testing }
GtPharoIndex >> hasImplementersOf: aSelector [
	^ (selectorCache nodeFor: aSelector) implementers notNil
]

{ #category : #iterating }
GtPharoIndex >> implementersDo: aBlock [
	selectorCache
		do: [ :each :weight :node | (node implementers ifNil: [ #() ]) isEmpty ifFalse: [ aBlock value: each ] ]
]

{ #category : #'accessing - implementers' }
GtPharoIndex >> implementersOf: aSelector [
	^ self installedImplementersOf: aSelector
]

{ #category : #initialization }
GtPharoIndex >> initialize [
	super initialize.
	selectorCache := GtReferencesAndImplementersPrefixTree new.
	globalCache := GtReferencesPrefixTree new.
	selectorWordCache := GtNamesPrefixTree new.
	classWordCache := GtNamesPrefixTree new
]

{ #category : #'accessing - implementers' }
GtPharoIndex >> installedImplementersOf: aSelector [
	^ (self allImplementersOf: aSelector)
		select: [ :each | each gtIsActive ]
]

{ #category : #'accessing - senders' }
GtPharoIndex >> installedSendersOf: aSelector [
	^ (self allSendersOf: aSelector) 
		select: [ :each | each gtIsActive ]
]

{ #category : #testing }
GtPharoIndex >> isGlobalVariable: aVariable [
	^ (aVariable isKindOf: GlobalVariable) or: [
		(aVariable isKindOf: UndeclaredVariable) ]
]

{ #category : #accessing }
GtPharoIndex >> map: aSelector toKeywords: anArray [
	| selector otherKeywords index map |
	map := OrderedCollection new: anArray size.
	selector := aSelector asSymbol.
	index := 0.
	otherKeywords := selector keywords.
	anArray
		do: [ :kw | 
			kw last = $:
				ifTrue: [ index := otherKeywords indexOf: kw startingAt: index + 1 ]
				ifFalse: [ | myWords |
					myWords := self wordsIn: kw.
					index := (index + 1 to: otherKeywords size)
							detect: [ :i | 
								| otherWords currentIndex |
								otherWords := self wordsIn: (otherKeywords at: i).
								currentIndex := 0.
								myWords
									allSatisfy: [ :e | 
										currentIndex := (currentIndex + 1 to: otherWords size)
												detect: [ :j | (otherWords at: j) beginsWith: e ]
												ifNone: [ 0 ].
										currentIndex > 0 ] ]
							ifNone: [ 0 ] ].
			index > 0 ifFalse: [ ^ nil ].
			map add: index ].
	^ map
]

{ #category : #private }
GtPharoIndex >> methodAdded: anAnnouncement [
	| node |
	anAnnouncement method isFromTrait ifTrue: [ ^ self ].
	node := selectorCache add: anAnnouncement method selector weight: 1.
	node weight = 1
		ifTrue: [ self
				wordsIn: anAnnouncement method selector
				do: [ :word | (selectorWordCache add: word asLowercase weight: 1) addName: anAnnouncement method selector ] ].
	node addImplementer: anAnnouncement method gtIndexMethod.
	self addSendsFrom: anAnnouncement method
]

{ #category : #private }
GtPharoIndex >> methodModified: anAnnouncement [
	anAnnouncement newMethod isFromTrait ifTrue: [ ^ self ].
	(selectorCache nodeFor: anAnnouncement newMethod selector)
		ifNotNil: [ :node | 
			node
				removeImplementer: anAnnouncement oldMethod gtIndexMethod;
				addImplementer: anAnnouncement newMethod gtIndexMethod ].
	self removeSendsFrom: anAnnouncement oldMethod.
	self addSendsFrom: anAnnouncement newMethod
]

{ #category : #private }
GtPharoIndex >> methodRemoved: anAnnouncement [
	anAnnouncement method isFromTrait ifTrue: [ ^ self ].
	self removeMethodFromCache: anAnnouncement method
]

{ #category : #'accessing - metrics' }
GtPharoIndex >> prefixStringsSizeInMemory [
	| strings size |
	size := 0.
	strings := IdentitySet new.
	{
		globalCache.
		selectorCache.
		selectorWordCache.
		classWordCache
	}
		do: [ :tree | 
			tree allNodesDo: [ :each | 
				each prefix isSymbol 
					ifFalse: [ strings add: each prefix ] ] ].
	
	strings do: [ :each | size := size + each sizeInMemory ].
	^ size
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
	| seen selectorBlock globalBlock method convertedToClasses convertedFromClasses indexMethod |
	aMethod isFromTrait ifTrue: [ ^ self ].
	method := aMethod gtOriginalMethod.
	indexMethod := aMethod gtIndexMethod.
	(selectorCache nodeFor: method selector)
		ifNotNil: [ :node | node updateImplementer: indexMethod ].
	seen := Set new.
	convertedFromClasses := Set new.
	convertedToClasses := Set new.
	globalBlock := [ :global | 
		(seen includes: global)
			ifTrue: [ ((global isKindOf: LiteralVariable) and: [ global name notNil ])
					ifTrue: [ (convertedToClasses includes: global name)
							ifTrue: [ globalCache add: global name weight: 1 ].
						(convertedFromClasses includes: global name)
							ifTrue: [ globalCache remove: global name weight: 1 ] ] ]
			ifFalse: [ seen add: global.
				(self isGlobalVariable: global)
					ifTrue: [ (globalCache nodeFor: global name)
							ifNotNil: [ :node | 
								(node updateReference: indexMethod)
									ifFalse: [ globalCache add: global name weight: 1.
										convertedToClasses add: global name ] ] ]
					ifFalse: [ ((global isKindOf: LiteralVariable) and: [ global name notNil ])
							ifTrue: [ (Object environment bindingOf: global name)
									ifNotNil: [ (globalCache nodeFor: global name)
											ifNotNil: [ :node | 
												(node referencesCollection
													detect: [ :each | each methodClass = aMethod methodClass and: [ each selector = aMethod selector ] ]
													ifNone: [  ])
													ifNotNil: [ :m | 
														node removeReference: m.
														globalCache remove: global name weight: 1.
														convertedFromClasses add: global name ] ] ] ] ] ] ].
	selectorBlock := [ :selector :count | 
		(seen includes: selector)
			ifFalse: [ seen add: selector.
				(selectorCache nodeFor: selector)
					ifNotNil: [ :node | node updateReference: indexMethod ] ] ].
	method
		pragmasDo: [ :each | self processPragma: each selectorsDo: selectorBlock ].
	GtMessageSendIterator
		messageSendsIn: method
		doReferences: selectorBlock
		andVariables: globalBlock
]

{ #category : #private }
GtPharoIndex >> removeClassWordsFor: className [
	self
		wordsIn: className
		do: [ :word | 
			(classWordCache remove: word asLowercase weight: 1)
				ifNotNil: [ :node | node removeName: className ] ]
]

{ #category : #private }
GtPharoIndex >> removeMethodFromCache: method [
	method isFromTrait ifTrue: [ ^ self ].
	(selectorCache remove: method selector weight: 1)
		ifNotNil: [ :node | 
			node removeImplementer: method gtIndexMethod.
			node weight = 0
				ifTrue: [ self
						wordsIn: method selector
						do: [ :word | 
							(selectorWordCache remove: word asLowercase weight: 1)
								ifNotNil: [ :n | n removeName: method selector ] ] ] ].
	self removeSendsFrom: method
]

{ #category : #private }
GtPharoIndex >> removeSendsFrom: aMethod [
	| seen globalBlock selectorBlock method indexMethod |
	aMethod ifNil: [ ^ self ].
	method := aMethod gtOriginalMethod.
	indexMethod := aMethod gtIndexMethod.
	seen := Set new.
	globalBlock := [ :global | 
		| node |
		(self isGlobalVariable: global)
			ifTrue: [ node := globalCache remove: global name weight: 1.
				(seen includes: global)
					ifFalse: [ seen add: global.
						node ifNotNil: [ node removeReference: indexMethod ] ] ] ].
	selectorBlock := [ :selector :count | 
		(selectorCache remove: selector weight: count)
			ifNotNil: [ :node | 
				node weight = 0
					ifTrue: [ self
							wordsIn: selector
							do: [ :word | 
								(selectorWordCache remove: word asLowercase weight: 1)
									ifNotNil: [ :n | n removeName: selector ] ] ].
				(seen includes: selector)
					ifFalse: [ seen add: selector.
						node removeReference: indexMethod ] ] ].
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

{ #category : #'accessing - metrics' }
GtPharoIndex >> selectorCacheSpecificSize [
	^ selectorCache gtSpecificSizeInMemory
]

{ #category : #'accessing - metrics' }
GtPharoIndex >> selectorWordCacheSpecificSize [
	^ selectorWordCache gtSpecificSizeInMemory
]

{ #category : #'accessing - senders' }
GtPharoIndex >> sendersOf: aSelector [
	^ self installedSendersOf: aSelector
]

{ #category : #private }
GtPharoIndex >> subscribeToSystem [
	self subscribeToModel
]

{ #category : #private }
GtPharoIndex >> unsubscribeFromSystem [
	self unsubscribeFromModel
]
