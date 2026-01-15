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
