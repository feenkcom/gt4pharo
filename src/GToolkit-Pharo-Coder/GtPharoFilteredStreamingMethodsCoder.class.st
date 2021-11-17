Class {
	#name : #GtPharoFilteredStreamingMethodsCoder,
	#superclass : #GtCodersModel,
	#instVars : [
		'methodCoders',
		'monitor',
		'codersStream',
		'filter',
		'methodsPromise',
		'newCoders'
	],
	#category : #'GToolkit-Pharo-Coder-Coders'
}

{ #category : #'instance creation' }
GtPharoFilteredStreamingMethodsCoder class >> forBehavior: aBehavior [
	^ self forFilter: (GtSearchMethodsInClassFilter forClass: aBehavior)
]

{ #category : #'instance creation' }
GtPharoFilteredStreamingMethodsCoder class >> forFilter: aGtSearchFilter [
	^ self new forFilter: aGtSearchFilter
]

{ #category : #adding }
GtPharoFilteredStreamingMethodsCoder >> addNewCoder: aCoderModel [
	newCoders add: aCoderModel.
	codersStream := self newCodersStream.

	self announce: (GtCodersCoderAdded new
		coders: self;
		coder: aCoderModel).
		
	^ aCoderModel
]

{ #category : #accessing }
GtPharoFilteredStreamingMethodsCoder >> codersStream [
	^ codersStream
]

{ #category : #accessing }
GtPharoFilteredStreamingMethodsCoder >> filterDescriptors [
	| descriptors |
	descriptors := SortedCollection sortBlock: [ :a :b | a order < b order ].
	GtSearchMethodsFilter
		withAllSubclassesDo: [ :eachClass | 
			eachClass 
				filterDescriptorsFor: self 
				into: descriptors ].
	^ descriptors
]

{ #category : #initialization }
GtPharoFilteredStreamingMethodsCoder >> forFilter: aGtSearchFilter [
	filter := aGtSearchFilter.
	items removeAll.

	codersStream := self newCodersStream
]

{ #category : #'gt-extension' }
GtPharoFilteredStreamingMethodsCoder >> gtLiveFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Live' translated;
		priority: 10;
		stencil: [
			| aStream |			

			aStream := codersStream asyncSimilarCopy map: [ :eachCoder |
				eachCoder asCoderViewModel expanded: false ].

			BrSimpleList new
				itemStencil: [ GtExpandableMethodCoderForBehaviorElement new ];
				itemDataBinder: [ :aCoderElement :aCoderViewModel | aCoderElement coderUIModel: aCoderViewModel ];
				stream: aStream ]
]

{ #category : #initialization }
GtPharoFilteredStreamingMethodsCoder >> initialize [
	super initialize.

	monitor := Monitor new.
	newCoders := OrderedCollection new.
	codersStream := AsyncEmptyStream new.
	methodCoders := Dictionary new.
	items := OrderedCollection new
]

{ #category : #accessing }
GtPharoFilteredStreamingMethodsCoder >> methods [
	"Return a promise resolving to a collection of all methods"
	<return: #TAsyncPromise>

	^ monitor critical: [ 
		  methodsPromise ifNil: [ 
			  methodsPromise := (filter asAsyncStream to: OrderedCollection) asAsyncPromise ] ]
]

{ #category : #private }
GtPharoFilteredStreamingMethodsCoder >> newCoderFor: aCompiledMethod [
	^ (GtPharoMethodCoder forMethod: aCompiledMethod) withoutHeader
]

{ #category : #private }
GtPharoFilteredStreamingMethodsCoder >> newCodersStream [
	| aNewCodersStream aFilterStream |

	aNewCodersStream := newCoders asArray asAsyncStream.
	aFilterStream := (filter asAsyncStream map: [ :eachMethod |
		monitor critical: [
			methodCoders
				at: eachMethod
				ifAbsentPut: [ self newCoderFor: eachMethod ] ] ])
		do: [ :eachCoder | monitor critical: [ items add: eachCoder ] ].

	^ { aNewCodersStream . aFilterStream } asAsyncStream flatten
]
