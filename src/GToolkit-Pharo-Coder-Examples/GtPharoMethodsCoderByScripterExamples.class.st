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

	aScripter substep: 'Enter into Edit Mode' do: [ :aStep | 
		aStep doubleClick
			id: #filter;
			onChildOfClass: GtFilterTagElement;
			id: #editableLabel;
			play ].

	^ aScripter
]

{ #category : #accessing }
GtPharoMethodsCoderByScripterExamples >> methodsCoderWithFilledFilter_click_add_method [
	<gtExample>
	| aScripter |

	aScripter := self methodsCoderWithFilledFilter_insert_text.

	aScripter substep: 'Add new method' do: [ :aStep | 
		aStep click
			label: 'Click add method button';
			id: GtPharoBehaviorCoder addNewMethodButtonName;
			play ].

	^ aScripter
]

{ #category : #accessing }
GtPharoMethodsCoderByScripterExamples >> methodsCoderWithFilledFilter_insert_text [
	<gtExample>
	| aScripter |

	aScripter := self methodsCoderWithFilledFilter.

	aScripter substep: 'Insert new text' do: [ :aStep | 
		aStep type
			text: 'foo';
			id: #filter;
			onChildOfClass: GtFilterTagElement;
			id: #editableLabel;
			play ].

	^ aScripter
]
