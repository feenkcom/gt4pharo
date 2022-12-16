"
I exemplify {{gtClass:GtCoder}}. 
"
Class {
	#name : #GtPharoCoderByScripterExamples,
	#superclass : #Object,
	#traits : 'TCoderByScripterExamples',
	#classTraits : 'TCoderByScripterExamples classTrait',
	#category : #'GToolkit-Pharo-Coder-Examples-Coders'
}

{ #category : #accessing }
GtPharoCoderByScripterExamples >> coder [
	<gtExample>
	^ self scripterForBlock: [ GtCoder forClass: GtPharoDummyClass ]
]

{ #category : #'examples - scripter' }
GtPharoCoderByScripterExamples >> coderInPager [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterForBlock: [ GtPager createWrappedOn: (GtCoder forClass: GtPharoDummyClass) ].

	aScripter assert
		label: 'Assert one page';
		satisfies: [ :aPager | aPager pages size = 1 ];
		onSelf;
		play.

	^ aScripter
]

{ #category : #'examples - scripter' }
GtPharoCoderByScripterExamples >> coderInPager_clickOnCopyClassButton [
	<gtExample>
	| aScripter |
	aScripter := self coderInPager.

	aScripter
		substeps: 'Click on Copy Class'
		do: [ :aStep | 
			aStep click
				// GtPharoBehaviorCoderElement;
				// GtCoderToolbarElement;
				// GtPharoCopyClassElementId;
				play ].

	^ aScripter
]

{ #category : #'examples - scripter' }
GtPharoCoderByScripterExamples >> coderInPager_clickOnGitButton [
	<gtExample>
	| aScripter |
	aScripter := self coderInPager.

	aScripter
		substeps: 'Go to Git'
		do: [ :aStep | 
			aStep click
				// GtPharoBehaviorCoderElement;
				// GtCoderToolbarElement;
				// GtCoderGitButtonId;
				play.

			aStep assert
				label: 'Assert two pages';
				satisfies: [ :aPager | aPager pages size = 2 ];
				onSelf;
				play ].

	^ aScripter
]

{ #category : #'examples - scripter' }
GtPharoCoderByScripterExamples >> coderInPager_clickOnHierarchiesButton [
	<gtExample>
	| aScripter |
	aScripter := self coderInPager.

	aScripter
		substeps: 'Show Hierarchies'
		do: [ :aStep | 
			aStep click
				// GtPharoBehaviorCoderElement;
				// GtCoderToolbarElement;
				// GtCoderClassHierarchyButtonId;
				play ].

	^ aScripter
]

{ #category : #'examples - scripter' }
GtPharoCoderByScripterExamples >> coder_clickOnHierarchiesButton [
	<gtExample>
	| aScripter |
	aScripter := self coder.

	aScripter
		substeps: 'Show Hierarchies'
		do: [ :aStep | 
			aStep click
				// GtPharoBehaviorCoderElement;
				// GtCoderToolbarElement;
				// GtCoderClassHierarchyButtonId;
				play ].

	^ aScripter
]
