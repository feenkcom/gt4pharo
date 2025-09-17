Class {
	#name : #GtPharoMethodSearchFilterGroupingExample,
	#superclass : #Object,
	#traits : 'TBlDevScripterExamples',
	#classTraits : 'TBlDevScripterExamples classTrait',
	#category : #'GToolkit-Pharo-SearchFilters-Examples'
}

{ #category : #'as yet unclassified' }
GtPharoMethodSearchFilterGroupingExample >> filterOnDummyExamplesPackages [
	<gtExample>
	| filter |
	
	filter := 'GToolkit-Examples-Dummies-Package' gtPackageMatches.
	
	self assert: (filter contents 
		includes: GtDummyAbstractClassWithExamples>>#basicValue).
	
	^ filter
]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
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
	scripter
		doubleClickStep: [ :s | 
			s
				//GtPhlowColumnedListId;
				id: #scrollable;
				// GtPhlowCellElement;
				@ [ :aCellElement | 
					aCellElement content nameLabelText asString = firstMethod name ] ].
	scripter
		clickStep: [ :s | 
			s
				//GtPhlowColumnedListId;
				id: #scrollable;
				// GtPhlowCellElement;
				@ [ :aCellElement | 
					aCellElement content nameLabelText asString = secondMethod name ];
				modifiers: BlKeyModifiers primary ].
				
	scripter pager
		assertPageCountIs: 2;
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

{ #category : #'as yet unclassified' }
GtPharoMethodSearchFilterGroupingExample >> methodsFilter_byMethodView_selectSingleMethod [
	<gtExample>
	| scripter targetMethod |

	scripter := self pagerWithFilterInScripterOnDummyExamplesPackagesWithPragmaFilter.

	scripter inspectorStep
		onPagerPaneWithIndex: 1;
		clickOnTabWithName: 'By Method';
		play.
		
	targetMethod := GtDummyAbstractClassWithExamples>>#basicValue.
	scripter
		doubleClickStep: [ :s | 
			s
				//GtPhlowColumnedListId;
				id: #scrollable;
				// GtPhlowCellElement;
				@ [ :aCellElement | 
					aCellElement content nameLabelText asString = targetMethod name ] ].
	
	scripter pager
		assertPageCountIs: 2;
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

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
GtPharoMethodSearchFilterGroupingExample >> pagerWithFilterInScripterOnDummyExamplesPackagesWithPragmaFilter [
	<gtExample>
	| filter scripter |
	
	filter := self filterOnDummyExamplesPackages & #gtExample gtPragmas.
	scripter := self 
		scripter: (self scripter
			extent: 1000@800) 
		withModel: [filter] 
		element: [ GtPager 
			createWrappedOn: filter gtDefaultInspectorTool asElement ].
			
	^ scripter
]
