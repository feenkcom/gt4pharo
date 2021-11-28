Class {
	#name : #GtPharoBehaviorCoderElement,
	#superclass : #BlElement,
	#instVars : [
		'behaviorCoderUIModel',
		'container',
		'contentPane',
		'contentTabs'
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

	selectMethodBlock := [ self filterWithMethodProtocol: anAnnouncement methodProtocol source: anAnnouncement source ].
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
GtPharoBehaviorCoderElement >> behavior [
	<return: #Behavior>

	^ self coderUIModel coder behavior
]

{ #category : #callbacks }
GtPharoBehaviorCoderElement >> browseClassReferences [
	| classCoder |
	classCoder := behaviorCoderUIModel coder.

	classCoder theClass
		ifNotNil: [ :class | self phlow spawnObject: class gtReferences ]
]

{ #category : #'building ui' }
GtPharoBehaviorCoderElement >> buildClassLabel [
	| classCoder aClassNameEditor aContainer aPreviewButton removeClassButton |
	classCoder := behaviorCoderUIModel coder.

	aContainer := BrHorizontalPane new
		hMatchParent;
		alignCenterLeft;
		vFitContent.
	
	aClassNameEditor := BrEditableLabel new
		aptitude: (BrGlamorousEditableLabelAptitude new
			defaultBackground: Color transparent;
			glamorousCodeFont;
			bold;
			fontSize: 18);
		inputFilter: BrTextEditorClassNameInputFilter new;
		text: (classCoder name);
		margin: (BlInsets all: 0);
		id: GtBehaviorCoderBehaviorNameId;
		whenKey: BlKeyCombination primaryN
			labelDo: [ :aShortcutEvent | self browseClassReferences ];
		whenKey: BlKeyCombination primaryB
			labelDo: [ :aShortcutEvent| self phlow spawnTool: (GtClassCoderTool observedClass: self behavior) ];
		whenKey: BlKeyCombination primaryG
			labelDo: [ :aShortcutEvent | self phlow spawnObject: self behavior ];
		whenKey: BlKeyCombination primaryR
			labelDo: [ :aShortcutEvent | aShortcutEvent currentTarget switchToEditor ];
		whenKey: BlKeyCombination primaryC
			labelDo: [ :aShortcutEvent | Clipboard clipboardText: self behavior name asString ].
	
	(GtCompletionController
		on: aClassNameEditor
		strategy: (GtClassesCompletionStrategy new)) install showOnTextModification: false.

	aPreviewButton := GtRefactoringsPreviewButton new
		id: GtBehaviorCoderBehaviorNameApplyPreviewId;
		margin: (BlInsets left: 5);
		refactorings: [ { RBRenameClassRefactoring
			model: RBNamespace new
			rename: classCoder theClass
			to: aClassNameEditor text asString } ];
		when: GtRefactoringsAppliedEvent do: [ :anEvent |
			aClassNameEditor text asString trimBoth asSymbol = classCoder name
				ifTrue: [ aContainer removeChild: anEvent currentTarget ] ].

	aClassNameEditor editor
		when: BrTextEditorModifiedEvent 
		do: [ :anEvent |
			anEvent text asString trimBoth asSymbol = classCoder name
				ifTrue: [ aContainer removeChild: aPreviewButton ]
				ifFalse: [
					"show preview button when name is modified"
					(aContainer hasChild: aPreviewButton)
						ifFalse: [ aContainer addChild: aPreviewButton after: aClassNameEditor ] ] ].

	removeClassButton := GtPreviewChangeButton new
		icon: BrGlamorousVectorIcons remove;
		label: 'Remove';
		changeAction: [ self removeClass ];
		changeStencil: [ self buildRemoveClassLabel ].

	aContainer addChild: aClassNameEditor.
	aContainer addChild: removeClassButton.

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
		coderUIModel: behaviorCoderUIModel definitionCoderUIModel;
		margin: (BlInsets top: 5 left: 5)
]

{ #category : #'building ui' }
GtPharoBehaviorCoderElement >> buildRemoveClassLabel [
	| labelText classCoder |
	
	classCoder := behaviorCoderUIModel coder.
	labelText := (classCoder theClass isReferenced
		ifTrue: [ '<1s> is referenced. Remove anyway?' ]
		ifFalse: [ classCoder theClass subclasses isEmpty
				ifTrue: [ 'Remove class <1s>' ]
				ifFalse: [ '<1s> has subclasses. Remove anyway?' ] ])
		expandMacrosWith: classCoder theClass name.
	^ BrLabel new
		margin: (BlInsets all: 10);
		aptitude: BrGlamorousLabelAptitude new glamorousRegularFont;
		text: labelText asRopedText
]

{ #category : #accessing }
GtPharoBehaviorCoderElement >> classCoder [
	^ behaviorCoderUIModel classCoder
]

{ #category : #private }
GtPharoBehaviorCoderElement >> classViewItems [
	| classCoder collector context |
	
	classCoder := behaviorCoderUIModel coder.

	collector := GtPhlowViewsCollector new
		fromObject: classCoder theClass;
		from: classCoder theClass class;
		to: Behavior;
		pragmaName: #gtClassView.

	context := GtPhlowContext new.
	context optionAt: #behaviorCoder put: behaviorCoderUIModel.

	collector context: context.

	^ collector collect
]

{ #category : #accessing }
GtPharoBehaviorCoderElement >> coderUIModel [
	^ behaviorCoderUIModel
]

{ #category : #accessing }
GtPharoBehaviorCoderElement >> coderUIModel: aGtBehaviorCoderUIModel [
	
	behaviorCoderUIModel ifNotNil: [ :aPreviousCoderViewModel | aPreviousCoderViewModel unsubscribe: self ].
	
	behaviorCoderUIModel := aGtBehaviorCoderUIModel.
	behaviorCoderUIModel coder weak
		when: GtCoderPackageUpdatedAnnouncement
			send: #actOnPackageUpdated:
			to: self;
		when: GtClassCoderMethodNavigationAnnouncement
			send: #actOnSelectMethod:
			to: self;
		when: GtClassCoderMethodProtocolNavigationAnnouncement
			send: #actOnMethodProtocol:
			to: self.

	container ifNotNil: #removeFromParent.
	container := self buildContentPane.
	self addChildFirst: container
]

{ #category : #private }
GtPharoBehaviorCoderElement >> executeTask: aBlock [
	BlUseAsyncFeatures
		ifEnabledDo: [ self enqueueTask: (BlTaskAction new action: aBlock) ]
		otherwise: aBlock
]

{ #category : #'updating ui' }
GtPharoBehaviorCoderElement >> filterWithMethodProtocol: aMethodProtocol source: aSource [

	contentTabs content 
		allChildrenBreadthFirstDetect: [ :eachElement | eachElement isKindOf: GtPharoMethodsCoderElement ] 
		ifFound: [ :theElement | theElement filterWithMethodProtocol: aMethodProtocol source: aSource ] 
		ifNone: [ "ignore" ]
]

{ #category : #initialization }
GtPharoBehaviorCoderElement >> initialize [
	super initialize.

	self
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
		
	self when: BlClickEvent do: [ self requestFocus ]
]

{ #category : #actions }
GtPharoBehaviorCoderElement >> removeClass [
	| aClassCoder coder event |
	
	aClassCoder := behaviorCoderUIModel coder.
	
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
