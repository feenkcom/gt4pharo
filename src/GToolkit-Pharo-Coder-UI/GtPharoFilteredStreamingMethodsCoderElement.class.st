Class {
	#name : #GtPharoFilteredStreamingMethodsCoderElement,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable + TGtWithPharoFilteredStreamingMethodsCoderViewModel',
	#classTraits : 'TBrLayoutResizable classTrait + TGtWithPharoFilteredStreamingMethodsCoderViewModel classTrait',
	#instVars : [
		'list'
	],
	#category : #'GToolkit-Pharo-Coder-UI-! Views'
}

{ #category : #'instance creation' }
GtPharoFilteredStreamingMethodsCoderElement >> buildFilter [
	| filterElement filterDescriptors |

	filterDescriptors := pharoFilteredStreamingMethodsCoderViewModel codersModel filterDescriptors.
	filterDescriptors isEmpty
		ifTrue: [ ^ self ].

	filterElement := GtFiltersElement new
		padding: (BlInsets all: 2);
		descriptors: filterDescriptors;
		yourself.

	filterElement
		when: GtFiltersChangedEvent
		do: [ :event | self updateCodersFilters: event ].

	pharoFilteredStreamingMethodsCoderViewModel codersModel
		when: GtCodersFiltersChanged
		send: #updateDisplayedFilters:
		to: self.

	self addChildFirst: filterElement as: #filter
]

{ #category : #initialization }
GtPharoFilteredStreamingMethodsCoderElement >> defaultLayout [
	^ BlLinearLayout vertical
]

{ #category : #initialization }
GtPharoFilteredStreamingMethodsCoderElement >> initialize [
	super initialize.
	
	self matchParent.
	
	list := BrSimpleList new
		itemType: [ :anItemTypeFactory :anItemObject | anItemObject class ];
		itemStencil: [ GtExpandableMethodCoderForBehaviorElement new ];
		itemDataBinder: [ :aCoderElement :aCoderViewModel | aCoderElement textualCoderViewModel: aCoderViewModel ].
	
	self addChild: list
]

{ #category : #'api - pharo filtered streaming methods coder view model' }
GtPharoFilteredStreamingMethodsCoderElement >> onPharoFilteredStreamingMethodsCoderViewModelChanged [
	"Is sent when a new pharoFilteredStreamingMethodsCoderViewModel is assigned to the receiver.
	Note: #onPharoFilteredStreamingMethodsCoderViewModelChanged is sent before #subscribeToPharoFilteredStreamingMethodsCoderViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoFilteredStreamingMethodsCoderViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>

	self buildFilter.
	list stream: pharoFilteredStreamingMethodsCoderViewModel coderViewModelsStream
]

{ #category : #'private - event handling' }
GtPharoFilteredStreamingMethodsCoderElement >> onStreamingCodersChanged: anAnnouncement [
	list stream: pharoFilteredStreamingMethodsCoderViewModel coderViewModelsStream
]

{ #category : #'api - pharo filtered streaming methods coder view model' }
GtPharoFilteredStreamingMethodsCoderElement >> subscribeToPharoFilteredStreamingMethodsCoderViewModel [
	"Is sent after a new pharoFilteredStreamingMethodsCoderViewModel is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromPharoFilteredStreamingMethodsCoderViewModel if the receiver subscribes to them"
	<modelSubscriber: #filteredStreamingMethodsCoderViewModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
	
	pharoFilteredStreamingMethodsCoderViewModel
		when: GtStreamingCodersViewModelChanged
		send: #onStreamingCodersChanged:
		to: self
]

{ #category : #'api - pharo filtered streaming methods coder view model' }
GtPharoFilteredStreamingMethodsCoderElement >> unsubscribeFromPharoFilteredStreamingMethodsCoderViewModel [
	"Is sent before a new pharoFilteredStreamingMethodsCoderViewModel is assigned to the receiver.
	Objects that subscribe to pharoFilteredStreamingMethodsCoderViewModel are required to implement this method."
	<modelUnsubscriber: #filteredStreamingMethodsCoderViewModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
	
	pharoFilteredStreamingMethodsCoderViewModel unsubscribe: self
]

{ #category : #'private - update' }
GtPharoFilteredStreamingMethodsCoderElement >> updateCodersFilters: event [
	| filters |
	filters := OrderedCollection new.
	event filterElement
		filtersDo:
			[ :descriptor :value | filters add: (descriptor newFilterWithValue: value) ].
	^ pharoFilteredStreamingMethodsCoderViewModel codersModel additionalFilters: filters
]
