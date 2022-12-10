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

{ #category : #accessing }
GtPharoCoderByScripterExamples >> coderInPager [
	<gtExample>
	^ self
		scripterForBlock: [ GtPager createWrappedOn: (GtCoder forClass: GtPharoDummyClass) ]
]

{ #category : #accessing }
GtPharoCoderByScripterExamples >> coderInPager_clickOnHierarchiesButton [
	<gtExample>
	<noTest>
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

{ #category : #accessing }
GtPharoCoderByScripterExamples >> coder_clickOnHierarchiesButton [
	<gtExample>
	<noTest>
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
