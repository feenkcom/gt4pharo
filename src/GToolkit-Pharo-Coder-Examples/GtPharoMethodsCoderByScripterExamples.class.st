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

{ #category : #accessing }
GtPharoMethodsCoderByScripterExamples >> methodsCoder [
	<gtExample>
	behaviorExamples ifNil: [ 
		behaviorExamples := GtBehaviorCoderByScripterExamples new ].

	^ behaviorExamples classCoderForClassUI
]

{ #category : #accessing }
GtPharoMethodsCoderByScripterExamples >> methodsCoderWithFilledFilter [
	<gtExample>
	| aScripter |

	aScripter := self methodsCoder.
	aScripter click
		label: 'Enter into Edit Mode';
		id: GtFilterTagEditorId index: 1;
		play.
	
	^ aScripter
]

{ #category : #accessing }
GtPharoMethodsCoderByScripterExamples >> methodsCoderWithFilledFilter_click_add_method [
	<gtExample>
	| aScripter |

	aScripter := self methodsCoderWithFilledFilter_insert_text.

	aScripter click
		label: 'Click add method button';
		id: GtPharoAddNewMethodButtonId;
		play.

	^ aScripter
]

{ #category : #accessing }
GtPharoMethodsCoderByScripterExamples >> methodsCoderWithFilledFilter_insert_text [
	<gtExample>
	| aScripter |

	aScripter := self methodsCoderWithFilledFilter.

	aScripter type
		label: 'Insert new text';
		text: 'foo';
		id: GtFilterTagEditorId index: 1;
		play.

	^ aScripter
]
