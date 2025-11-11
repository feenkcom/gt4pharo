Class {
	#name : #GtPharoStreamingMethodsCoderElement,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable + TGtWithStreamingCodersViewModel',
	#classTraits : 'TBrLayoutResizable classTrait + TGtWithStreamingCodersViewModel classTrait',
	#instVars : [
		'list',
		'listItemsProvider',
		'showIndicator',
		'preloadAmount',
		'loadSinglesUntil'
	],
	#category : #'GToolkit-Pharo-Coder-Method-UI-! Views'
}

{ #category : #converting }
GtPharoStreamingMethodsCoderElement >> asScrollableElement [
	"I am already a scrollable list of methods, no need to wrap me again"
	^ self
]

{ #category : #'instance creation' }
GtPharoStreamingMethodsCoderElement >> buildFilter [
	^ GtPharoStreamingMethodsFiltersElementStencil defaultStencil
		streamingCodersViewModel: streamingCodersViewModel;
		asElement
]

{ #category : #'instance creation' }
GtPharoStreamingMethodsCoderElement >> buildFilterAndIndicator [

	| container |
	container := BrHorizontalPane new vFitContent hMatchParent.

	container addChild: self buildFilter as: #filter.
	container addChild: BrFrame new vMatchParent.
	showIndicator ifTrue: [ 
		container addChild: self buildWorkingIndicator as: #workingIndicator ].

	self addChildFirst: container as: #headerContainer
]

{ #category : #accessing }
GtPharoStreamingMethodsCoderElement >> buildWorkingIndicator [
	| state label updater |
	state := #inProgress.
	label := BrButton new
			aptitude: BrGlamorousButtonWithIconAptitude new
					+ BrGlamorousButtonWithLabelTooltipAptitude2 new
					- BrGlamorousButtonExteriorAptitude;
			icon: BrGlamorousVectorIcons refresh;
			label: 'In Progress';
			disable;
			margin: (BlInsets all: 4).

	list viewModel
		when: BrListModelItemsAddedEvent
		do: [ state := #paused.
			updater requestUpdate ].
	list viewModel
		when: BrItemsProviderStartedLoadingEvent
		do: [ state := #inProgress.
			updater requestUpdate ].
	list viewModel when: BrItemsProviderDoneEvent do: [ label removeFromParent ].

	updater := BrElementUpdater new.
	updater postponedDuration: 100 milliSeconds.
	updater element: label.
	updater
		action: [ :e | 
			state = #inProgress
				ifTrue: [ label
						icon: BrGlamorousVectorIcons refresh;
						label: 'In progress' ].
			state = #paused
				ifTrue: [ label
						icon: BrGlamorousVectorIcons pause;
						label: 'Paused' ].
			updater resetUpdateRequested ].

	^ label
]

{ #category : #initialization }
GtPharoStreamingMethodsCoderElement >> defaultLayout [
	^ BlLinearLayout vertical
]

{ #category : #initialization }
GtPharoStreamingMethodsCoderElement >> defaultLoadSinglesUntil [
	^ 0
]

{ #category : #initialization }
GtPharoStreamingMethodsCoderElement >> defaultPreloadAmount [
	^ 20
]

{ #category : #accessing }
GtPharoStreamingMethodsCoderElement >> doNotShowIndicator [
	showIndicator := false
]

{ #category : #'event handling' }
GtPharoStreamingMethodsCoderElement >> filterElementDo: aBlock [
	self
		childWithId: #headerContainer
		ifFound: [ :aContainer | 
			aContainer
				childWithId: #filter
				ifFound: [ :aFilter | aBlock cull: aFilter ]
				ifNone: [  "ignore" ] ]
		ifNone: [  "ignore" ]
]

{ #category : #initialization }
GtPharoStreamingMethodsCoderElement >> initialize [
	super initialize.

	self matchParent.
	self beInSeparateCompositionLayer.

	listItemsProvider := BrStreamItemsProvider new
		preloadAmount: self preloadAmount;
		loadSinglesUntil: self loadSinglesUntil;
		stream: AsyncEmptyStream new.

	list := BrSimpleList new
		itemType: [ :anItemTypeFactory :anItemObject | anItemObject elementClass ];
		itemStencil: [ :anElementClass |
			anElementClass new
				vFitContentLimited
				id: GtSourceCoderId ];
		itemId: [ :eachCoderViewModel | eachCoderViewModel coder id ];
		itemDataBinder: [ :aCoderElement :aCoderViewModel :anItemIndex | 
			BlFrameTelemetry
				time: [ 'Set {1} as a view model of {2}'
						format: {aCoderViewModel class name.
								aCoderElement class name} ]
				during: [ aCoderElement 
					id: (GtSourceCoderId indexed: anItemIndex);
					textualCoderViewModel: aCoderViewModel ] ];
		itemsProvider: listItemsProvider.

	self addChild: list as: GtPharoStreamingMethodsCoderListId.
	showIndicator := false.
	self initializeShortcuts
]

{ #category : #initialization }
GtPharoStreamingMethodsCoderElement >> initializeShortcuts [
	self
		addShortcut: (BlShortcutWithAction new
				name: 'Focus filters';
				description: 'Move focus to filters widget';
				combination: (BlKeyCombination builder
						shift;
						primary;
						s;
						build);
				action: [ :anEvent | self onFocusFiltersShortcutEvent: anEvent ]).

	self
		addShortcut: (BlShortcutWithAction new
				combination: (BlKeyCombination builder
						shift;
						primary;
						enter;
						build);
				action: [ :anEvent :aShortcut | 
					self
						allParentsDetect: [ :each | each class = BrTabGroup ]
						ifFound: [ :aTabGroup | 
							| toolbar |
							toolbar := aTabGroup childNamed: #toolbar.
							toolbar children size > 0
								ifTrue: [ toolbar children first
										childNamed: GtPharoSearchCodeButtonId
										ifFound: [ :aButton | aButton dispatchEvent: BrDropdownShowWish new ]
										ifNone: [  ] ] ]
						ifNone: [  ] ])
]

{ #category : #initialization }
GtPharoStreamingMethodsCoderElement >> loadSinglesUntil [
	^ loadSinglesUntil ifNil: [ loadSinglesUntil := self defaultLoadSinglesUntil ]
]

{ #category : #accessing }
GtPharoStreamingMethodsCoderElement >> loadSinglesUntil: aNumber [
	loadSinglesUntil := aNumber.
	listItemsProvider loadSinglesUntil: loadSinglesUntil
]

{ #category : #'private - event handling' }
GtPharoStreamingMethodsCoderElement >> onFilterChanged: anAnnouncement [
	self
		childWithId: #filter
		ifFound: [ :aFiltersElement |
			aFiltersElement filterUpdater 
				streamingCodersViewModel: streamingCodersViewModel;
				updateFiltersElement: aFiltersElement ]
		ifNone: [  ]
]

{ #category : #'event handling' }
GtPharoStreamingMethodsCoderElement >> onFocusFiltersShortcutEvent: anEvent [
	self
		filterElementDo: [ :aFilterElement | 
			aFilterElement hasFocus ifTrue: [ ^ self ].
			anEvent consumed: true.

			BlFocusFinder new
				direction: BlFocusSearchDirectionForward new;
				root: aFilterElement;
				referenceElement: aFilterElement;
				nextFocusDo: #requestFocus ifNone: [  ] ]
]

{ #category : #'private - event handling' }
GtPharoStreamingMethodsCoderElement >> onScrollTargetChanged: anAnnouncement [
	anAnnouncement scrollTarget ifNotNil: [ :aScrollTarget |
		self updateScrollTarget: aScrollTarget ]
]

{ #category : #'private - event handling' }
GtPharoStreamingMethodsCoderElement >> onStreamingCodersChanged: anAnnouncement [
	listItemsProvider stream: streamingCodersViewModel coderViewModelsStream
]

{ #category : #'api - streaming coders view model' }
GtPharoStreamingMethodsCoderElement >> onStreamingCodersViewModelChanged [

	"Is sent when a new streamingCodersViewModel is assigned to the receiver.
	Note: #onStreamingCodersViewModelChanged is sent before #subscribeToStreamingCodersViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostStreamingCodersViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"

	<generatedFrom:
	#'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>

	BlFrameTelemetry
		time: [ 'Build filters widget' ]
		during: [ self buildFilterAndIndicator ].

	GtPharoStreamingMethodsChangedSignal new 
		element: self;
		scrollTarget: streamingCodersViewModel scrollTarget;
		emit.

	listItemsProvider stream:
		streamingCodersViewModel coderViewModelsStream.
		
	streamingCodersViewModel hasScrollTarget ifTrue: [ 
		self updateScrollTarget: streamingCodersViewModel scrollTarget ]
]

{ #category : #initialization }
GtPharoStreamingMethodsCoderElement >> preloadAmount [
	^ preloadAmount ifNil: [ preloadAmount := self defaultPreloadAmount ]
]

{ #category : #accessing }
GtPharoStreamingMethodsCoderElement >> preloadAmount: aNumber [
	preloadAmount := aNumber.
	listItemsProvider preloadAmount: preloadAmount
]

{ #category : #accessing }
GtPharoStreamingMethodsCoderElement >> showIndicator [
	showIndicator := true
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
	self flag: 'Can be deleted since it is moved to GtPharoStreamingMethodsFiltersElementFromDescriptorsStencil>>#updateCodersFilters:'.
	filters := OrderedCollection new.

	anEvent filterElement filtersDo: [ :descriptor :value |
		filters add: (descriptor newFilterWithValue: value) ].
	
	streamingCodersViewModel streamingCodersModel additionalFilters: filters
]

{ #category : #'private - update' }
GtPharoStreamingMethodsCoderElement >> updateScrollTarget: aScrollTarget [
	
	| aPromise |
	aPromise := list 
		scrollToItemSuchThat: [ :eachItem | 
			aScrollTarget applicableTo: eachItem ]
		offset: 0.
	
	GtPharoStreamingMethodsScrollToTargetSignal new 
		element: self;
		scrollTarget: aScrollTarget;
		promise: aPromise;
		emit.
]
