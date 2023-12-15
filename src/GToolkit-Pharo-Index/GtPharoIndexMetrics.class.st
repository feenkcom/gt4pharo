Class {
	#name : #GtPharoIndexMetrics,
	#superclass : #Object,
	#instVars : [
		'cache'
	],
	#classInstVars : [
		'default'
	],
	#category : #'GToolkit-Pharo-Index'
}

{ #category : #accessing }
GtPharoIndexMetrics class >> classWordCacheSpecificSize [
	<gtExample>
	
	^ self default classWordCacheSpecificSize
]

{ #category : #accessing }
GtPharoIndexMetrics class >> default [
	<gtExample>
	
	^ default ifNil: [ default := self new ]
]

{ #category : #accessing }
GtPharoIndexMetrics class >> globalCacheSpecificSize [
	<gtExample>
	
	^ self default globalCacheSpecificSize
]

{ #category : #accessing }
GtPharoIndexMetrics class >> implementorsCacheMetrics [
	<gtExample>
	 
	^ self default implementorsCacheMetrics
]

{ #category : #accessing }
GtPharoIndexMetrics class >> prefixStringsSizeInMemory [
	<gtExample>
	
	^ self default prefixStringsSizeInMemory
]

{ #category : #accessing }
GtPharoIndexMetrics class >> referencesCacheMetrics [
	<gtExample>
	 
	^ self default referencesCacheMetrics
]

{ #category : #accessing }
GtPharoIndexMetrics class >> selectorCacheSpecificSize [
	<gtExample>
	
	^ self default selectorCacheSpecificSize
]

{ #category : #accessing }
GtPharoIndexMetrics class >> selectorWordCacheSpecificSize [
	<gtExample>
	
	^ self default selectorWordCacheSpecificSize
]

{ #category : #accessing }
GtPharoIndexMetrics class >> totalCompleterCacheSize [
	<gtExample>
	
	^ self default totalCompleterCacheSize
]

{ #category : #accessing }
GtPharoIndexMetrics class >> totalNodesStructureSize [
	<gtExample>
	
	^ self default totalNodesStructureSize
]

{ #category : #'accessing - cache' }
GtPharoIndexMetrics >> cache [
	^ cache
]

{ #category : #'accessing - cache' }
GtPharoIndexMetrics >> cacheAt: aSymbol ifAbsentPut: aBlock [
	^ self cache 
		at: aSymbol ifAbsentPut: aBlock
]

{ #category : #accessing }
GtPharoIndexMetrics >> classWordCacheSpecificSize [
	^ self 
		cacheAt: #classWordCacheSpecificSize
		ifAbsentPut: [
			 GtPharoIndex current classWordCacheSpecificSize ]
]

{ #category : #accessing }
GtPharoIndexMetrics >> globalCacheSpecificSize [
	^ self 
		cacheAt: #globalCacheSpecificSize
		ifAbsentPut: [
			 GtPharoIndex current globalCacheSpecificSize ]
]

{ #category : #accessing }
GtPharoIndexMetrics >> implementorsCacheMetrics [
	^ self 
		cacheAt: #implementorsCacheMetrics
		ifAbsentPut: [
			GtIndexPrefixTreeImplementersMetrics forDefaultSelectorCache ]
]

{ #category : #initialization }
GtPharoIndexMetrics >> initialize [ 
	super initialize.
	
	cache := Dictionary new.
]

{ #category : #accessing }
GtPharoIndexMetrics >> prefixStringsSizeInMemory [
	^ self 
		cacheAt: #prefixStringsSizeInMemory
		ifAbsentPut: [
			 GtPharoIndex current prefixStringsSizeInMemory ]
]

{ #category : #accessing }
GtPharoIndexMetrics >> referencesCacheMetrics [
	^ self 
		cacheAt: #referencesCacheMetrics
		ifAbsentPut: [
			GtIndexPrefixTreeReferenceMetrics forDefaultSelectorCache ]
]

{ #category : #accessing }
GtPharoIndexMetrics >> selectorCacheSpecificSize [
	^ self 
		cacheAt: #selectorCacheSpecificSize
		ifAbsentPut: [
			 GtPharoIndex current selectorCacheSpecificSize ]
]

{ #category : #accessing }
GtPharoIndexMetrics >> selectorWordCacheSpecificSize [
	^ self 
		cacheAt: #selectorWordCacheSpecificSize
		ifAbsentPut: [
			 GtPharoIndex current selectorWordCacheSpecificSize ]
]

{ #category : #accessing }
GtPharoIndexMetrics >> totalCompleterCacheSize [
	^ self 
		cacheAt: #totalCompleterCacheSize
		ifAbsentPut: [
			 GtPharoIndex cacheSizeInMemory ]
]

{ #category : #accessing }
GtPharoIndexMetrics >> totalNodesStructureSize [
	^ self classWordCacheSpecificSize 
		+ self globalCacheSpecificSize
		+ self selectorCacheSpecificSize
		+ self selectorWordCacheSpecificSize
]
