Class {
	#name : #GtPharoStreamingBehaviorMethodsCoder,
	#superclass : #GtFilteredCodersModel,
	#instVars : [
		'behavior'
	],
	#category : #'GToolkit-Pharo-Coder-Coders'
}

{ #category : #'instance creation' }
GtPharoStreamingBehaviorMethodsCoder class >> forBehavior: aBehavior [
	^ (self forFilter: (GtSearchMethodsInClassFilter forClass: aBehavior)) behavior: aBehavior
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
	^ ((filter asAsyncStream map: [ :eachMethod | eachMethod category ]) to: GtPrefixTree) wait
]

{ #category : #'api - completion' }
GtPharoStreamingBehaviorMethodsCoder >> classNames [
	^ ((filter asAsyncStream map: [ :eachMethod | eachMethod methodClass instanceSide name ]) withoutDuplicates to: GtPrefixTree) wait
]

{ #category : #'api - accessing' }
GtPharoStreamingBehaviorMethodsCoder >> classOrMetaClass [
	^ self behavior
]

{ #category : #initialization }
GtPharoStreamingBehaviorMethodsCoder >> initialize [
	super initialize.
	
	SystemAnnouncer uniqueInstance weak
		when: MethodAdded send: #onMethodAdded: to: self;
		when: MethodRemoved send: #onMethodRemoved: to: self
]

{ #category : #'api - accessing' }
GtPharoStreamingBehaviorMethodsCoder >> isForClass [
	^ behavior notNil
]

{ #category : #private }
GtPharoStreamingBehaviorMethodsCoder >> newCoderFor: aCompiledMethod [
	^ (GtPharoMethodCoder forMethod: aCompiledMethod) withoutHeader
]

{ #category : #'private - event handling' }
GtPharoStreamingBehaviorMethodsCoder >> onMethodAdded: aMethodAddedAnnouncement [
	| aCoderModel |

	(filter matches: aMethodAddedAnnouncement methodAdded)
		ifFalse: [ ^ self ].
	
	aCoderModel := self privateFetchCoderFor: aMethodAddedAnnouncement methodAdded.
	
	self announce: (GtCodersCoderAdded new
		coders: self;
		coder: aCoderModel)
]

{ #category : #'private - event handling' }
GtPharoStreamingBehaviorMethodsCoder >> onMethodRemoved: aMethodRemovedAnnouncement [
	(filter matches: aMethodRemovedAnnouncement methodRemoved)
		ifFalse: [ ^ self ].
		
	self notifyChanged
]

{ #category : #'api - completion' }
GtPharoStreamingBehaviorMethodsCoder >> packageNames [
	^ (((filter asAsyncStream
		filter: [ :eachMethod | eachMethod package notNil ])
		map: [ :eachMethod | eachMethod package name ]) to: GtPrefixTree) wait
]

{ #category : #'api - completion' }
GtPharoStreamingBehaviorMethodsCoder >> pragmaNames [
	^ (((filter asAsyncStream
		map: [ :eachMethod | eachMethod pragmas asAsyncStream ])
		flatten
		map: [ :eachPragma | eachPragma selector ])
		to: GtPrefixTree) wait
]

{ #category : #'api - completion' }
GtPharoStreamingBehaviorMethodsCoder >> selectorNames [	
	^ ((filter asAsyncStream map: [ :eachMethod | eachMethod selector ]) to: GtPrefixTree) wait
]
