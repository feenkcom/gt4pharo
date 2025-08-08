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
			filterWithMethodProtocol: anAnnouncement methodProtocol
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

{ #category : #callbacks }
GtPharoBehaviorCoderElement >> actOnSelectMethods: aGtClassCoderMethodsNavigationAnnouncement [
	| selectedMethods aTask |
	
	selectedMethods := aGtClassCoderMethodsNavigationAnnouncement methods.
	aTask := GtPharoSelectAndScrollToMethodsRepeatedTask new
		methods: selectedMethods;
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
		ifFound: [ :theElement | theElement streamingCodersViewModel addOrReplaceFilters: filters ]
		ifNone: [  "ignore" ]
]

{ #category : #'updating ui' }
GtPharoBehaviorCoderElement >> addOrReplaceFilter: aFilter [
	contentTabs content
		allChildrenBreadthFirstDetect: [ :eachElement | 
			eachElement isKindOf: GtPharoStreamingMethodsCoderElement ]
		ifFound: [ :theElement | 
			| aViewModel |
			aViewModel := theElement streamingCodersViewModel.
			aViewModel addOrReplaceFilter: aFilter ]
		ifNone: [ "ignore" ]
]

{ #category : #'updating ui' }
GtPharoBehaviorCoderElement >> addOrReplaceFilters: aCollectionOfFilters [
	contentTabs content
		allChildrenBreadthFirstDetect: [ :eachElement | 
			eachElement isKindOf: GtPharoStreamingMethodsCoderElement ]
		ifFound: [ :theElement | 
			| aViewModel |
			aViewModel := theElement streamingCodersViewModel.
			aViewModel addOrReplaceFilters: aCollectionOfFilters ]
		ifNone: [ "ignore" ]
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
		id: GtPharoHeaderContainerElementId;
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
	| classCoder context object aListener |
	classCoder := behaviorCoderViewModel coder.
	context := GtPhlowContext new.
	context optionAt: #behaviorCoder put: behaviorCoderViewModel.
	object := classCoder theClass.
	contentTabs := GtPhlowCompositeView new
			object: object
				arguments: {GtPhlowView empty.
						context};
			collectorDo: [ :aCollector | 
				aCollector
					context: context;
					fromObject: object;
					from: object class;
					to: Behavior;
					pragmaName: #gtClassView ];
			asElementDo: [ :aBrTabGroup | aBrTabGroup ].

	aListener := GtPhlowChangeMethodSystemAnnouncerListener
			installOnCompositeElement: contentTabs.
	aListener
		interestingPragmas: { #gtClassView }
		andObject: object.
		
	"We do not want to propagate detail states to children."
	contentTabs states addState: GtPhlowToolDetailState normal.
	contentTabs states addState: GtPhlowToolDetailPositionState left.

	^ contentTabs
]

{ #category : #'building ui' }
GtPharoBehaviorCoderElement >> buildDefinitionElement [

	^ GtPharoBehaviorDefinitionCoderElement new
		coderViewModel: behaviorCoderViewModel definitionCoderUIModel;
		margin: (BlInsets top: 5 left: 5)
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
	self addOrReplaceFilter: (GtSearchMethodCategoryFilter forCategory: aMethodProtocol name)
]

{ #category : #accessing }
GtPharoBehaviorCoderElement >> filterWithSlot: slotName source: aSource [
	self
		addFilters: {GtSearchInstanceSlotReferenceFilter
					forClass: aSource selectedClass
					andVariable: slotName}
]

{ #category : #'private - updating' }
GtPharoBehaviorCoderElement >> hideDefinitionElements [
	contentPane ifNil: [ ^ self ].
	contentPane
		childrenDo: [ :eachChild | 
			(contentTabs == eachChild or: [ eachChild id = GtPharoHeaderContainerElementId asBlocElementId ])
				ifFalse: [ eachChild visibility: BlVisibility gone ] ]
]

{ #category : #initialization }
GtPharoBehaviorCoderElement >> initialize [
	super initialize.
	self initializeToolbarElement.
	self beFocusable.

	self
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].

	self when: BlClickEvent do: [ self requestFocus ].

	self
		addAptitude: (GtPhlowToolDetailAptitude new
				topDetailed: [ :aStyle | aStyle do: [ self hideDefinitionElements ] ];
				normal: [ :aStyle | aStyle do: [ self showDefinitionElement ] ];
				left: [ :aStyle | aStyle do: [ self showDefinitionElement ] ])
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

{ #category : #'private - updating' }
GtPharoBehaviorCoderElement >> showDefinitionElement [
	contentPane ifNil: [ ^ self ].
	contentTabs ifNil: [ ^ self ].

	contentPane ifNil: [ ^ self ].
	contentPane
		childrenDo: [ :eachChild | (contentTabs == eachChild or: [ eachChild id = GtPharoHeaderContainerElementId asBlocElementId ]) ifFalse: [ eachChild visibility: BlVisibility visible ] ]
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
		when: GtClassCoderMethodsNavigationAnnouncement
			send: #actOnSelectMethods:
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
