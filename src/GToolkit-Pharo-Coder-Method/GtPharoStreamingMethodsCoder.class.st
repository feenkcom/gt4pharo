Class {
	#name : #GtPharoStreamingMethodsCoder,
	#superclass : #GtFilteredCodersModel,
	#traits : 'TGtCoderWithBehaviorHolder',
	#classTraits : 'TGtCoderWithBehaviorHolder classTrait',
	#instVars : [
		'exampleSuite',
		'testSuite'
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
	
	SystemAnnouncer uniqueInstance weak
		when: MethodAdded send: #onMethodAdded: to: self;
		when: MethodRemoved send: #onMethodRemoved: to: self
]

{ #category : #'api - accessing' }
GtPharoStreamingMethodsCoder >> isForClass [
	^ self hasBehavior
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
			GtPharoMethodCoder forMethod: aCompiledMethod in: self behavior ] 
		ifNone: [
			GtPharoMethodCoder forMethod: aCompiledMethod ].

	aMethodCoder weak
		when: GtPharoMethodCoderCompiled
		send: #onPharoMethodCoderCompiled:
		to: self.

	^ aMethodCoder
]

{ #category : #'private - event handling' }
GtPharoStreamingMethodsCoder >> onMethodAdded: aMethodAddedAnnouncement [
	(filter matches: aMethodAddedAnnouncement methodAdded)
		ifFalse: [ ^ self ].

	self privateAddCoderFor: aMethodAddedAnnouncement methodAdded
]

{ #category : #'private - event handling' }
GtPharoStreamingMethodsCoder >> onMethodRemoved: aMethodRemovedAnnouncement [
	(filter matches: aMethodRemovedAnnouncement methodRemoved)
		ifFalse: [ ^ self ].

	self privateRemoveCoderFor: aMethodRemovedAnnouncement methodRemoved
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
	I am used to construck list of available method protocols that can be filtered using
	a method protocol filter.
	Note that the list is unordered"
	
	<return: #TAsyncStream of: #String>
	| someAdditionalFilters aCompositeFilter aStream |
	someAdditionalFilters := additionalFilters reject: #isMethodProtocolFilter.
	aCompositeFilter := self createCombinedFilterFor: filter andAdditionalFilters: someAdditionalFilters.
	aStream := (aCompositeFilter asAsyncStream map: [ :eachMethod | eachMethod category ]).
	^ aStream asAsyncStream withoutDuplicates useContentComparison
]

{ #category : #'api - completion' }
GtPharoStreamingMethodsCoder >> pragmaNames [
	^ (((self itemsStream
		map: [ :eachMethod | eachMethod pragmas asAsyncStream ])
		flatten
		map: [ :eachPragma | eachPragma selector ])
		to: GtPrefixTree) wait
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
