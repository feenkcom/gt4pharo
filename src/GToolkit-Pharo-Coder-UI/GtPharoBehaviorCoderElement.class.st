Class {
	#name : #GtPharoBehaviorCoderElement,
	#superclass : #BlElement,
	#traits : 'TGtWithCoderToolbar',
	#classTraits : 'TGtWithCoderToolbar classTrait',
	#instVars : [
		'container',
		'contentPane',
		'contentTabs',
		'behaviorCoderViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-! Views'
}

{ #category : #callbacks }
GtPharoBehaviorCoderElement >> actOnMethodProtocol: anAnnouncement [
	| tab selectTabBlock selectMethodBlock |
	tab := contentTabs viewModel tabs
			detect: [ :each | each widget label asString = 'Methods' ]
			ifNone: [ ^ self ].
	tab isSelected
		ifFalse: [ selectTabBlock := [ tab select ].
			self executeTask: selectTabBlock ].

	selectMethodBlock := [ self
			filterWithMethodProtocol: anAnnouncement methodProtocol name
			source: anAnnouncement source ].
	self executeTask: selectMethodBlock
]

{ #category : #callbacks }
GtPharoBehaviorCoderElement >> actOnPackageUpdated: ann [
	self removeContentTabs
]

{ #category : #callbacks }
GtPharoBehaviorCoderElement >> actOnSelectMethod: aGtClassCoderMethodNavigationAnnouncement [
	| aMethod aTask |
	aMethod := aGtClassCoderMethodNavigationAnnouncement method.
	aTask := GtPharoSelectAndScrollToMethodRepeatedTask new
		method: aMethod;
		contentTabs: contentTabs.
	self enqueueTask: aTask.
]

{ #category : #accessing }
GtPharoBehaviorCoderElement >> actOnSlot: anAnnouncement [
	| tab selectTabBlock selectMethodBlock |
	tab := contentTabs viewModel tabs
			detect: [ :each | each widget label asString = 'Methods' ]
			ifNone: [ ^ self ].
	tab isSelected
		ifFalse: [ selectTabBlock := [ tab select ].
			self executeTask: selectTabBlock ].
	selectMethodBlock := anAnnouncement slot owningClass isMeta
			ifTrue: [ [ self
					filterWithClassSlot: anAnnouncement slot name
					source: anAnnouncement source ] ]
			ifFalse: [ anAnnouncement slot isClassVariable
					ifTrue: [ [ self
							filterWithClassVariable: anAnnouncement slot name
							source: anAnnouncement source ] ]
					ifFalse: [ [ self
							filterWithSlot: anAnnouncement slot name
							source: anAnnouncement source ] ] ].
	self executeTask: selectMethodBlock
]

{ #category : #accessing }
GtPharoBehaviorCoderElement >> addFilters: filters [
	contentTabs content
		allChildrenBreadthFirstDetect: [ :eachElement | eachElement isKindOf: GtPharoStreamingMethodsCoderElement ]
		ifFound: [ :theElement | theElement streamingCodersViewModel additionalFilters: filters ]
		ifNone: [  "ignore" ]
]

{ #category : #'updating ui' }
GtPharoBehaviorCoderElement >> addOrReplaceFilter: aFilter [
	contentTabs content
		allChildrenBreadthFirstDetect: [ :eachElement | eachElement isKindOf: GtPharoStreamingMethodsCoderElement ]
		ifFound: [ :theElement | 
			| vm existing changed |
			vm := theElement streamingCodersViewModel.
			changed := false.
			existing := vm additionalFilters
					collect: [ :each | 
						each class = aFilter class
							ifTrue: [ changed := true.
								aFilter ]
							ifFalse: [ each ] ].
			changed ifFalse: [ existing := existing , {aFilter} ].
			vm additionalFilters: existing ]
		ifNone: [  "ignore" ]
]

{ #category : #accessing }
GtPharoBehaviorCoderElement >> behavior [
	<return: #Behavior>

	^ self coderViewModel coder behavior
]

{ #category : #'building ui' }
GtPharoBehaviorCoderElement >> buildClassHeader [
	| headerContainer |

	headerContainer := BrHorizontalPane new
		hMatchParent;
		alignCenterLeft;
		vFitContent.

	headerContainer addChild: (GtPharoBehaviorCoderNameElement new 
		coderViewModel: behaviorCoderViewModel).
	headerContainer addChild: self toolbarElement.

	^ headerContainer
]

{ #category : #'building ui' }
GtPharoBehaviorCoderElement >> buildContentPane [

	contentPane := BlElement new.
	contentPane layout: BlLinearLayout vertical.
	contentPane constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical matchParent ].
	contentPane padding: (BlInsets top: 5 left: 6 bottom: 5 right: 6).
	contentPane addChild: self makeLabel.
	contentPane addChild: self buildClassHeader.
	contentPane addChild: self buildDefinitionElement.
	contentPane addChild: self buildContentTabs.

	^ contentPane
]

{ #category : #'building ui' }
GtPharoBehaviorCoderElement >> buildContentTabs [
	<return: #BrTabGroup>

	contentTabs := GtPhlowCompositeView new
		views: self classViewItems;
		asElementDo: [ :aBrTabGroup | aBrTabGroup ].

	^ contentTabs
]

{ #category : #'building ui' }
GtPharoBehaviorCoderElement >> buildDefinitionElement [

	^ GtPharoBehaviorDefinitionCoderElement new
		coderViewModel: behaviorCoderViewModel definitionCoderUIModel;
		margin: (BlInsets top: 5 left: 5)
]

{ #category : #accessing }
GtPharoBehaviorCoderElement >> classCoder [
	^ behaviorCoderViewModel classCoder
]

{ #category : #private }
GtPharoBehaviorCoderElement >> classViewItems [
	| classCoder collector context |
	
	classCoder := behaviorCoderViewModel coder.

	collector := GtPhlowViewsCollector new
		fromObject: classCoder theClass;
		from: classCoder theClass class;
		to: Behavior;
		pragmaName: #gtClassView.

	context := GtPhlowContext new.
	context optionAt: #behaviorCoder put: behaviorCoderViewModel.

	collector context: context.

	^ collector collect
]

{ #category : #accessing }
GtPharoBehaviorCoderElement >> coderViewModel [
	^ behaviorCoderViewModel
]

{ #category : #accessing }
GtPharoBehaviorCoderElement >> coderViewModel: aGtBehaviorCoderViewModel [
	self unsubscribeFromCoderViewModel.

	behaviorCoderViewModel := aGtBehaviorCoderViewModel.
	self subscribeToCoderViewModel.

	self updateContent.
]

{ #category : #private }
GtPharoBehaviorCoderElement >> executeTask: aBlock [
	BlUseAsyncFeatures
		ifEnabledDo: [ self enqueueTask: (BlTaskAction new action: aBlock) ]
		otherwise: aBlock
]

{ #category : #accessing }
GtPharoBehaviorCoderElement >> filterWithClassSlot: slotName source: aSource [
	self
		addFilters: {GtSearchClassSlotReferenceFilter
					forClass: aSource selectedClass class
					andVariable: slotName}
]

{ #category : #accessing }
GtPharoBehaviorCoderElement >> filterWithClassVariable: slotName source: aSource [
	self
		addFilters: {GtSearchClassVariableReferenceFilter
					forClass: aSource selectedClass
					andVariable: slotName}
]

{ #category : #'updating ui' }
GtPharoBehaviorCoderElement >> filterWithMethodProtocol: aMethodProtocol source: aSource [
	self addOrReplaceFilter: (GtSearchMethodCategoryFilter forCategory: aMethodProtocol)
]

{ #category : #accessing }
GtPharoBehaviorCoderElement >> filterWithSlot: slotName source: aSource [
	self
		addFilters: {GtSearchInstanceSlotReferenceFilter
					forClass: aSource selectedClass
					andVariable: slotName}
]

{ #category : #initialization }
GtPharoBehaviorCoderElement >> initialize [
	super initialize.
	self initializeToolbarElement.

	self
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
		
	self when: BlClickEvent do: [ self requestFocus ]
]

{ #category : #'building ui' }
GtPharoBehaviorCoderElement >> makeLabel [
	^ BrLabel new
		aptitude: (BrGlamorousLabelAptitude new glamorousRegularFontAndSize
				foreground: Color gray;
				fontSize: 12);
		text: 'Class';
		padding: (BlInsets left: 5)
]

{ #category : #'updating ui' }
GtPharoBehaviorCoderElement >> removeContentTabs [
	contentTabs
		ifNotNil: [ 
			contentPane removeChild: contentTabs.
			contentTabs := nil ]
]

{ #category : #'building ui' }
GtPharoBehaviorCoderElement >> streamingMethodCodersElement [
	^ contentTabs content
		allChildrenBreadthFirstDetect: [ :eachElement | eachElement isKindOf: GtPharoStreamingMethodsCoderElement ]
		ifFound: #yourself
		ifNone: [ nil ]
]

{ #category : #subscriptions }
GtPharoBehaviorCoderElement >> subscribeToCoderViewModel [	
	behaviorCoderViewModel coder weak
		when: GtCoderPackageUpdatedAnnouncement
			send: #actOnPackageUpdated:
			to: self;
		when: GtClassCoderMethodNavigationAnnouncement
			send: #actOnSelectMethod:
			to: self;
		when: GtClassCoderMethodProtocolNavigationAnnouncement
			send: #actOnMethodProtocol:
			to: self;
		when: GtClassCoderSlotNavigationAnnouncement
			send: #actOnSlot:
			to: self.
]

{ #category : #subscriptions }
GtPharoBehaviorCoderElement >> unsubscribeFromCoderViewModel [	
	behaviorCoderViewModel
		ifNotNil: [ :aPreviousCoderViewModel | 
			aPreviousCoderViewModel unsubscribe: self ].
]

{ #category : #accessing }
GtPharoBehaviorCoderElement >> updateContent [
	container ifNotNil: [ :anElement | anElement removeFromParent].
	
	container := self buildContentPane.
	self addChildFirst: container
]
