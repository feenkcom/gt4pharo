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
	| aMethod tab selectTabBlock selectMethodBlock |

	aMethod := aGtClassCoderMethodNavigationAnnouncement method.

	tab := contentTabs viewModel tabs
		detect: [ :each | each widget label asString = 'Methods' ]
		ifNone: [ ^ self ].
	
	tab isSelected
		ifFalse: [
			selectTabBlock := [ tab select ].
			self executeTask: selectTabBlock ].
	
	selectMethodBlock := [ self selectAndScrollToMethod: aMethod ].
	self executeTask: selectMethodBlock
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

{ #category : #callbacks }
GtPharoBehaviorCoderElement >> browseClassReferences [
	| classCoder |
	classCoder := behaviorCoderViewModel coder.

	classCoder theClass
		ifNotNil: [ :class | self phlow spawnObject: class gtReferences ]
]

{ #category : #'building ui' }
GtPharoBehaviorCoderElement >> buildAdviceDropDownFor: aContainer [
	behaviorCoderViewModel behavior
		ifNotNil: [ :class | 
			| adviceStream |
			adviceStream := ((GtAdvice adviceForClass: class) asAsyncStream
					select: [ :each | each hasAdvice ]) cached.
			(adviceStream asyncSimilarCopy hasNext
				then: [ :bool | 
					bool
						ifTrue: [ aContainer
								enqueueTask: (BlTaskAction new
										action: [ aContainer addChild: (self buildAdviceListFor: adviceStream asyncSimilarCopy) ]) ] ])
				await ]
]

{ #category : #'building ui' }
GtPharoBehaviorCoderElement >> buildAdviceListFor: anAsyncStream [
	| button dropDownAptitude |
	button := GtFixItButton new.
	button beTinySize.
	button label: 'Advice'.
	dropDownAptitude := BrGlamorousWithDropdownAptitude
			handle: [ | dropdownButton |
				dropdownButton := BrButton new.
				dropdownButton beTinySize.
				dropdownButton
					aptitude: BrGlamorousButtonWithIconAptitude - BrGlamorousButtonWithLabelTooltipAptitude
							- BrGlamorousButtonExteriorAptitude.
				dropdownButton icon: BrGlamorousVectorIcons repair.
				dropdownButton ]
			content: [ | element |
				element := BrSimpleList new.
				element padding: (BlInsets all: 3).
				element vFitContentLimited.
				element hExact: 300.
				element
					itemsProvider: (BrStreamItemsProvider new
							preloadAmount: 1;
							stream: anAsyncStream asyncSimilarCopy);
					stencil: [ :eachImage | eachImage buildElementFor: button ].
				element ].
	button aptitude: BrGlamorousButtonWithIconAptitude + dropDownAptitude.
	button icon: BrGlamorousVectorIcons repair.
	button margin: (BlInsets left: 5).
	^ button
]

{ #category : #'building ui' }
GtPharoBehaviorCoderElement >> buildClassLabel [
	| classCoder aClassNameEditor aContainer aPreviewButton removeClassButton |
	classCoder := behaviorCoderViewModel coder.

	aContainer := BrHorizontalPane new
			hMatchParent;
			alignCenterLeft;
			vFitContent.

	aClassNameEditor := BrEditableLabel new
			aptitude: (BrGlamorousEditableLabelAptitude new
					defaultBackground: Color transparent;
					glamorousCodeFont;
					bold;
					fontSize: 18)
					+ (BrGlamorousWithContextMenuAptitude
							content: [ BrGlamorousSimpleContextMenuContent new items: self contextMenuItemsForClass ]);
			inputFilter: BrTextEditorClassNameInputFilter new;
			text: classCoder name;
			margin: (BlInsets all: 0);
			id: GtBehaviorCoderBehaviorNameId;
			whenKey: BlKeyCombination primaryN
				labelDo: [ :aShortcutEvent | self browseClassReferences ];
			whenKey: BlKeyCombination primaryB
				labelDo: [ :aShortcutEvent | self phlow spawnTool: (GtClassCoderTool observedClass: self behavior) ];
			whenKey: BlKeyCombination primaryG
				labelDo: [ :aShortcutEvent | self phlow spawnObject: self behavior ];
			whenKey: BlKeyCombination primaryR
				labelDo: [ :aShortcutEvent | aShortcutEvent currentTarget switchToEditor ];
			whenKey: BlKeyCombination primaryC
				labelDo: [ :aShortcutEvent | Clipboard clipboardText: self behavior name asString ].

	(GtCompletionController
		on: aClassNameEditor
		strategy: GtClassesCompletionStrategy new) install
		showOnTextModification: false.

	aPreviewButton := GtRefactoringsPreviewButton new
			id: GtBehaviorCoderBehaviorNameApplyPreviewId;
			margin: (BlInsets left: 5);
			refactorings: [ {GtRBRenameClassRefactoring
						model: (RBClassModelFactory rbNamespace
								onEnvironment: RBBrowserEnvironment new)
						rename: classCoder theClass name
						to: aClassNameEditor text asString} ];
			cancelBlock: [ aClassNameEditor text: classCoder theClass name ];
			when: GtRefactoringsAppliedEvent
				do: [ :anEvent | 
					aClassNameEditor text asString trimBoth asSymbol = classCoder name
						ifTrue: [ aContainer removeChild: anEvent currentTarget ] ].

	aClassNameEditor editor
		when: BrTextEditorModifiedEvent
		do: [ :anEvent | 
			anEvent text asString trimBoth asSymbol = classCoder name
				ifTrue: [ aContainer removeChild: aPreviewButton ]
				ifFalse: [ (aContainer hasChild: aPreviewButton)
						ifFalse: [ aContainer addChild: aPreviewButton after: aClassNameEditor ] ] ].

	removeClassButton := GtPreviewChangeButton new
			icon: BrGlamorousVectorIcons remove;
			label: 'Remove';
			changeAction: [ self removeClass ];
			changeStencil: [ GtPharoRemoveClassPreviewStencil new
					classToRemove: classCoder theClass;
					anElement: self;
					create ].

	aContainer addChild: aClassNameEditor.
	aContainer addChild: removeClassButton.

	self buildAdviceDropDownFor: aContainer.

	aContainer addChild: self toolbarElement.

	^ aContainer
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
	contentPane addChild: self buildClassLabel.
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
	behaviorCoderViewModel
		ifNotNil: [ :aPreviousCoderViewModel | aPreviousCoderViewModel unsubscribe: self ].

	behaviorCoderViewModel := aGtBehaviorCoderViewModel.
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

	container ifNotNil: #removeFromParent.
	container := self buildContentPane.
	self addChildFirst: container
]

{ #category : #'building ui' }
GtPharoBehaviorCoderElement >> contextMenuItemsForClass [
	^ {'Browse references' -> [ :e | self browseClassReferences ].
		'Rename' -> [ :e | e switchToEditor ]}
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

{ #category : #actions }
GtPharoBehaviorCoderElement >> removeClass [
	| aClassCoder coder event |
	
	aClassCoder := behaviorCoderViewModel coder.
	
	coder := aClassCoder packageTag
		ifNotNil: [ :tag | GtPharoPackageTagCoder forPackageTag: tag ]
		ifNil: [ GtPharoPackageCoder forPackage: aClassCoder package ].
	aClassCoder removeClass.
	event := GtCoderToReplace new coder: coder.
	self fireEvent: event
]

{ #category : #'updating ui' }
GtPharoBehaviorCoderElement >> removeContentTabs [
	contentTabs
		ifNotNil: [ contentPane removeChild: contentTabs.
			contentTabs := nil ]
]

{ #category : #'updating ui' }
GtPharoBehaviorCoderElement >> selectAndScrollToMethod: aMethod [

	contentTabs content 
		allChildrenBreadthFirstDetect: [ :eachElement | eachElement isKindOf: GtPharoStreamingMethodsCoderElement ] 
		ifFound: [ :theElement |
			theElement streamingCodersViewModel
				expandAndFocusCompiledMethod: aMethod;
				scrollToCompiledMethod: aMethod ] 
		ifNone: [ "ignore" ]
]

{ #category : #'building ui' }
GtPharoBehaviorCoderElement >> streamingMethodCodersElement [
	^ contentTabs content
		allChildrenBreadthFirstDetect: [ :eachElement | eachElement isKindOf: GtPharoStreamingMethodsCoderElement ]
		ifFound: #yourself
		ifNone: [ nil ]
]
