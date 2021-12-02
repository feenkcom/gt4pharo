Class {
	#name : #GtPharoStreamingBehaviorMethodsCoder,
	#superclass : #GtFilteredCodersModel,
	#instVars : [
		'behavior'
	],
	#category : #'GToolkit-Pharo-Coder-Method-Coder'
}

{ #category : #'instance creation' }
GtPharoStreamingBehaviorMethodsCoder class >> forBehavior: aBehavior [
	^ (self forFilter: (GtSearchMethodsInInstanceAndClassSideFilter forClass: aBehavior)) behavior: aBehavior
]

{ #category : #'api - accessing' }
GtPharoStreamingBehaviorMethodsCoder >> behavior [
	^ behavior
]

{ #category : #'api - accessing' }
GtPharoStreamingBehaviorMethodsCoder >> behavior: aBehavior [
	behavior := aBehavior
]

{ #category : #'api - completion' }
GtPharoStreamingBehaviorMethodsCoder >> categories [
	^ ((self itemsStream map: [ :eachMethod | eachMethod category ]) to: GtPrefixTree) wait
]

{ #category : #'api - completion' }
GtPharoStreamingBehaviorMethodsCoder >> classNames [
	^ ((self itemsStream map: [ :eachMethod | eachMethod methodClass instanceSide name ]) withoutDuplicates to: GtPrefixTree) wait
]

{ #category : #'api - accessing' }
GtPharoStreamingBehaviorMethodsCoder >> classOrMetaClass [
	^ self behavior
]

{ #category : #initialization }
GtPharoStreamingBehaviorMethodsCoder >> initialize [
	super initialize.
	
	behavior := UndefinedObject.
	
	SystemAnnouncer uniqueInstance weak
		when: MethodAdded send: #onMethodAdded: to: self;
		when: MethodRemoved send: #onMethodRemoved: to: self
]

{ #category : #'api - accessing' }
GtPharoStreamingBehaviorMethodsCoder >> isForClass [
	^ behavior notNil
]

{ #category : #'private - instance creation' }
GtPharoStreamingBehaviorMethodsCoder >> newCoderFor: aCompiledMethod [
	^ GtPharoMethodCoder forMethod: aCompiledMethod
]

{ #category : #'private - event handling' }
GtPharoStreamingBehaviorMethodsCoder >> onMethodAdded: aMethodAddedAnnouncement [
	| anAddedCoder |

	(filter matches: aMethodAddedAnnouncement methodAdded)
		ifFalse: [ ^ self ].
	
	anAddedCoder := self privateFetchCoderFor: aMethodAddedAnnouncement methodAdded.
	self
		itemsStream: compositeFilter asAsyncStream
		dueTo: (GtStreamingCodersAddedReason new coder: anAddedCoder)
]

{ #category : #'private - event handling' }
GtPharoStreamingBehaviorMethodsCoder >> onMethodRemoved: aMethodRemovedAnnouncement [
	| aRemovedCoder |

	(filter matches: aMethodRemovedAnnouncement methodRemoved)
		ifFalse: [ ^ self ].

	monitor critical: [
		aRemovedCoder := coders
			removeKey: aMethodRemovedAnnouncement methodRemoved
			ifAbsent: [ nil ] ].

	self
		itemsStream: compositeFilter asAsyncStream
		dueTo: (GtStreamingCodersRemovedReason new coder: aRemovedCoder)
]

{ #category : #'api - completion' }
GtPharoStreamingBehaviorMethodsCoder >> packageNames [
	^ (((self itemsStream
		filter: [ :eachMethod | eachMethod package notNil ])
		map: [ :eachMethod | eachMethod package name ]) to: GtPrefixTree) wait
]

{ #category : #'api - completion' }
GtPharoStreamingBehaviorMethodsCoder >> pragmaNames [
	^ (((self itemsStream
		map: [ :eachMethod | eachMethod pragmas asAsyncStream ])
		flatten
		map: [ :eachPragma | eachPragma selector ])
		to: GtPrefixTree) wait
]

{ #category : #'api - completion' }
GtPharoStreamingBehaviorMethodsCoder >> selectorNames [	
	^ ((self itemsStream map: [ :eachMethod | eachMethod selector ]) to: GtPrefixTree) wait
]
