Class {
	#name : #GtPharoBigMethodCoderExamples,
	#superclass : #Object,
	#traits : 'TCoderByScripterExamples',
	#classTraits : 'TCoderByScripterExamples classTrait',
	#category : #'GToolkit-Pharo-Coder-BigMethods-Examples'
}

{ #category : #examples }
GtPharoBigMethodCoderExamples >> checkActionsPresentForBigMethodCoder [
	<gtExample>
	| scripter |
	scripter := self
			scripterInPagerForBlock: [ GtCoderElement forClass: GtBigMethodTestClass ].
	scripter
		doStep: [ :s | 
			s
				label: 'Set space extent';
				block: [ :aSpace | aSpace extent: 2400 @ 1000 ];
				onSpace ];
		clickStep: [ :s | 
			s
				label: 'Expand Big Method';
				// GtExpandableSourceCoderElement;
				// BlAttributedTextElement;
				@ [ :each | each text asString = 'reduceTable' ] ];
		assertStep: [ :s | 
			s
				label: 'Check for main actions';
				// GtExpandableSourceCoderElement;
				@ [ :each | each isExpanded ];
				// GtSourceCoderActionsElement;
				// 'Main toolbar';
				satisfies: [ :coder | coder childrenCount = 3 ] ].
	^ scripter
]

{ #category : #examples }
GtPharoBigMethodCoderExamples >> checkInspectActionForBigMethodCoder [
	<gtExample>
	| scripter |
	scripter := self checkActionsPresentForBigMethodCoder.
	scripter
		clickStep: [ :s | 
			s
				label: 'Inspect Big Method';
				// GtMethodCoderInspectActionId ].
	scripter
		assertStep: [ :s | 
			s
				// (GtPagerPageElementId indexed: 2);
				satisfies: [ :element | 
					element
						allChildrenBreadthFirstDetect: [ :child | child class == GtSourceCoderEditorElement ]
						ifFound: [:child | false ]
						ifNone: [ true ] ] ].
	^ scripter
]

{ #category : #examples }
GtPharoBigMethodCoderExamples >> coderOnExampleMethodWithSelfLargeMethodCall [
	<gtExample>
	| scripter |
	scripter := self
			scripterForBlock: [ 
				GtPharoMethodCoder forMethod: GtBigMethodTestClass>>#exampleWithCallToMethodWithBigCoder ].
	scripter methodCoder
		assertCompiledMethodIs: GtBigMethodTestClass>>#exampleWithCallToMethodWithBigCoder;
		assertMethodExpandersCountIs: 1;
		clickOnMethodCoderExpander: 1
			insideDo: [ :aStep | 
				aStep
					assertCompiledMethodIs: GtBigMethodTestClass>>#reduceTable;
					assertSelfObjectIs: nil;
					assertExplicitProviderClassIs: GtBigMethodTestClass;
					assertHeaderProviderBehaviorIs: GtBigMethodTestClass;
					assertMethodExpandersCountIs: 0;
					coderViewModelDo: [ :aCoderViewModel | 
						self assert: aCoderViewModel parentCoderViewModel notNil .
						self 
							assert: aCoderViewModel parentExample
							equals: (GtBigMethodTestClass>>#exampleWithCallToMethodWithBigCoder ) gtExampleWithResult.
						self assert: aCoderViewModel parentTestCase isNil ] ];
		play.
	scripter assert
		// GtPharoBigMethodExpandedSourceCoderElement;
		exists.
	^ scripter
]

{ #category : #examples }
GtPharoBigMethodCoderExamples >> coderOnMethodWithSelfLargeMethodCall [
	<gtExample>
	| scripter |
	scripter := self
			scripterForBlock: [ 
				GtPharoMethodCoder forMethod: GtBigMethodTestClass>>#callToMethodWithBigCoder ].
	
	scripter methodCoder
		assertCompiledMethodIs: GtBigMethodTestClass>>#callToMethodWithBigCoder;
		assertMethodExpandersCountIs: 1;
		clickOnMethodCoderExpander: 1
			insideDo: [ :aStep | 
				aStep
					assertCompiledMethodIs: GtBigMethodTestClass>>#reduceTable;
					assertSelfObjectIs: nil;
					assertExplicitProviderClassIs: GtBigMethodTestClass;
					assertHeaderProviderBehaviorIs: GtBigMethodTestClass;
					assertMethodExpandersCountIs: 0;
					coderViewModelDo: [ :aCoderViewModel | 
						self assert: aCoderViewModel parentCoderViewModel notNil .
						self assert: aCoderViewModel parentExample isNil.
						self assert: aCoderViewModel parentTestCase isNil ] ];
		play.
		
	scripter assert
		// GtPharoBigMethodExpandedSourceCoderElement;
		exists.
	
	^ scripter
]

{ #category : #examples }
GtPharoBigMethodCoderExamples >> forClassWithBigMethod [
	<gtExample>
	| aMethodsCoder theMethodCoders |
	aMethodsCoder := GtPharoStreamingMethodsCoder forBehavior: GtBigMethodTestClass.
	self
		assert: aMethodsCoder itemsStream toArray wait
		equals: {
			GtBigMethodTestClass>>#callToMethodWithBigCoder.
			GtBigMethodTestClass>>#exampleWithCallToMethodWithBigCoder.
			GtBigMethodTestClass >> #reduceTable.
			GtBigMethodTestClass >> #testMethod1.
			GtBigMethodTestClass >> #testMethod2}.

	theMethodCoders := aMethodsCoder codersStream toArray wait.
	self assert: theMethodCoders size equals: 5.
	self
		assert: theMethodCoders first class
		equals: GtPharoMethodCoder.
	self assert: theMethodCoders first selector equals: #callToMethodWithBigCoder.
	self
		assert: theMethodCoders second class
		equals: GtPharoMethodCoder.
	self assert: theMethodCoders second selector equals: #exampleWithCallToMethodWithBigCoder.
	self
		assert: theMethodCoders third class
		equals: GtPharoBigMethodCoder.
	self assert: theMethodCoders third selector equals: #reduceTable.
	self
		assert: theMethodCoders fourth class
		equals: GtPharoMethodCoder.
	self assert: theMethodCoders fourth selector equals: #testMethod1.
	self
		assert: theMethodCoders fifth class
		equals: GtPharoMethodCoder.
	self assert: theMethodCoders fifth selector equals: #testMethod2.
	^ aMethodsCoder
]

{ #category : #examples }
GtPharoBigMethodCoderExamples >> forClassWithUnsearchableMethod [
	<gtExample>
	| aMethodsCoder theMethodCoders aCompiledMethod aClass |
	"Create a method which is unsearchable"
	aClass := GtBigMethodTestClass copy.
	aClass compileAllFrom: GtBigMethodTestClass.
	aMethodsCoder := GtPharoStreamingMethodsCoder forBehavior: aClass.
	aCompiledMethod := aClass >> #reduceTable infect: 'isSourceSearchable ^false'.
	
	self
		assert: aMethodsCoder itemsStream toArray wait
		equals: {
				aClass>>#callToMethodWithBigCoder.
				aClass>>#exampleWithCallToMethodWithBigCoder.
				aClass >> #reduceTable.
				aClass >> #testMethod1.
				aClass >> #testMethod2}.

	theMethodCoders := aMethodsCoder codersStream toArray wait.
	self assert: theMethodCoders size equals: 5.
	
	self assert: theMethodCoders third class equals: GtPharoBigMethodCoder.
	self assert: theMethodCoders third selector equals: #reduceTable.
	self assert: theMethodCoders fourth class equals: GtPharoMethodCoder.
	self assert: theMethodCoders fourth selector equals: #testMethod1.
	self assert: theMethodCoders fifth class equals: GtPharoMethodCoder.
	self assert: theMethodCoders fifth selector equals: #testMethod2.
	^ aMethodsCoder
]
