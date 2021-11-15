Class {
	#name : #GtPharoFilteredStreamingMethodsCoder,
	#superclass : #GtCodersModel,
	#instVars : [
		'methodCoders',
		'monitor',
		'codersStream',
		'filter'
	],
	#category : #'GToolkit-Pharo-Coder-Coders'
}

{ #category : #initialization }
GtPharoFilteredStreamingMethodsCoder >> forFilter: aGtSearchFilter [
	filter := aGtSearchFilter.
	items removeAll.
	codersStream := (aGtSearchFilter asAsyncStream map: [ :eachMethod |
		monitor critical: [
			methodCoders
				at: eachMethod
				ifAbsentPut: [ self newCoderFor: eachMethod ] ] ])
		do: [ :eachCoder | monitor critical: [ items add: eachCoder ] ]
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
	
	codersStream := AsyncEmptyStream new.
	methodCoders := Dictionary new.
	monitor := Monitor new.
	items := OrderedCollection new
]

{ #category : #private }
GtPharoFilteredStreamingMethodsCoder >> newCoderFor: aCompiledMethod [
	^ GtPharoMethodCoder forMethod: aCompiledMethod
]
