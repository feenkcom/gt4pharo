"
I contain executable examples for {{gtClass:GtMethodDefinitionPhlowTool}}.
"
Class {
	#name : #GtMethodDefinitionPhlowToolExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Method-Examples-Scripter'
}

{ #category : #examples }
GtMethodDefinitionPhlowToolExamples >> createToolElementInScripter [
	<gtExample>
	| phlowTool anElement aScripter |
	
	phlowTool := self phlowTool.
	anElement := phlowTool asElement.
	
	aScripter := BlScripter new.
	aScripter
		model: phlowTool;
		element: anElement.
	
	self assert: anElement class equals: GtPhlowMultipleViewsContentElement.
	
	aScripter multipleViewsToolStep
		label: 'Check phlow tool object';
		assertToolObjectOfType: RGMethodDefinition;
		assertToolObjectValueFor: [ :aMethodDefinition | aMethodDefinition selector ] 
			equals: [ #exampleMethodDefinitionTarget ];
		assertToolObjectValueFor: [ :aMethodDefinition | aMethodDefinition className ] 
			equals: [ #GtMethodDefinitionPhlowToolExamples ];
		assertToolObjectSatisfies: [ :aMethodDefinition | aMethodDefinition isClassSide not]
			description: 'Method definition is for GtMethodDefinitionPhlowToolExamples instance side';
		play.
		
	^ aScripter
]

{ #category : #'example support' }
GtMethodDefinitionPhlowToolExamples >> exampleMethodDefinitionTarget [
	^ 42
]

{ #category : #examples }
GtMethodDefinitionPhlowToolExamples >> methodDefinition [
	<gtExample>
	| aMethodDefinition |
	
	aMethodDefinition := (self class >> #exampleMethodDefinitionTarget) asRingDefinition.
	
	self assert: aMethodDefinition class equals: RGMethodDefinition.
	self assert: aMethodDefinition selector equals: #exampleMethodDefinitionTarget.
	self assert: aMethodDefinition className equals: #GtMethodDefinitionPhlowToolExamples.
	self assert: aMethodDefinition isClassSide not.
	
	^ aMethodDefinition
]

{ #category : #examples }
GtMethodDefinitionPhlowToolExamples >> pageToolWithSnippetWithMethodDefinitionCreation [
	<gtExample>
	| page pageTool |
	
	page := LePage new
		addSnippet: (LePharoSnippet code: 'GtMethodDefinitionPhlowToolExamples new methodDefinition');
		yourself.
	
	pageTool := LePagePhlowTool new
		page: page.
				
	^ pageTool
]

{ #category : #examples }
GtMethodDefinitionPhlowToolExamples >> phlowTool [
	<gtExample>
	| aTool |
	
	aTool := GtMethodDefinitionPhlowTool forMethodDefinition: self methodDefinition.
	
	self assert: aTool methodDefinition notNil.
	self assert: aTool object == aTool methodDefinition.
	self assert: aTool name equals: 'Method'.
	self assert: aTool icon notNil.
	
	^ aTool
]

{ #category : #examples }
GtMethodDefinitionPhlowToolExamples >> standaloneToolElementHasPlayground [
	<gtExample>
	| scripter |
	
	scripter := self createToolElementInScripter.
	
	scripter multipleViewsToolStep
		label: 'Check playground element is present';
		assertPlaygroundElementIsPresent;
		play.
			
	^ scripter
]

{ #category : #examples }
GtMethodDefinitionPhlowToolExamples >> standaloneToolElementHasTitleLabel [
	<gtExample>
	| scripter expectedText |
	
	expectedText := self methodDefinition printString.
	scripter := self createToolElementInScripter.
	
	self assert: scripter element titleLabel text asString equals: expectedText.
	
	scripter multipleViewsToolStep
		label: 'Check tool title label';
		assertToolTitle: expectedText;
		play.
			
	^ scripter
]

{ #category : #examples }
GtMethodDefinitionPhlowToolExamples >> standaloneToolElementHasToolLabel [
	<gtExample>
	| expectedText scripter |
	expectedText := 'Method'.
	
	scripter := self createToolElementInScripter.
	self assert: scripter element toolLabel text asString equals: expectedText.
	
	scripter multipleViewsToolStep
		label: 'Check tool label';
		assertToolLabel: expectedText;
		play.
			
	^ scripter
]

{ #category : #examples }
GtMethodDefinitionPhlowToolExamples >> standaloneToolElementShowsActions [
	<gtExample>
	| scripter |
	
	scripter := self createToolElementInScripter.
	
	scripter multipleViewsToolStep
		label: 'Check tool actions';
		assertHasToolActionWithId: GtInspectorDropdownButtonId ;
		play.
			
	^ scripter
]

{ #category : #examples }
GtMethodDefinitionPhlowToolExamples >> standaloneToolElementShowsKeyTabs [
	<gtExample>
	| scripter requiredLabels |
	
	requiredLabels := #('Source' 'Implementors' 'References' 'Method coders' 'AST').
	scripter := self createToolElementInScripter.
	
	scripter multipleViewsToolStep
		label: 'Check selected key tool tabs';
		assertHasTabsWithNames: requiredLabels;
		assertHasNoTabWithName: 'Raw';
		assertHasNoTabWithName: 'Meta';
		assertSelectedTabWithName: 'Source';
		play.
		
	^ scripter
]

{ #category : #examples }
GtMethodDefinitionPhlowToolExamples >> worldTabWithInitialSnippetWithMethodDefinition [
	<gtExample>
	<return: #BlScripter>
	| scripter pageTool |
	
	pageTool := self pageToolWithSnippetWithMethodDefinitionCreation.

	scripter := BlScripter new.
	scripter element: GtWorldElement new.
	scripter model: pageTool.

	scripter worldStep
		label: 'Open page in new tab';
		showInNewTabObject: pageTool;
		assertTabAtIndex: 2 hasLabel: 'Page';
		play.

	^ scripter
]

{ #category : #examples }
GtMethodDefinitionPhlowToolExamples >> worldTabWithPaneWithTool [
	<gtExample>
	<return: #BlScripter>
	| scripter |

	scripter := self worldTabWithInitialSnippetWithMethodDefinition.

	scripter click
		label: 'Click on do it and inspect button';
		// GtSourceCoderDoItAndGoActionId;
		play.
		
	scripter multipleViewsToolStep
		label: 'Check phlow tool object';
		onPagerPaneWithIndex: 2;
		onMultipleViewsToolElement;
		assertToolObjectOfType: RGMethodDefinition;
		assertToolObjectValueFor: [ :aMethodDefinition | aMethodDefinition selector ] 
			equals: [ #exampleMethodDefinitionTarget ];
		assertToolObjectValueFor: [ :aMethodDefinition | aMethodDefinition className ] 
			equals: [ #GtMethodDefinitionPhlowToolExamples ];
		assertToolObjectSatisfies: [ :aMethodDefinition | aMethodDefinition isClassSide not]
			description: 'Method definition is for GtMethodDefinitionPhlowToolExamples instance side';
		play.
		
	scripter worldStep
		label: 'World tab title is still Page after spawning a new pane';
		assertTabAtIndex: 2 hasLabel: 'Page';
		play.

	scripter phlowCompositeToolStep
		label: 'Second pane has the expected tool';
		onPagerPaneWithIndex: 2;
		assertPhlowToolTabsCount: 2;
		assertPhlowToolLabels: {'Method' . 'inspector'}
			andTypes: {GtMethodDefinitionPhlowTool . GtInspectorTool};
		assertSelectedToolAtIndex: 1 withTabName: 'Method';
		play.

	^ scripter
]

{ #category : #examples }
GtMethodDefinitionPhlowToolExamples >> worldTabWithPaneWithTool_selectInspectorSourceView [
	<gtExample>
	<return: #BlScripter>
	| scripter |

	scripter := self worldTabWithPaneWithTool.

	scripter phlowCompositeToolStep
		label: 'Select inspector tool';
		onPagerPaneWithIndex: 2;
		clickOnToolAtIndex: 2;
		assertSelectedToolAtIndex: 2 withPhlowName: 'inspector';
		play.
		
	"This should be fixed"
	scripter worldStep
		label: 'After selecting the inspector tool the tab label is still the same';
		assertTabAtIndex: 2 hasLabel: 'Page';
		play.

	scripter inspectorStep
		label: 'Select the Source view in the inspector tool';
		onPagerPaneWithIndex: 2;
		clickOnTabWithName: 'Source';
		assertSelectedTabWithName: 'Source';
		play.

	scripter click
		label: 'Select editor in the source view';
		onPagerPaneWithIndex: 2;
		// GtSourceCoderEditorInnerId;
		play.

	scripter worldStep
		label: 'World tab title changed after selecting a row in the raw view';
		assertTabAtIndex: 2 hasLabel: 'a RGMethodDe...nitionTarget)';
		play.

	^ scripter
]

{ #category : #examples }
GtMethodDefinitionPhlowToolExamples >> worldTabWithPaneWithTool_selectInspectorSourceView_backToPage [
	<gtExample>
	<return: #BlScripter>
	| scripter |

	scripter := self worldTabWithPaneWithTool_selectInspectorSourceView.

	scripter click
		label: 'Click editor in first pane';
		onPagerPaneWithIndex: 1;
		// GtSourceCoderEditorInnerId;
		play.

	scripter worldStep
		label: 'World tab title is Page again';
		assertTabAtIndex: 2 hasLabel: 'Page';
		play.

	^ scripter
]

{ #category : #examples }
GtMethodDefinitionPhlowToolExamples >> worldTabWithPaneWithTool_selectToolSourceView [
	<gtExample>
	<return: #BlScripter>
	| scripter |

	scripter := self worldTabWithPaneWithTool.

	scripter multipleViewsToolStep
		label: 'Select the Source view in the second pane';
		onPagerPaneWithIndex: 2;
		clickOnTabWithName: 'Source';
		assertSelectedTabWithName: 'Source';
		play.

	scripter click
		label: 'Select editor in the source view';
		onPagerPaneWithIndex: 2;
		// GtSourceCoderEditorInnerId;
		play.

	scripter worldStep
		label: 'World tab title changed after selecting self';
		assertTabAtIndex: 2 hasLabel: 'GtMethodDefi...initionTarget';
		play.

	^ scripter
]

{ #category : #examples }
GtMethodDefinitionPhlowToolExamples >> worldTabWithPaneWithTool_selectToolSourceView_backToPage [
	<gtExample>
	<return: #BlScripter>
	| scripter |

	scripter := self worldTabWithPaneWithTool_selectToolSourceView.

	scripter multipleViewsToolStep
		label: 'Select the Source view in the second pane';
		onPagerPaneWithIndex: 2;
		clickOnTabWithName: 'Source';
		assertSelectedTabWithName: 'Source';
		play.

	scripter click
		label: 'Click editor in first pane';
		onPagerPaneWithIndex: 1;
		// GtSourceCoderEditorInnerId;
		play.

	scripter worldStep
		label: 'World tab title is Page again';
		assertTabAtIndex: 2 hasLabel: 'Page';
		play.

	^ scripter
]
