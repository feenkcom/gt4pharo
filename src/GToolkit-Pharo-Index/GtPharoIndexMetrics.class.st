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
GtPharoIndexMetrics class >> default [
	<gtExample>
	
	^ default ifNil: [ default := self new ]
]

{ #category : #accessing }
GtPharoIndexMetrics class >> totalCompleterCacheSize [
	<gtExample>
	
	^ self default totalCompleterCacheSize
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

{ #category : #initialization }
GtPharoIndexMetrics >> initialize [ 
	super initialize.
	
	cache := Dictionary new.
]

{ #category : #accessing }
GtPharoIndexMetrics >> totalCompleterCacheSize [
	^ self 
		cacheAt: #totalCompleterCacheSize
		ifAbsentPut: [
			 GtPharoIndex cacheSizeInMemory ]
]
