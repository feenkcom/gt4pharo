Class {
	#name : #GtPharoStreamingMethodsCoder,
	#superclass : #GtFilteredCodersModel,
	#traits : 'TGtCoderWithBehaviorHolder',
	#classTraits : 'TGtCoderWithBehaviorHolder classTrait',
	#instVars : [
		'exampleSuite',
		'testSuite',
		'performingBulkChanges',
		'needsUpdate'
	],
	#category : #'GToolkit-Pharo-Coder-Method-Coder'
}

{ #category : #'instance creation' }
GtPharoStreamingMethodsCoder class >> forBehavior: aBehavior [
	^ (self
		forFilter: ((GtSearchInheritedMethodsFilter forClass: aBehavior)
				withSuperclassesUpTo: ProtoObject))
		additionalFilters: {
			(GtSearchInheritedMethodsFilter forClass: aBehavior)
				withSuperclassesUpTo: aBehavior.
			GtSearchMethodCategoryFilter forCategory: GtAllProtocol defaultName};
		behavior: aBehavior
]

{ #category : #'api - completion' }
GtPharoStreamingMethodsCoder >> categories [
	^ ((self itemsStream map: [ :eachMethod | eachMethod category ]) to: GtPrefixTree) wait
]

{ #category : #'api - completion' }
GtPharoStreamingMethodsCoder >> classNames [
	^ ((self itemsStream map: [ :eachMethod | eachMethod methodClass instanceSide name ]) withoutDuplicates to: GtPrefixTree) wait
]

{ #category : #'api - accessing' }
GtPharoStreamingMethodsCoder >> classOrMetaClass [
	^ self behavior
]

{ #category : #accessing }
GtPharoStreamingMethodsCoder >> codeGeneratorsAvailableFor: aMethodsCoderViewModel [
	^ (self codeGeneratorsFor: aMethodsCoderViewModel) size > 0
]

{ #category : #accessing }
GtPharoStreamingMethodsCoder >> exampleSuite [
	^ exampleSuite
]

{ #category : #accessing }
GtPharoStreamingMethodsCoder >> exampleSuite: aGtPharoExampleSuite [
	exampleSuite := aGtPharoExampleSuite
]

{ #category : #initialization }
GtPharoStreamingMethodsCoder >> initialize [
	super initialize.
	performingBulkChanges := false.
	needsUpdate := false.

	SystemAnnouncer uniqueInstance weak
		when: MethodAdded
			send: #onMethodAdded:
			to: self;
		when: MethodRemoved
			send: #onMethodRemoved:
			to: self;
		when: GtAboutToPerformBulkChangesAnnouncement
			send: #onAboutToPerformBulkChanges:
			to: self;
		when: GtFinishedBulkChangesAnnouncement
			send: #onFinishedBulkChanges:
			to: self
]

{ #category : #'api - accessing' }
GtPharoStreamingMethodsCoder >> isForClass [
	^ self hasBehavior
]

{ #category : #'private - instance creation' }
GtPharoStreamingMethodsCoder >> methodCoderPragmas [
	^ Pragma
		allNamed: #gtMethodCoder:
		from: CompiledMethod
		to: CompiledMethod
		sortedByArgument: 1
]

{ #category : #'private - instance creation' }
GtPharoStreamingMethodsCoder >> newCoderCacheKeyFor: aCompiledMethod [
	^ GtPharoMethodDescription forCompiledMethod: aCompiledMethod
]

{ #category : #'private - instance creation' }
GtPharoStreamingMethodsCoder >> newCoderFor: aCompiledMethod [
	| aMethodCoder |
	aMethodCoder := self
			ifBehavior: [ :aBehavior | 
				| coderClass |
				coderClass := self selectCoderClassFor: aCompiledMethod.
				[ coderClass forMethod: aCompiledMethod in: self behavior ]
					onErrorDo: [ aCompiledMethod gtMethodCoder forMethod: aCompiledMethod in: self behavior ] ]
			ifNone: [ GtPharoMethodCoder forMethod: aCompiledMethod ].

	aMethodCoder weak
		when: GtPharoMethodCoderCompiled
		send: #onPharoMethodCoderCompiled:
		to: self.

	^ aMethodCoder
]

{ #category : #'private - event handling' }
GtPharoStreamingMethodsCoder >> onAboutToPerformBulkChanges: anAnnouncement [
	needsUpdate := false.
	performingBulkChanges := true
]

{ #category : #'private - event handling' }
GtPharoStreamingMethodsCoder >> onFinishedBulkChanges: anAnnouncement [
	performingBulkChanges := false.
	needsUpdate
		ifTrue: [ self refreshItemsStreamDueTo: GtFinishedBulkUpdateReason new ].
	needsUpdate := false
]

{ #category : #'private - event handling' }
GtPharoStreamingMethodsCoder >> onMethodAdded: aMethodAddedAnnouncement [
	(filter matches: aMethodAddedAnnouncement methodAdded) ifFalse: [ ^ self ].

	performingBulkChanges
		ifTrue: [ needsUpdate := true ]
		ifFalse: [ self privateAddCoderFor: aMethodAddedAnnouncement methodAdded ]
]

{ #category : #'private - event handling' }
GtPharoStreamingMethodsCoder >> onMethodRemoved: aMethodRemovedAnnouncement [
	(filter matches: aMethodRemovedAnnouncement methodRemoved) ifFalse: [ ^ self ].

	performingBulkChanges
		ifTrue: [ needsUpdate := true ]
		ifFalse: [ self privateRemoveCoderFor: aMethodRemovedAnnouncement methodRemoved ]
]

{ #category : #'private - event handling' }
GtPharoStreamingMethodsCoder >> onPharoMethodCoderCompiled: aCompiledAnnouncement [
	| aNewCoder |
	aCompiledAnnouncement isSameMethod
		ifTrue: [ ^ self ].

	aCompiledAnnouncement previousMethod
		ifNil: [ ^ self ].

	aNewCoder := self privateFetchCoderFor: aCompiledAnnouncement newMethod.
	aNewCoder forMethod: aCompiledAnnouncement previousMethod.
	
	self
		privateSwapCodersFor: aCompiledAnnouncement previousMethod
		and: aCompiledAnnouncement newMethod
]

{ #category : #'api - completion' }
GtPharoStreamingMethodsCoder >> packageNames [
	^ (((self itemsStream
		filter: [ :eachMethod | eachMethod package notNil ])
		map: [ :eachMethod | eachMethod package name ]) to: GtPrefixTree) wait
]

{ #category : #'api - completion' }
GtPharoStreamingMethodsCoder >> possibleCategoriesOrderedFuture [
	"I return possible method protocols (categories), excluding method protocol filter.
	I am used to construct list of available method protocols that can be filtered using
	a method protocol filter."
	<return: #TAsyncFuture of: #GtPrefixTree>
	| aStream |
	aStream := self possibleCategoriesUnorderedStream.
	^ aStream to: GtPrefixTree
]

{ #category : #'api - completion' }
GtPharoStreamingMethodsCoder >> possibleCategoriesUnorderedStream [
	"I return possible method protocols (categories), excluding method protocol filter.
	I am used to construct list of available method protocols that can be filtered using
	a method protocol filter.
	Note that the list is unordered"
	
	<return: #TAsyncStream of: #String>
	| someAdditionalFilters aCompositeFilter aStream |
	someAdditionalFilters := additionalFilters reject: #isMethodProtocolFilter.
	aCompositeFilter := self createCombinedFilterFor: filter andAdditionalFilters: someAdditionalFilters.
	aStream := (aCompositeFilter asAsyncStream map: [ :eachMethod | eachMethod protocolName ]).
	^ aStream asAsyncStream withoutDuplicates useContentComparison
]

{ #category : #'api - completion' }
GtPharoStreamingMethodsCoder >> possiblePragmaNamesOrderedFuture [
	<return: #TAsyncFuture of: #GtPrefixTree>
	| aStream |
	aStream := self possiblePragmaNamesUnorderedStream.
	^ aStream to: GtPrefixTree
]

{ #category : #'api - completion' }
GtPharoStreamingMethodsCoder >> possiblePragmaNamesUnorderedStream [
	"I return possible method pragma selectors (names), excluding method pragma filter.
	I am used to construct list of available method pragma selectors (names) that can be filtered using
	a method pragma filter.
	Note that the list is unordered"
	
	<return: #TAsyncStream of: #String>
	| someAdditionalFilters aCompositeFilter aStream |
	someAdditionalFilters := additionalFilters reject: #isMethodPragmaFilter.
	aCompositeFilter := self createCombinedFilterFor: filter andAdditionalFilters: someAdditionalFilters.
	aStream := (aCompositeFilter asAsyncStream 
		map: [ :eachMethod | eachMethod pragmas asAsyncStream ]) 
		flatten
		map: [ :eachPragma | eachPragma selector ].
	^ aStream asAsyncStream withoutDuplicates useContentComparison
]

{ #category : #'api - completion' }
GtPharoStreamingMethodsCoder >> pragmaNames [
	"We use this method to demo a UI blocking issue.
	See https://github.com/feenkcom/gtoolkit/issues/4327.
	Use #pragmaNamesOrderedFuture instead."
	
	^ (((self itemsStream
		map: [ :eachMethod | eachMethod pragmas asAsyncStream ])
		flatten
		map: [ :eachPragma | eachPragma selector ])
		to: GtPrefixTree) wait
]

{ #category : #'api - completion' }
GtPharoStreamingMethodsCoder >> pragmaNamesOrderedFuture [
	<return: #TAsyncFuture of: #GtPrefixTree>
	| aStream |
	aStream := self pragmaNamesUnorderedStream.
	^ aStream to: GtPrefixTree
]

{ #category : #'api - completion' }
GtPharoStreamingMethodsCoder >> pragmaNamesUnorderedStream [
	<return: #TAsyncStream of: #String>
	| aStream |
	aStream := (self itemsStream
		map: [ :eachMethod | eachMethod pragmas asAsyncStream ])
		flatten
		map: [ :eachPragma | eachPragma selector ].
	
	^ aStream asAsyncStream withoutDuplicates useContentComparison
]

{ #category : #'private - instance creation' }
GtPharoStreamingMethodsCoder >> selectCoderClassFor: aCompiledMethod [
	| coderClasses |
	coderClasses := self methodCoderPragmas.
	coderClasses
		reverseDo: [ :each | 
			(each method valueWithReceiver: aCompiledMethod arguments: #())
				ifNotNil: [ :cls | ^ cls ] ].
	^ aCompiledMethod gtMethodCoder
]

{ #category : #'api - completion' }
GtPharoStreamingMethodsCoder >> selectorNames [	
	^ ((self itemsStream map: [ :eachMethod | eachMethod selector ]) to: GtPrefixTree) wait
]

{ #category : #accessing }
GtPharoStreamingMethodsCoder >> testSuite [
	^ testSuite
]

{ #category : #accessing }
GtPharoStreamingMethodsCoder >> testSuite: aGtPharoTestSuite [
	testSuite := aGtPharoTestSuite
]
