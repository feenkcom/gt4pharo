Extension { #name : #Behavior }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
Behavior >> gtCoderStreamingMethodsFor: aView context: aPhlowContext [
	<gtClassView>
	| aMethodsCoder aMethodsCoderViewModel aTestSuiteViewModel anExampleViewModel view aValueHolder |
	aMethodsCoder := GtPharoStreamingMethodsCoder forBehavior: self.
	aMethodsCoderViewModel := GtPharoStreamingMethodsCoderViewModel new
			streamingCodersModel: aMethodsCoder;
			shouldExpandByDefault: false;
			shouldHaveHeaderByDefault: false.
			
	aPhlowContext
		optionAt: #behaviorCoder
		ifPresent: [ :aBehaviorCoderUIModel | 
			aBehaviorCoderUIModel coderModel 
				ifObject: [ :anObject | aMethodsCoderViewModel selfObject: anObject ] 
				ifNone: [ ] ]
		ifAbsent: [ nil ].

	aTestSuiteViewModel := self
			testSuiteViewModelWith: aMethodsCoder
			fromContext: aPhlowContext.

	anExampleViewModel := GtPharoCoderUIUtility
			exampleViewModelCachedAs: #exampleViewModelHandler_gtCoderStreamingMethodsForContext
			inPhlowContext: aPhlowContext
			forMethodsCoder: aMethodsCoder.
			
	aValueHolder := ValueHolder new.


	view := aView explicit
			priority: 9;
			title: 'Methods';
			disableAsync;
			actionDropdownButtonDo: [ :aDrodownAction |
				aDrodownAction dropdown
					icon: BrGlamorousVectorIcons filter;
					tooltip: 'Filter';
					preferredExtent: 430 @ 430;
					content: [ :aButton | aMethodsCoder filterDropDown: aButton ] ];
			actionDropdownButtonDo: [ :aDrodownAction | 
				aDrodownAction
					id: GtPharoAddNewMethodButtonId;
					icon: BrGlamorousVectorIcons add;
					tooltip: 'Add new method';
					preferredExtent: GtPharoNewMethodCoderElement preferredExtent;
					content: [ :aButton | 
						self 
							gtNewMethodDropdownOn: aButton 
							withViewModel: aMethodsCoderViewModel
							withNewMethodHolder: aValueHolder ] ].

	(aMethodsCoder codeGeneratorsAvailableFor: aMethodsCoderViewModel)
		ifTrue: [ view
				actionDropdownButtonIcon: BrGlamorousVectorIcons robot
				tooltip: 'Generate'
				content: [ :anElement | aMethodsCoder codeGeneratorsDropDown: anElement for: aMethodsCoderViewModel ] ].
	^ view
		actionButtonDo: [ :aButtonAction | 
			aButtonAction
				icon: BrGlamorousVectorIcons inspect;
				tooltip: 'Inspect view model';
				action: [ :aButton | aButton phlow spawnObject: aMethodsCoderViewModel ] ];
		actionStencil: [ :aBrTab | GtPharoCoderUIUtility newExamplesDropdownButtonForViewModel: anExampleViewModel ];
		actionStencil: [ :aBrTab | GtPharoCoderUIUtility newTestsDropdownButtonForViewModel: aTestSuiteViewModel ];
		stencil: [ GtPharoStreamingMethodsCoderElement new
				streamingCodersViewModel: aMethodsCoderViewModel ];
		actionStencil: [ :aButton | 
				GtSpotterDropdownButtonStencil new
					object: self;
					tooltip: 'Search code';
					id: GtPharoSearchCodeButtonId;
					objectActOn: [ :anActOnEvent :anItem :theButton | 
						| handled navigationModel |
						handled := false.
						
						navigationModel := theButton phlow firstParentWithViewContent phlow
								firstParentWithViewContent navigationModel.
						(anItem isKindOf: RPackage)
							ifTrue: [ 
								navigationModel selectPackage: anItem.
								handled := true ].
						(anItem isKindOf: ClassDescription)
							ifTrue: [ 
								navigationModel selectClass: anItem.
								handled := true ].
						(anItem isKindOf: CompiledMethod)
							ifTrue: [ 
								navigationModel selectMethod: anItem.
								handled := true ].
						anActOnEvent beActed.
						handled ifFalse: [
							aButton phlow spawnTool: anActOnEvent toolToSend ] ];
					asElement ]
			tooltip: 'Search code'
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
Behavior >> gtCopyButtonFor: anAction [
	<gtClassAction>
	self isTrait ifTrue: [
		^ anAction dropdown
		tooltip: 'Copy Trait';
		icon: BrGlamorousVectorIcons changes;
		id: GtPharoCopyClassElementId;
		priority: 4;
		content: [ :aButton | 
			((GtCopyTraitForm for: self)
				onAccept: [ :aClass | 
					aButton inUIProcessDo: [
						aButton phlow spawnTool: (GtClassCoderTool forClass: aClass).
						aButton dispatchEvent: BrDropdownHideWish new ] ])
				asElement padding: (BlInsets all: 5) ]].

	^ anAction dropdown
		tooltip: 'Copy Class';
		icon: BrGlamorousVectorIcons changes;
		id: GtPharoCopyClassElementId;
		priority: 4;
		content: [ :aButton | 
			((GtCopyClassForm for: self)
				onAccept: [ :aClass |
					aButton inUIProcessDo: [
						aButton phlow spawnTool: (GtClassCoderTool forClass: aClass).
						aButton dispatchEvent: BrDropdownHideWish new ] ])
				asElement padding: (BlInsets all: 5) ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
Behavior >> gtNewMethodDropdownOn: aButton withViewModel: aMethodsCoderViewModel withNewMethodHolder: aNewMethodCoderHolder [
	^ GtPharoNewMethodCoderElement new
		behavior: self;
		selfObjectHolder: aMethodsCoderViewModel selfObjectHolder;
		methodCoderViewModelValueHolder: aNewMethodCoderHolder;
		onMethodCoderSaved: (GtPharoNewMethodCodeSavedHandler new
				methodsCoderViewModel: aMethodsCoderViewModel;
				element: aButton;
				methodCoderHolder: aNewMethodCoderHolder);
		when: GtPhlowObjectToSpawn
			do: [ :aSpawnEvent | 
				aButton fireEvent: (GtPhlowObjectToSpawn new
					fromPreviousSpawnEvent: aSpawnEvent;
					spawnContainer: aSpawnEvent currentTarget) ]
]
