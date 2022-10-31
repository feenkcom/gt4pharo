Class {
	#name : #GtPharoMethodsCoderElement,
	#superclass : #BlElement,
	#instVars : [
		'methodsCoderUIModel',
		'listElement'
	],
	#category : #'GToolkit-Pharo-Coder-UI-! Views'
}

{ #category : #converting }
GtPharoMethodsCoderElement >> asVerticallyResizableDo: aBlock [
	^ self
]

{ #category : #ui }
GtPharoMethodsCoderElement >> buildElement [
	self layout: BlLinearLayout vertical.
	self
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	self buildFilter.
	self addChild: self listElement as: #codersList
]

{ #category : #ui }
GtPharoMethodsCoderElement >> buildFilter [
	| filterElement filterDescriptors |
	methodsCoderUIModel coder canFilter
		ifFalse: [ ^ self ].
	filterDescriptors := methodsCoderUIModel coder filterDescriptors.
	filterDescriptors isEmpty
		ifTrue: [ ^ self ].
	filterElement := GtFiltersElement new
		padding: (BlInsets all: 2);
		descriptors: filterDescriptors;
		yourself.
	filterElement
		when: GtFiltersChangedEvent
		do: [ :event | self updateCodersFilters: event ].
	methodsCoderUIModel coder announcer weak
		when: GtCodersFiltersChanged
		send: #updateDisplayedFilters:
		to: self.
	self addChild: filterElement as: #filter
]

{ #category : #accessing }
GtPharoMethodsCoderElement >> codersUIModel [
	^ methodsCoderUIModel
]

{ #category : #accessing }
GtPharoMethodsCoderElement >> codersUIModel: aGtMethodsCoderUIModel [
	methodsCoderUIModel := aGtMethodsCoderUIModel.
	self buildElement.
	methodsCoderUIModel coder announcer weak
		when: GtCodersCoderAdded , GtCodersCoderRemoved , GtCodersCodersChanged
			send: #updateList
			to: self
]

{ #category : #ui }
GtPharoMethodsCoderElement >> filterElement [ 
	^ self childWithId: #filter
]

{ #category : #'updating ui' }
GtPharoMethodsCoderElement >> filterWithMethodProtocol: aMethodProtocol source: aSource [

	| aFilter | 
	aFilter := GtSearchMethodCategoryFilter forCategory: aMethodProtocol.
	methodsCoderUIModel coder setFilters: { aFilter } source: aSource.
]

{ #category : #ui }
GtPharoMethodsCoderElement >> listElement [
	listElement
		ifNotNil: [ ^ listElement ].

	listElement := BrSimpleList new
		matchParent;
		beInSeparateCompositionLayer;
		itemType: [ :itemTypeFactory :eachCoderUIModel | eachCoderUIModel elementClass ];
		itemId: [ :eachCoderUIModel | eachCoderUIModel coder id ];
		itemStencil: [ :anElementClass | anElementClass new ];
		itemDataBinder: [ :eachCoderElement :eachCoderUIModel | eachCoderElement coderViewModel: eachCoderUIModel ];
		items: methodsCoderUIModel coderUIModels;
		yourself.

	^ listElement
]

{ #category : #'private - event handling' }
GtPharoMethodsCoderElement >> scrollToEvent: anEvent [
	| coder index |
	coder := anEvent sourceCoder.
	index := methodsCoderUIModel coder coders identityIndexOf: coder.
	index > 0
		ifTrue: [ (self childNamed: #codersList) aptitude listElement
				scrollToPosition: index ]
]

{ #category : #'private - updating' }
GtPharoMethodsCoderElement >> updateCodersFilters: event [
	| filters |
	filters := OrderedCollection new.
	event filterElement
		filtersDo:
			[ :descriptor :value | filters add: (descriptor newFilterWithValue: value) ].
	^ methodsCoderUIModel coder setFilters: filters source: self
]

{ #category : #'private - updating' }
GtPharoMethodsCoderElement >> updateDisplayedFilters: anAnnouncement [
	anAnnouncement source = self ifTrue: [ ^ self ].
	self
		childWithId: #filter
		ifFound: [ :aFiltersElement |
			aFiltersElement
				buildFilters: [ methodsCoderUIModel coder additionalFilters
						do: [ :each | 
							(each class filterDescriptorFor: methodsCoderUIModel coder)
								ifNotNil: [ :descriptor | 
									| label |
									label := descriptor valueIsRequired
										ifTrue: [ each filterValueString ].
									aFiltersElement
										addFilterForDescriptor: descriptor
										andValue: label ] ] ] ]
		ifNone: [  ]
]

{ #category : #'private - updating' }
GtPharoMethodsCoderElement >> updateList [
	methodsCoderUIModel
		ifNil: [ ^ self ].
	methodsCoderUIModel updateCoderUIModels.
	self listElement items: methodsCoderUIModel coderUIModels
]
