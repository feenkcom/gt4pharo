Class {
	#name : #GtPharoMethodSearchFilterGroupingExample,
	#superclass : #Object,
	#traits : 'TBlDevScripterExamples',
	#classTraits : 'TBlDevScripterExamples classTrait',
	#category : #'GToolkit-Pharo-SearchFilters-Examples'
}

{ #category : #assertions }
GtPharoMethodSearchFilterGroupingExample >> assertSearchFilterInSecondPaneWithItemsCount: anInteger in: aScripter [

	aScripter phlowCompositeToolStep
		onPagerPaneWithIndex: 2;
		assertPhlowToolLabels: {'Search Filter' . 'inspector'}  
			andTypes: {GtPhlowSearchFilterTool . GtInspectorTool};
		assertPhlowToolValue: [ :aCompositePhlowTool |
				aCompositePhlowTool tools first searchFilter contents size ] 
			equals: [ anInteger ];
		play.
]

{ #category : #'examples - setup' }
GtPharoMethodSearchFilterGroupingExample >> filterOnDummyExamplesPackages [
	<gtExample>
	| filter |
	
	filter := 'GToolkit-Examples-Dummies-Package' gtPackageMatches.
	
	self assert: (filter contents 
		includes: GtDummyAbstractClassWithExamples>>#basicValue).
	
	^ filter
]

{ #category : #examples }
GtPharoMethodSearchFilterGroupingExample >> methodsFilter_byClassView [
	<gtExample>
	| numberOfClasses filter scripter |
	
	numberOfClasses := 15.
	
	filter := self filterOnDummyExamplesPackages.
	scripter := self 
		scripterWithModel: [filter] 
		element: [ filter gtDefaultInspectorTool asElement].
	
	scripter inspectorStep
		clickOnTabWithName: 'By Class';
		assertSelectedTabWithName: 'By Class';
		play.
		
	scripter assert
		//GtPhlowColumnedListId;
		value: [ :aColumnedList | aColumnedList items size ]
			equals: numberOfClasses.
			
	scripter assert
		//GtPhlowColumnedListId;
		//GtPhlowLabelWithIcon;
		@ 1;
		value: [ :aLabelWithIcon | aLabelWithIcon nameLabelText asString ]
			equals: 'GtDummyAbstractClassWithExamples'.
	
	^ scripter
]

{ #category : #examples }
GtPharoMethodSearchFilterGroupingExample >> methodsFilter_byClassView_selectMultipleClasses [
	<gtExample>
	| scripter |

	scripter := self pagerWithFilterInScripterOnDummyExamplesPackagesWithPragmaFilter.
	
	scripter inspectorStep
		clickOnTabWithName: 'By Class';
		assertSelectedTabWithName: 'By Class';
		play.
	
	self 
		multipleSelectCellWithLabel: GtDummyAbstractClassWithExamples name 
		and: GtDummyAnnouncingExamplesA name
		in: scripter.
				
	scripter treePager
		assertNumberOfPaneElements: 2;
		play.
		
	self assertSearchFilterInSecondPaneWithItemsCount: 4 in: scripter.
	
	^ scripter
]

{ #category : #examples }
GtPharoMethodSearchFilterGroupingExample >> methodsFilter_byClassView_selectSingleClass [
	<gtExample>
	| scripter |

	scripter := self pagerWithFilterInScripterOnDummyExamplesPackagesWithPragmaFilter.
	
	scripter inspectorStep
		clickOnTabWithName: 'By Class';
		assertSelectedTabWithName: 'By Class';
		play.
		
	self 
		selectCellWithLabel: GtDummyAbstractClassWithExamples name 
		in: scripter.
				
	scripter treePager
		assertNumberOfPaneElements: 2;
		play.
	
	self assertSearchFilterInSecondPaneWithItemsCount: 2 in: scripter.
	
	^ scripter
]

{ #category : #examples }
GtPharoMethodSearchFilterGroupingExample >> methodsFilter_byMethodView [
	<gtExample>
	| numberOfMethods filter scripter |
	
	numberOfMethods := 24.
	
	filter := self filterOnDummyExamplesPackages.
	scripter := self 
		scripterWithModel: [filter] 
		element: [ filter gtDefaultInspectorTool asElement ].
		
	scripter inspectorStep
		clickOnTabWithName: 'By Method';
		assertSelectedTabWithName: 'By Method';
		play.
		
	scripter assert
		//GtPhlowColumnedListId;
		value: [ :aColumnedList | aColumnedList items size ]
			equals: numberOfMethods.
			
	scripter assert
		//GtPhlowColumnedListId;
		//GtPhlowLabelWithIcon;
		@ 1;
		value: [ :aLabelWithIcon | aLabelWithIcon nameLabelText asString ]
			equals: 'GtDummyAbstractClassWithExamples>>#basicValue'.
	
	^ scripter
]

{ #category : #examples }
GtPharoMethodSearchFilterGroupingExample >> methodsFilter_byMethodView_selectMultipleMethods [
	<gtExample>
	| scripter firstMethod secondMethod |

	scripter := self pagerWithFilterInScripterOnDummyExamplesPackagesWithPragmaFilter.
		
	scripter inspectorStep
		onPagerPaneWithIndex: 1;
		clickOnTabWithName: 'By Method';
		play.
		
	firstMethod := GtDummyAbstractClassWithExamples>>#basicValue.
	secondMethod := GtDummyIntermediateClassWithExamples>>#basicValue.
	self 
		multipleSelectCellWithLabel: firstMethod name
		and: secondMethod name
		in: scripter.
				
	scripter treePager
		assertNumberOfPaneElements: 2;
		play.
		
	scripter inspectorStep
		onPagerPaneWithIndex: 2;
		assertSelectedTabWithName: 'Comparison';
		assertInspectedObjectOfType: GtRGMethodDefinitionWithComparisonGroup;
		assertInspectedObjectValueFor: [ :aMethodGroup | aMethodGroup size ] 
			equals: 2;
		assertInspectedObjectValueFor: [ :aMethodGroup | aMethodGroup asArray asSet ] 
			equals: {
				firstMethod methodReference.
				secondMethod methodReference
			} asSet;
		assertInspectedObjectValueFor: [ :aMethodGroup | 
				aMethodGroup highlighter symbol ] 
			equals: #gtExample;
		assertInspectedObjectSatisfies: [ :aMethodGroup | 
				aMethodGroup allSatisfy: [:each | 
					aMethodGroup highlighter symbol = #gtExample]  ] 
			description: '';
		play.
	
	^ scripter
]

{ #category : #examples }
GtPharoMethodSearchFilterGroupingExample >> methodsFilter_byMethodView_selectSingleMethod [
	<gtExample>
	| scripter targetMethod |

	scripter := self pagerWithFilterInScripterOnDummyExamplesPackagesWithPragmaFilter.

	scripter inspectorStep
		onPagerPaneWithIndex: 1;
		clickOnTabWithName: 'By Method';
		play.
		
	targetMethod := GtDummyAbstractClassWithExamples>>#basicValue.
	self 
		selectCellWithLabel: targetMethod name 
		in: scripter.
	
	scripter treePager
		assertNumberOfPaneElements: 2;
		play.
		
	scripter inspectorStep
		onPagerPaneWithIndex: 2;
		assertSelectedTabWithName: 'Source';
		assertInspectedObjectValueFor: [ :aMethod | aMethod ] 
			equals: targetMethod methodReference;
		assertInspectedObjectValueFor: [ :aMethodGroup | 
				aMethodGroup gtHighlighter symbol ] 
			equals: #gtExample;
		play.
	
	^ scripter
]

{ #category : #examples }
GtPharoMethodSearchFilterGroupingExample >> methodsFilter_byPackageView [
	<gtExample>
	| filter scripter |
	
	filter := self filterOnDummyExamplesPackages.
	scripter := self 
		scripterWithModel: [filter] 
		element: [ filter gtDefaultInspectorTool asElement ].
		
	scripter inspectorStep
		clickOnTabWithName: 'By Package';
		assertSelectedTabWithName: 'By Package';
		play.
		
	scripter assert
		//GtPhlowColumnedListId;
		value: [ :aColumnedList | aColumnedList items size ]
			equals: 7.
			
	scripter assert
		//GtPhlowColumnedListId;
		//GtPhlowLabelWithIcon;
		@ 1;
		value: [ :aLabelWithIcon | aLabelWithIcon nameLabelText asString ]
			equals: 'GToolkit-Examples-Dummies-Package1'.
	
	^ scripter
]

{ #category : #examples }
GtPharoMethodSearchFilterGroupingExample >> methodsFilter_byPackageView_multiplePackages [
	<gtExample>
	| scripter |
	
	scripter := self pagerWithFilterInScripterOnDummyExamplesPackagesWithPragmaFilter.
		
	scripter inspectorStep
		clickOnTabWithName: 'By Package';
		assertSelectedTabWithName: 'By Package';
		play.
		
	self 
		multipleSelectCellWithLabel: 'GToolkit-Examples-Dummies-Package1' 
		and: 'GToolkit-Examples-Dummies-Package2' 
		in: scripter.
	
	scripter treePager
		assertNumberOfPaneElements: 2;
		play.
	
	self assertSearchFilterInSecondPaneWithItemsCount: 4 in: scripter.
	
	^ scripter
]

{ #category : #examples }
GtPharoMethodSearchFilterGroupingExample >> methodsFilter_byPackageView_singlePackage [
	<gtExample>
	| scripter targetPackage |
	
	scripter := self pagerWithFilterInScripterOnDummyExamplesPackagesWithPragmaFilter.
		
	scripter inspectorStep
		clickOnTabWithName: 'By Package';
		assertSelectedTabWithName: 'By Package';
		play.
		
	targetPackage := 'GToolkit-Examples-Dummies-Package1' asPackage.
	self 
		selectCellWithLabel: targetPackage name 
		in: scripter.
	
	scripter treePager
		assertNumberOfPaneElements: 2;
		play.
		
	self assertSearchFilterInSecondPaneWithItemsCount: 2 in: scripter.
	
	^ scripter
]

{ #category : #utils }
GtPharoMethodSearchFilterGroupingExample >> multipleSelectCellWithLabel: aFirstLabel and: aSecondLabel in: aScripter [

	aScripter
		doubleClickStep: [ :s | 
			s
				//GtPhlowColumnedListId;
				id: #scrollable;
				// GtPhlowCellElement;
				@ [ :aCellElement | 
					aCellElement content nameLabelText asString = aFirstLabel ] ].
	aScripter
		clickStep: [ :s | 
			s
				//GtPhlowColumnedListId;
				id: #scrollable;
				// GtPhlowCellElement;
				@ [ :aCellElement | 
					aCellElement content nameLabelText asString = aSecondLabel ];
				modifiers: BlKeyModifiers primary ]
]

{ #category : #'examples - setup' }
GtPharoMethodSearchFilterGroupingExample >> pagerWithFilterInScripterOnDummyExamplesPackagesWithPragmaFilter [
	<gtExample>
	| filter scripter |
	
	filter := self filterOnDummyExamplesPackages & #gtExample gtPragmas.
	scripter := self 
		scripter: (self scripter
			extent: 1100@800) 
		withModel: [filter] 
		element: [ GtPagerSettings usedPager 
			createWrappedOn: filter gtDefaultInspectorTool asElement ].
			
	^ scripter
]

{ #category : #utils }
GtPharoMethodSearchFilterGroupingExample >> selectCellWithLabel: aLabel in: aScripter [
	<gtExample>
	
	aScripter
		doubleClickStep: [ :s | 
			s
				//GtPhlowColumnedListId;
				id: #scrollable;
				// GtPhlowCellElement;
				@ [ :aCellElement | 
					aCellElement content nameLabelText asString = aLabel ] ].
]
