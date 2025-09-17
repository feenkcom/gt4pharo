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
	| filter scripter |
	
	filter := self filterOnDummyExamplesPackages & #gtExample gtPragmas.
	scripter := self 
		scripter: (self scripter
			extent: 1200@800) 
		withModel: [filter] 
		element: [ GtPager 
			createWrappedOn: filter gtDefaultInspectorTool asElement ].
		
	scripter inspectorStep
		// (GtPagerPageElementId indexed: 1);
		clickOnTabWithName: 'By Method';
		play.
		
	scripter
		doubleClickStep: [ :s | 
			s
				//GtPhlowColumnedListId;
				id: #scrollable;
				onChildAt: 1
				"modifiers: BlKeyModifiers primary" ].
	scripter
		clickStep: [ :s | 
			s
				//GtPhlowColumnedListId;
				id: #scrollable;
				onChildAt: 2;
				modifiers: BlKeyModifiers primary ].
				
	scripter pager
		assertPageCountIs: 2;
		play.
		
	scripter inspectorStep
		// (GtPagerPageElementId indexed: 2);
		assertSelectedTabWithName: 'Comparison';
		play.
	
	^ scripter
]

{ #category : #'as yet unclassified' }
GtPharoMethodSearchFilterGroupingExample >> methodsFilter_byMethodView_selectSingleMethod [
	<gtExample>
	| filter scripter |
	
	filter := self filterOnDummyExamplesPackages & #gtExample gtPragmas.
	scripter := self 
		scripter: (self scripter
			extent: 1200@800) 
		withModel: [filter] 
		element: [ GtPager 
			createWrappedOn: filter gtDefaultInspectorTool asElement ].
		
	scripter inspectorStep
		// (GtPagerPageElementId indexed: 1);
		clickOnTabWithName: 'By Method';
		play.
		
	scripter
		doubleClickStep: [ :s | 
			s
				//GtPhlowColumnedListId;
				id: #scrollable;
				onChildAt: 1
				"modifiers: BlKeyModifiers primary" ].
	scripter pager
		assertPageCountIs: 2;
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
