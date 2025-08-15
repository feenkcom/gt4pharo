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
				label: 'Check for actions';
				// GtExpandableSourceCoderElement;
				@ [ :each | each isExpanded ];
				// GtSourceCoderActionsElement;
				satisfies: [ :coder | coder childrenCount = 3 ] ].
	^ scripter
]

{ #category : #examples }
GtPharoBigMethodCoderExamples >> forClassWithBigMethod [
	<gtExample>
	| aMethodsCoder theMethodCoders |
	aMethodsCoder := GtPharoStreamingMethodsCoder forBehavior: GtBigMethodTestClass.
	self
		assert: aMethodsCoder itemsStream toArray wait
		equals: {GtBigMethodTestClass >> #reduceTable.
				GtBigMethodTestClass >> #testMethod1.
				GtBigMethodTestClass >> #testMethod2}.

	theMethodCoders := aMethodsCoder codersStream toArray wait.
	self assert: theMethodCoders size equals: 3.
	self
		assert: theMethodCoders first class
		equals: GtPharoBigMethodCoder.
	self assert: theMethodCoders first selector equals: #reduceTable.
	self
		assert: theMethodCoders second class
		equals: GtPharoMethodCoder.
	self assert: theMethodCoders second selector equals: #testMethod1.
	self
		assert: theMethodCoders third class
		equals: GtPharoMethodCoder.
	self assert: theMethodCoders third selector equals: #testMethod2.
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
		equals: {aClass >> #reduceTable.
				aClass >> #testMethod1.
				aClass >> #testMethod2}.

	theMethodCoders := aMethodsCoder codersStream toArray wait.
	self assert: theMethodCoders size equals: 3.
	self assert: theMethodCoders first class equals: GtPharoBigMethodCoder.
	self assert: theMethodCoders first selector equals: #reduceTable.
	self assert: theMethodCoders second class equals: GtPharoMethodCoder.
	self assert: theMethodCoders second selector equals: #testMethod1.
	self assert: theMethodCoders third class equals: GtPharoMethodCoder.
	self assert: theMethodCoders third selector equals: #testMethod2.
	^ aMethodsCoder
]
