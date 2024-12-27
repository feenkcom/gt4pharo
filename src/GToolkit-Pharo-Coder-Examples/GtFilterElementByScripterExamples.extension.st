Extension { #name : #GtFilterElementByScripterExamples }

{ #category : #'*GToolkit-Pharo-Coder-Examples' }
GtFilterElementByScripterExamples >> classCoder [
	<gtExample>
	| aScripter |
	aScripter := self dummyTwoClassCoderDuring: [ :aStep |  ].

	^ aScripter
]

{ #category : #'*GToolkit-Pharo-Coder-Examples' }
GtFilterElementByScripterExamples >> classCoderAddMethodProtocolFilter [
	<gtExample>
	| aScripter |
	aScripter := self classCoderSelectSuperclass.

	aScripter memoryLogger
		runFor: GtFilterSignal
		during: [ :aStep | 
			aStep filterStep
				clickOnAddFilter;
				clickOnDropdownMethodProtocolItem;
				assertFilterModelAtIndex: 2 itemsCountIs: 4;
				play.
			aStep filterStep
				clickOnFilterSettingsAtIndex: 2;
				play.

			aStep filterStep
				clickOnDropdownFilterItem: (GtFilterModelStringItem new string: 'initialization');
				assertFilterModelNamed: GtSearchMethodCategoryFilter filterName
					selectedValueIs: (GtFilterModelStringItem new string: 'initialization');
				play.
			aStep filterStep
				assertMethodsUpToFilterModel;
				play.
			aStep filterStep
				assertMethodProtocolFilterModel;
				play ].

	aScripter methodsCoder
		assertNumberOfVisibleMethodsIsExactly: 1;
		play.

	^ aScripter
]

{ #category : #'*GToolkit-Pharo-Coder-Examples' }
GtFilterElementByScripterExamples >> classCoderSelectAnotherMethodProtocol [
	<gtExample>
	| aScripter |
	aScripter := self classCoderSelectProtoObjectSuperclass.
	
	aScripter filterStep
		clickOnFilterSettingsAtIndex: 2;
		assertFilterModelAtIndex: 2 itemsCountIsAtLeast: 20;
		clickOnDropdownFilterItem: (GtFilterModelStringItem new string: Protocol gtAllProtocolDefaultName);
		assertFilterModelAtIndex: 2
			selectedValueIs: (GtFilterModelStringItem new string: Protocol gtAllProtocolDefaultName);
		play.
		
	aScripter methodsCoder
		assertNumberOfVisibleMethodsIsAtLeast: 8;
		play.

	^ aScripter
]

{ #category : #'*GToolkit-Pharo-Coder-Examples' }
GtFilterElementByScripterExamples >> classCoderSelectProtoObjectSuperclass [
	<gtExample>
	| aScripter |
	aScripter := self classCoderAddMethodProtocolFilter.

	aScripter filterStep
		clickOnFilterSettingsAtIndex: 1;
		clickOnDropdownFilterItem: (GtFilterModelClassItem new itemClass: ProtoObject);
		assertFilterModelNamed: GtSearchInheritedMethodsFilter filterName
			selectedValueIs: (GtFilterModelClassItem new itemClass: ProtoObject);
		assertMethodsUpToFilterModel;
		assertMethodProtocolFilterModel;
		play.

	aScripter methodsCoder
		assertNumberOfVisibleMethodsIsExactly: 2;
		play.

	^ aScripter
]

{ #category : #'*GToolkit-Pharo-Coder-Examples' }
GtFilterElementByScripterExamples >> classCoderSelectSuperclass [
	<gtExample>
	| aScripter |
	aScripter := self classCoder.

	aScripter filterStep
		clickOnFilterSettingsAtIndex: 1;
		clickOnDropdownFilterItem: (GtFilterModelClassItem new itemClass: GtPharoDummyOneObject);
		assertFilterModelAtIndex: 1
			selectedValueIs: (GtFilterModelClassItem new itemClass: GtPharoDummyOneObject);
		play.

	aScripter methodsCoder
		waitForEnqueuedAndProcessedSpaceTasks;
		assertNumberOfVisibleMethodsIsAtLeast: GtPharoDummyTwoObject methodDict size + 1;
		play.

	^ aScripter
]

{ #category : #'*GToolkit-Pharo-Coder-Examples' }
GtFilterElementByScripterExamples >> dummyTwoClassCoderDuring: aBlock [
	<gtExample>
	| aScripter |
	aScripter := self scripter.
	aScripter
		substeps: 'Use filter model'
		before: [ | aDefaultClass |
			aDefaultClass := GtPharoStreamingMethodsFiltersElementStencil
					defaultStencilClassOrNil.
			GtPharoStreamingMethodsFiltersElementStencil beModelStencilDefault.
			aDefaultClass ]
		play: [ :aStep | 
			aStep memoryLogger
				runFor: GtFilterSignal
				during: [ :aLoggerStep | 
					aLoggerStep do
						label: 'Initialize coder';
						element: [ GtCoder forClass: GtPharoDummyTwoObject ].
					aStep assert
						label: 'Assert methods coder element exists';
						exists;
						// GtPharoStreamingMethodsCoderElement.
					aStep assert
						label: 'Assert filter items element exists';
						exists;
						// GtFilterItemsElement.
					aLoggerStep substeps: 'Interactions' do: aBlock ] ]
		ensure: [ :aDefaultClass | GtPharoStreamingMethodsFiltersElementStencil defaultStencilClass: aDefaultClass ].

	^ aScripter
]

{ #category : #'*GToolkit-Pharo-Coder-Examples' }
GtFilterElementByScripterExamples >> itemsModelWithMethodsCoder [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterWithModel: [ GtFilterModelExamples new itemsModelWithMethodsCoder ]
			element: [ :aModel | self newFilterItemsElementForFiltersModel: aModel ].

	^ aScripter
]

{ #category : #'*GToolkit-Pharo-Coder-Examples' }
GtFilterElementByScripterExamples >> newFilterItemsElementForFiltersModel: aFiltersModel [
	<gtExample>
	
	| aMethodsCoder aList |
	aList := BrSimpleList new
		itemStencil: [ GtExpandableMethodCoderElement new ];
		itemDataBinder: [ :aCoderElement :aCoderViewModel | 
			aCoderElement coderViewModel: aCoderViewModel ].
	aMethodsCoder := aFiltersModel availableFiltersBuilder ifNotNil: #coders.
	aMethodsCoder ifNotNil: [
		| aStream aCodersUpdater aListUpdater |
		aCodersUpdater := GtFilterMethodCodersAdditionalFiltersUpdater new 
			coders: aMethodsCoder;
			filtersModel: aFiltersModel.
		aFiltersModel weak 
			when: GtFiltersModelUpdated 
			send: #onFiltersUpdated:
			to: aCodersUpdater.
		
		aStream := aMethodsCoder asAsyncStream
			map: [ :eachCoder | eachCoder asCoderViewModel expanded: false ].
		aList stream: aStream.	
		aListUpdater := GtFilterMethodsCoderListUpdater new
			coders: aMethodsCoder;
			list: aList.
		aList userData at: GtFilterMethodCodersAdditionalFiltersUpdater put: aCodersUpdater.
		aList userData at: GtFilterMethodsCoderListUpdater put: aListUpdater ].

	^ BrVerticalPane new
		matchParent;
		clipChildren: false;
		addChild: aFiltersModel asFiltersElement;
		addChild: aList
]
