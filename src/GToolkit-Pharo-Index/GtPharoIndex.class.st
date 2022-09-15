Class {
	#name : #GtPharoIndex,
	#superclass : #Object,
	#instVars : [
		'globalCache',
		'selectorCache',
		'active',
		'shouldRecomputeSubclasses',
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
			ifFalse: [ node weight = count
					ifTrue: [ self
							wordsIn: selector
							do: [ :word | (selectorWordCache add: word asLowercase weight: 1) addName: selector ] ].
				seen add: selector.
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

{ #category : #accessing }
GtPharoIndex >> asyncImplementersForWord: aString [
	^ ((self asyncSelectorsForWord: aString)
		collect: [ :each | 
			(selectorCache nodeFor: each)
				ifNil: [ #() asAsyncStream ]
				ifNotNil: [ :node | node implementersCollection asAsyncStream ] ]) flatten
]

{ #category : #private }
GtPharoIndex >> asyncNamesForWord: aString usingPrefixCache: prefixCache andWordCache: wordCache [
	"Ordered the results by first ones with exact matches, and then with case-insensitve prefix match, 
	and finally by word matches."

	| wordStream trimmedString includesString |
	trimmedString := aString trim.
	wordStream := self asyncOrderedSearchForWords: trimmedString in: wordCache.
	includesString := prefixCache includes: trimmedString.
	^ (((includesString ifTrue: [ {trimmedString} ] ifFalse: [ #() ]) asAsyncStream
		merge: (prefixCache asyncWeightedStreamStartingWith: trimmedString caseSensitive: false))
		merge: wordStream) withoutDuplicates
]

{ #category : #private }
GtPharoIndex >> asyncOrderedSearchForWords: aString in: prefixTree [
	"Order the results by 1) names that begin with aString, 2) names that have aString in them,
	3) names that have the words from aString in order and begins with the first word in aString,
	4) names that have the words from aString in order, and 5) names that have all the words from
	aString in any order. The stream returned may (and likely will) contain duplicates."

	| matchStream substringMatchStream wordsInOrderStream startingSubstringMatchStream startingWordsInOrderStream |
	matchStream := (self asyncSearchForWords: aString in: prefixTree) cached.
	substringMatchStream := (matchStream asyncSimilarCopy
			select: [ :each | self does: each includeString: aString ]) cached.
	startingSubstringMatchStream := substringMatchStream asyncSimilarCopy
			select: [ :each | self does: each beginWithWord: aString ].
	wordsInOrderStream := (matchStream asyncSimilarCopy
			select: [ :each | self does: each includeWordsInOrder: aString ]) cached.
	startingWordsInOrderStream := wordsInOrderStream asyncSimilarCopy
			select: [ :each | self does: each beginWithWord: aString ].
	^ (((startingSubstringMatchStream merge: substringMatchStream)
		merge: startingWordsInOrderStream) merge: wordsInOrderStream)
		merge: matchStream
]

{ #category : #private }
GtPharoIndex >> asyncSearchForWords: aString in: prefixTree [
	| words longest |
	words := self searchWordsFrom: aString.
	longest := words isEmpty
			ifTrue: [ '' ]
			ifFalse: [ (words asSet asSortedCollection: [ :a :b | a size > b size ]) first ].
	^ ((prefixTree asyncStreamStartingWith: longest)
		collect: [ :each | 
			(prefixTree nodeFor: each)
				ifNil: [ #() asAsyncStream ]
				ifNotNil: [ :node | 
					node namesCollection asArray asAsyncStream
						select: [ :selector | words size <= 1 or: [ self does: selector matchWords: words ] ] ] ])
		flatten withoutDuplicates
]

{ #category : #accessing }
GtPharoIndex >> asyncSelectorsForWord: aString [
	^ self
		asyncNamesForWord: aString
		usingPrefixCache: selectorCache
		andWordCache: selectorWordCache
]

{ #category : #accessing }
GtPharoIndex >> asyncSendersForWord: aString [
	^ ((self asyncSelectorsForWord: aString)
		collect: [ :each | 
			(selectorCache nodeFor: each)
				ifNil: [ #() asAsyncStream ]
				ifNotNil: [ :node | node referencesCollection asAsyncStream ] ]) flatten
		withoutDuplicates
]

{ #category : #accessing }
GtPharoIndex >> cacheSizeInMemory [
	^ globalCache gtSpecificSizeInMemory + selectorCache gtSpecificSizeInMemory
		+ selectorWordCache gtSpecificSizeInMemory
		+ classWordCache gtSpecificSizeInMemory
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
	self addClassWordsFor: newName.
	self addSymbolReferencesTo: newName
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
	self removeClassWordsFor: className.
	anAnnouncement classRemoved instanceSide
		methodsDo: [ :each | self removeMethodFromCache: each ].
	anAnnouncement classRemoved classSide
		methodsDo: [ :each | self removeMethodFromCache: each ]
]

{ #category : #private }
GtPharoIndex >> classRenamed: anAnnouncement [
	| oldRefs addedRefs newClassName oldClassName |
	"First remove the old entry"
	oldClassName := anAnnouncement oldName.
	(globalCache nodeFor: oldClassName)
		ifNil: [ oldRefs := #() ]
		ifNotNil: [ :node | 
			oldRefs := node referencesCollection.
			node references: nil.
			globalCache remove: oldClassName weight: node weight ].
	self removeClassWordsFor: oldClassName.
			
	"Add new entry"
	newClassName := anAnnouncement newName.
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
					(self isVariableForClass: global)
						ifTrue: [ global name = newClassName
								ifTrue: [ node := globalCache add: newClassName weight: 1.
									(addedRefs includes: each)
										ifFalse: [ addedRefs add: each.
											node addReference: each ] ] ] ] ]
]

{ #category : #testing }
GtPharoIndex >> does: aSymbol beginWithWord: aString [
	| string |
	string := aSymbol asString asLowercase.
	self
		wordsIn: aString
		do: [ :each | ^ string beginsWith: each asLowercase ]
		minSize: 1
		includeSubStrings: false.
	^ false
]

{ #category : #testing }
GtPharoIndex >> does: aSymbol includeString: aString [
	^ aSymbol includesSubstring: aString caseSensitive: false
]

{ #category : #testing }
GtPharoIndex >> does: aSymbol includeWordsInOrder: wordString [
	| string index |
	string := aSymbol asString asLowercase.
	index := 1.
	self
		wordsIn: wordString
		do: [ :each | 
			index := string indexOfSubCollection: each asLowercase startingAt: index.
			index > 0 ifTrue: [ index := index + each size ] ifFalse: [ ^ false ] ]
		minSize: 1
		includeSubStrings: false.
	^ true
]

{ #category : #testing }
GtPharoIndex >> does: selector matchWords: words [
	^ (self intervalsIn: selector matchingWords: words) notEmpty
]

{ #category : #accessing }
GtPharoIndex >> globalCache [
	^ globalCache
]

{ #category : #accessing }
GtPharoIndex >> globalVariableReferencesTo: aVariable [
	^ (globalCache referencesTo: aVariable name) asOrderedCollection
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

{ #category : #accessing }
GtPharoIndex >> implementersOf: aSelector [
	^ selectorCache implementersOf: aSelector
]

{ #category : #initialization }
GtPharoIndex >> initialize [
	super initialize.
	selectorCache := GtReferencesAndImplementersPrefixTree new.
	globalCache := GtReferencesPrefixTree new.
	selectorWordCache := GtNamesPrefixTree new.
	classWordCache := GtNamesPrefixTree new.
	active := false.
	shouldRecomputeSubclasses := false
]

{ #category : #initialization }
GtPharoIndex >> initializeCache [
	self unsubscribeFromSystem.
	selectorCache := GtReferencesAndImplementersPrefixTree new.
	globalCache := GtReferencesPrefixTree withAll: Smalltalk globals keys.
	selectorWordCache := GtNamesPrefixTree new.
	classWordCache := GtNamesPrefixTree new.
	Smalltalk
		allClassesDo: [ :each | 
			self addClassWordsFor: each name.
			each methodsDo: [ :method | self methodAdded: method ].
			each class methodsDo: [ :method | self methodAdded: method ] ].
	selectorCache allNodesDo: #compressData.
	globalCache allNodesDo: #compressData.
	selectorWordCache allNodesDo: #compressData.
	classWordCache allNodesDo: #compressData.
	self subscribeToSystem
]

{ #category : #accessing }
GtPharoIndex >> intervalsIn: selector matching: wordString [
	| words |
	words := self searchWordsFrom: wordString.
	^ self intervalsIn: selector matchingWords: words
]

{ #category : #private }
GtPharoIndex >> intervalsIn: selector matchingWords: words [
	| selectorWords intervals |
	intervals := OrderedCollection new: words size.
	selectorWords := OrderedCollection new.
	self
		wordsIn: selector
		do: [ :each :index | 
			selectorWords
				add: {index.
						each asLowercase} ]
		minSize: 1
		includeSubStrings: true.
	selectorWords
		sorted: [ :a :b | a last size > b last size or: [ a last = b last and: [ a first < b first ] ] ].
	(words asSet asSortedCollection: [ :a :b | a size > b size ])
		do: [ :each | 
			(words occurrencesOf: each)
				timesRepeat: [ | item |
					item := selectorWords
							detect: [ :sel | sel last beginsWith: each ]
							ifNone: [ ^ #() ].
					intervals add: (item first to: item first + each size - 1).
					selectorWords remove: item ] ].
	^ intervals
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
	node weight = 1
		ifTrue: [ self
				wordsIn: anAnnouncement method selector
				do: [ :word | (selectorWordCache add: word asLowercase weight: 1) addName: anAnnouncement method selector ] ].
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
	| seen selectorBlock globalBlock method convertedToClasses convertedFromClasses |
	aMethod isFromTrait ifTrue: [ ^ self ].
	method := aMethod gtOriginalMethod.
	(selectorCache nodeFor: method selector)
		ifNotNil: [ :node | node updateImplementer: method ].
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
				(self isVariableForClass: global)
					ifTrue: [ (globalCache nodeFor: global name)
							ifNotNil: [ :node | 
								(node updateReference: method)
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
			node removeImplementer: method gtOriginalMethod.
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
				node weight = 0
					ifTrue: [ self
							wordsIn: selector
							do: [ :word | 
								(selectorWordCache remove: word asLowercase weight: 1)
									ifNotNil: [ :n | n removeName: selector ] ] ].
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
GtPharoIndex >> searchWordsFrom: aString [
	| words |
	words := Bag new.
	self
		wordsIn: aString
		do: [ :each | words add: each asLowercase ]
		minSize: 1
		includeSubStrings: false.
	^ words
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

{ #category : #private }
GtPharoIndex >> wordsIn: aSymbol do: aBlock [
	self
		wordsIn: aSymbol
		do: aBlock
		minSize: 1
		includeSubStrings: true
]

{ #category : #private }
GtPharoIndex >> wordsIn: aSymbol do: aBlock minSize: anInteger includeSubStrings: aBoolean [
	| start end char size |
	size := aSymbol size.
	start := 1.
	[ start <= size ]
		whileTrue: [ [ start <= size and: [ (char := aSymbol at: start) isLetter not ] ]
				whileTrue: [ start := start + 1 ].
			start > size ifTrue: [ ^ self ].
			end := start + 1.
			char isUppercase
				ifTrue: [ [ end <= size and: [ (aSymbol at: end) isUppercase ] ]
						whileTrue: [ end := end + 1 ] ].
			[ end <= size
				and: [ (char := aSymbol at: end) isLowercase or: [ char isDigit ] ] ]
				whileTrue: [ end := end + 1 ].
			end := end - 1.
			[ end - start + 1 >= anInteger ]
				whileTrue: [ aBlock cull: (aSymbol copyFrom: start to: end) cull: start.
					(aBoolean and: [ (aSymbol at: end) isUppercase not ])
						ifTrue: [ start := start + 1.
							(start < size and: [ (aSymbol at: start) isUppercase ])
								ifFalse: [ start := end + 1 ] ]
						ifFalse: [ start := end + 1 ] ].
			start := end + 1 ]
]
