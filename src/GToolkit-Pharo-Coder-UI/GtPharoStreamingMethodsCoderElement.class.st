Class {
	#name : #GtPharoStreamingMethodsCoderElement,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable + TGtWithStreamingCodersViewModel',
	#classTraits : 'TBrLayoutResizable classTrait + TGtWithStreamingCodersViewModel classTrait',
	#instVars : [
		'list'
	],
	#category : #'GToolkit-Pharo-Coder-UI-! Views'
}

{ #category : #'instance creation' }
GtPharoStreamingMethodsCoderElement >> buildFilter [
	| filterElement filterDescriptors |

	filterDescriptors := streamingCodersViewModel streamingCodersModel filterDescriptors.
	filterDescriptors isEmpty
		ifTrue: [ ^ self ].

	filterElement := BlFrameTelemetry
		time: [ 'Create filters element' ]
		during: [
			GtFiltersElement new
				padding: (BlInsets all: 2);
				descriptors: filterDescriptors;
				yourself ].

	filterElement
		when: GtFiltersChangedEvent
		do: [ :event | self updateCodersFilters: event ].

	self addChildFirst: filterElement as: #filter
]

{ #category : #initialization }
GtPharoStreamingMethodsCoderElement >> defaultLayout [
	^ BlLinearLayout vertical
]

{ #category : #initialization }
GtPharoStreamingMethodsCoderElement >> initialize [
	super initialize.
	
	self matchParent.
	
	list := BrSimpleList new
		itemType: [ :anItemTypeFactory :anItemObject | anItemObject class ];
		itemStencil: [ GtExpandableMethodCoderForBehaviorElement new ];
		itemDataBinder: [ :aCoderElement :aCoderViewModel |
			BlFrameTelemetry
				time: [ 'Set {1} as a view model of {2}' format: { aCoderViewModel class name . aCoderElement class name } ]
				during: [ aCoderElement textualCoderViewModel: aCoderViewModel ] ].
	
	self addChild: list
]

{ #category : #'private - event handling' }
GtPharoStreamingMethodsCoderElement >> onFilterChanged: anAnnouncement [
	self
		childWithId: #filter
		ifFound: [ :aFiltersElement |
			aFiltersElement
				buildFilters: [
					streamingCodersViewModel additionalFilters do: [ :each | 
						(each filterDescriptorFor: streamingCodersViewModel streamingCodersModel)
							ifNotNil: [ :descriptor | 
								| label |
								label := descriptor valueIsRequired
									ifTrue: [ each filterValueString ].
									
								aFiltersElement
									addFilterForDescriptor: descriptor
									andValue: label ] ] ] ]
		ifNone: [  ]
]

{ #category : #'private - event handling' }
GtPharoStreamingMethodsCoderElement >> onScrollTargetChanged: anAnnouncement [
	self updateScrollTarget: anAnnouncement scrollTarget
]

{ #category : #'private - event handling' }
GtPharoStreamingMethodsCoderElement >> onStreamingCodersChanged: anAnnouncement [
	list stream: streamingCodersViewModel coderViewModelsStream
]

{ #category : #'api - streaming coders view model' }
GtPharoStreamingMethodsCoderElement >> onStreamingCodersViewModelChanged [
	"Is sent when a new streamingCodersViewModel is assigned to the receiver.
	Note: #onStreamingCodersViewModelChanged is sent before #subscribeToStreamingCodersViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostStreamingCodersViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
	
	BlFrameTelemetry
		time: [ 'Build filters widget' ]
		during: [ self buildFilter ].

	list stream: streamingCodersViewModel coderViewModelsStream.

	streamingCodersViewModel hasScrollTarget
		ifTrue: [ self updateScrollTarget: streamingCodersViewModel scrollTarget ]
]

{ #category : #'api - streaming coders view model' }
GtPharoStreamingMethodsCoderElement >> subscribeToStreamingCodersViewModel [
	"Is sent after a new streamingCodersViewModel is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromStreamingCodersViewModel if the receiver subscribes to them"
	<modelSubscriber: #streamingCoders>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
	
	streamingCodersViewModel
		when: GtStreamingCodersViewModelStreamChanged
			send: #onStreamingCodersChanged:
			to: self;
		when: GtStreamingCodersViewModelScrollTargetChanged
			send: #onScrollTargetChanged:
			to: self;
		when: GtFilteredCodersViewModelFilterChanged
			send: #onFilterChanged:
			to: self
]

{ #category : #'api - streaming coders view model' }
GtPharoStreamingMethodsCoderElement >> unsubscribeFromStreamingCodersViewModel [
	"Is sent before a new streamingCodersViewModel is assigned to the receiver.
	Objects that subscribe to streamingCodersViewModel are required to implement this method."
	<modelUnsubscriber: #streamingCoders>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
	
	streamingCodersViewModel unsubscribe: self
]

{ #category : #'private - update' }
GtPharoStreamingMethodsCoderElement >> updateCodersFilters: anEvent [
	| filters |
	
	filters := OrderedCollection new.

	anEvent filterElement filtersDo: [ :descriptor :value |
		filters add: (descriptor newFilterWithValue: value) ].
	
	streamingCodersViewModel streamingCodersModel additionalFilters: filters
]

{ #category : #'private - update' }
GtPharoStreamingMethodsCoderElement >> updateScrollTarget: aScrollTarget [
	list scrollToItemSuchThat: [ :eachItem | aScrollTarget applicableTo: eachItem ]
]
