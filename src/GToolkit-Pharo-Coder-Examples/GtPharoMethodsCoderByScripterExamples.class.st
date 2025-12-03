Class {
	#name : #GtPharoMethodsCoderByScripterExamples,
	#superclass : #Object,
	#traits : 'TCoderByScripterExamples',
	#classTraits : 'TCoderByScripterExamples classTrait',
	#instVars : [
		'behaviorExamples'
	],
	#category : 'GToolkit-Pharo-Coder-Examples-Coders'
}

{ #category : #accessing }
GtPharoMethodsCoderByScripterExamples >> cleanUp [
  behaviorExamples cleanUp.
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
