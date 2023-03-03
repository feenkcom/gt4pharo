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

{ #category : #'examples - coder' }
GtPharoCoderByScripterExamples >> coder [
	<gtExample>
	^ self scripterForBlock: [ GtCoder forClass: GtPharoDummyClass ]
]

{ #category : #'examples - scripter' }
GtPharoCoderByScripterExamples >> coderInPager [
	<gtExample>
	^ self coderInPager: [ GtCoder forClass: GtPharoDummyClass ]
]

{ #category : #'examples - support' }
GtPharoCoderByScripterExamples >> coderInPager: aCoderOrBlock [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterForBlock: [ GtPager createWrappedOn: aCoderOrBlock value ].

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

{ #category : #'examples - coder' }
GtPharoCoderByScripterExamples >> coderWithAddMethod [
	<gtExample>
	^ self coderInPager: [ GtCoder forMethod: GtPharoDummyClass >> #addDummyClassMethods: ]
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

{ #category : #'examples - context menu' }
GtPharoCoderByScripterExamples >> displayPharoMethodContextMenuToTheRight [
	<gtExample>
	| aScripter |
	aScripter := self coderWithAddMethod.

	aScripter click
		label: 'Maximize Coder';
		// GtPagerMaximizeButtonElementId;
		play.

	aScripter secondaryClick
		label: 'Display context menu';
		onSpaceRoot;
		// GtPharoStreamingMethodsCoderElement;
		// (GtSourceCoderId indexed: 1);
		// GtSourceCoderEditorId;
		onChildAt: 1;
		play.

	aScripter assert
		label: 'Assert context menu width';
		value: [ :aContentElement | aContentElement width ]
			equals: [ :aContentElement | 
				| aContextMenuQuery |
				aContextMenuQuery := aContentElement query // GtCoderContextMenuContent.
				self assert: aContextMenuQuery result size equals: 1.
				aContextMenuQuery result first width ];
		onSpaceRoot;
		// BrAnchoredOuterContainer;
		// BrAnchoredElement;
		/ #content asBlocElementId;
		play.

	^ aScripter
]
