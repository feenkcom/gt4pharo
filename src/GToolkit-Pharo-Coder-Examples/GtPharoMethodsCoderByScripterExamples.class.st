Class {
	#name : #GtPharoMethodsCoderByScripterExamples,
	#superclass : #Object,
	#traits : 'TCoderByScripterExamples',
	#classTraits : 'TCoderByScripterExamples classTrait',
	#instVars : [
		'behaviorExamples'
	],
	#category : #'GToolkit-Pharo-Coder-Examples-Coders'
}

{ #category : #examples }
GtPharoMethodsCoderByScripterExamples >> classGtMethodsForInTreePager_clickMethodHeaderClassName_addsPaneForActualMethod [
	<gtExample>
	<return: #BlScripter>
	| aScripter aPager expectedMethod anInspectorTool |
	expectedMethod := (Class methods sorted: GtMethodsSortFunction new) first.
	anInspectorTool := GtInspectorTool new object: Class.
	
	aPager := GtPagerSettings usedPager createWrappedOn: anInspectorTool.
	
	aScripter := BlScripter new
		model: aPager;
		element: aPager asElement.
	
	aScripter inspectorStep
		clickOnTabWithName: 'Methods';
		assertSelectedTabWithName: 'Methods';
		play.
	
	aScripter treePager
		assertNumberOfPaneElements: 1;
		assertNumberOfVisiblePanes: 1;
		play.
	
	aScripter clickStep: [ :s |
		s
			label: 'Click class name in method header';
			id: GtPharoHeaderProviderBehaviorId;
			onChildAt: 1 ].
	
	aScripter treePager
		assertNumberOfPaneElements: 2;
		assertNumberOfVisiblePanes: 2;
		play.
	
	aScripter assertStep: [ :s |
		s
			label: 'Assert spawn event contained method coder tool';
			satisfies: [ :theScripter |
				theScripter events reversed
					detectEventOfClass: GtPhlowObjectToSpawn
					ifFound: [ :theEvent |
						(theEvent object == expectedMethod) and: [ theEvent tool isKindOf: GtMethodCoderTool ] ]
					ifNone: [ false ] ];
			onScripter ].
	
	aScripter checkStep: [ :s |
		s
			label: 'Check second pane has coder tool container';
			exists;
			// GtCoderElement.
	].
	
	aScripter checkStep: [ :s |
		s
			label: 'Check second pane shows Class';
			exists;
			// GtBehaviorCoderBehaviorNameId;
			@ [ :each | each text asString = 'Class' ] ].
	
	^ aScripter
]

{ #category : #accessing }
GtPharoMethodsCoderByScripterExamples >> cleanUp [
  behaviorExamples cleanUp.
]

{ #category : #'examples - scripter' }
GtPharoMethodsCoderByScripterExamples >> implementersMenuWhenCollapsed [
	<gtExample>
	| scripter |
	scripter := self
			scripterInPagerForBlock: [ GtCoderElement forClass: self class ].
	scripter
		doStep: [ :s | 
			s
				label: 'Set space extent';
				block: [ :aSpace | aSpace extent: 1000 @ 1000 ];
				onSpace ].
	scripter
		secondaryClickStep: [ :s | 
			s
				// GtExpandableSourceCoderElement;
				// BlAttributedTextElement;
				@ [ :each | each text asString = 'referencesMenuWhenCollapsed' ] ].
	scripter
		clickStep: [ :s | 
			s
				onSpaceRoot;
				// #'context-menu--implementers' ].
	scripter
		assertStep: [ :s | 
			s
				onPagerPaneWithIndex: 2;
				satisfies: [ :element | 
					element
						allChildrenBreadthFirstDetect: [ :child | child class == GtPhlowSearchFilterToolElement ]
						ifFound: [ :child | true ]
						ifNone: [ false ] ] ].
	^ scripter
]

{ #category : #accessing }
GtPharoMethodsCoderByScripterExamples >> methodsCoder [
	<gtExample>
	behaviorExamples ifNil: [ 
		behaviorExamples := GtBehaviorCoderByScripterExamples new ].

	^ behaviorExamples classCoderForClassUI
]

{ #category : #accessing }
GtPharoMethodsCoderByScripterExamples >> methodsCoderWithFilledFilter_click_add_method [
	<gtExample>
	| aScripter |
	aScripter := self methodsCoder.

	aScripter
		clickStep: [ :s | 
			s
				label: 'Click add method button';
				id: GtPharoAddNewMethodButtonId ].

	^ aScripter
]

{ #category : #'examples - scripter' }
GtPharoMethodsCoderByScripterExamples >> referencesMenuWhenCollapsed [
	<gtExample>
	| scripter |
	scripter := self
			scripterInPagerForBlock: [ GtCoderElement forClass: self class ].
	scripter
		doStep: [ :s | 
			s
				label: 'Set space extent';
				block: [ :aSpace | aSpace extent: 1000 @ 1000 ];
				onSpace ].
	scripter
		secondaryClickStep: [ :s | 
			s
				// GtExpandableSourceCoderElement;
				// BlAttributedTextElement;
				@ [ :each | each text asString = #referencesMenuWhenCollapsed ] ].
	scripter
		clickStep: [ :s | 
			s
				onSpaceRoot;
				// #'context-menu--references' ].
	scripter
		assertStep: [ :s | 
			s
				onPagerPaneWithIndex: 2;
				satisfies: [ :element | 
					element
						allChildrenBreadthFirstDetect: [ :child | child class == GtPhlowSearchFilterToolElement ]
						ifFound: [ :child | true ]
						ifNone: [ false ] ] ].
	^ scripter
]
