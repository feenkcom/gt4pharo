Class {
	#name : #GtSourceCoderEditorElementByScripterExamples,
	#superclass : #GtCoderByScripterExamples,
	#category : #'GToolkit-Pharo-Coder-Examples'
}

{ #category : #'example - play example' }
GtSourceCoderEditorElementByScripterExamples >> foldNoiseText [
	<gtExample>
	| aScripter |
	aScripter := self scripterWithElementContainingInstrumentation.

	aScripter
		substep: 'Fold noise'
		do: [ :aStep | 
			aStep
				assertStep: [ :s | 
					s
						label: 'Count lines before folding';
						value: [ :editor | editor children size ] equals: 6 ].
			aStep
				shortcutStep: [ :s | 
					s
						label: 'Fold noise';
						combination: BlKeyCombinationBuilder new primary shift n build ].
			aStep
				assertStep: [ :s | 
					s
						label: 'Count lines after folding';
						value: [ :editor | editor children size ] equals: 4 ].
			aStep
				shortcutStep: [ :s | 
					s
						label: 'Unfold noise';
						combination: BlKeyCombinationBuilder new primary shift n build ].
			aStep
				assertStep: [ :s | 
					s
						label: 'Count lines before folding';
						value: [ :editor | editor children size ] equals: 6 ] ].

	^ aScripter
]

{ #category : #'example - play example' }
GtSourceCoderEditorElementByScripterExamples >> playExample [
	<gtExample>
	| aScripter |
	aScripter := self scripterWithElement.

	aScripter
		substep: 'Play example'
		do: [ :aStep | 
			aStep doStep: [ :s | 
				s 
					label: 'Remove example result cache';
					block: [ :aUIModel | aUIModel coder compiledMethod clearExampleAndTestCaches ];
					onModel
			].
		
			aStep
				assertStep: [ :s | 
					s
						label: 'Assert gray example status';
						value: [ :aStateElement | aStateElement background paint color ]
							equals: GtFilterExampleNotExecutedState default color;
						onBreadthFirstChildOfClass: GtCoderExampleStateElement ].

			aStep
				doStep: [ :s | 
					s
						label: 'Play button from model';
						block: [ :aUIModel | aUIModel coder playExample ];
						onModel ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert green example status';
						value: [ :aStateElement | aStateElement background paint color ]
							equals: GtFilterExampleSuccessState default color;
						onBreadthFirstChildOfClass: GtCoderExampleStateElement ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert green example status after all actions (styling)';
						value: [ :aStateElement | aStateElement background paint color ]
							equals: GtFilterExampleSuccessState default color;
						onBreadthFirstChildOfClass: GtCoderExampleStateElement ] ].

	^ aScripter
]

{ #category : #'example - instance creation' }
GtSourceCoderEditorElementByScripterExamples >> scripterWithElement [
	<gtExample>
	| aScripter |

	aScripter := self scripter.
	aScripter substep: 'Initialize Coder Model and UI' do: [ :aStep | 		
		aStep set
			label: 'Initialize Coder Editor UI';
			element: [ GtSourceCoderEditorElementExamples new editorForExampleMethodCoder ];
			onSelf;
			play.

		aStep set
			label: 'Initialize Coder UI Model';
			model: [ :anElement | anElement textualCoderViewModel ];
			onSelf;
			play ].

	^ aScripter
]

{ #category : #'example - instance creation' }
GtSourceCoderEditorElementByScripterExamples >> scripterWithElementContainingInstrumentation [
	<gtExample>
	| aScripter |

	aScripter := self scripter.
	aScripter substep: 'Initialize Coder Model and UI' do: [ :aStep | 		
		aStep set
			label: 'Initialize Coder Editor UI';
			element: [ GtSourceCoderEditorElementExamples new editorForInstrumentedMethodCoder ];
			onSelf;
			play.

		aStep set
			label: 'Initialize Coder UI Model';
			model: [ :anElement | anElement textualCoderViewModel ];
			onSelf;
			play ].

	^ aScripter
]

{ #category : #'example - play example' }
GtSourceCoderEditorElementByScripterExamples >> unfoldNoiseTextOnSourceModified [
	<gtExample>
	| aScripter |
	aScripter := self scripterWithElementContainingInstrumentation.

	aScripter
		substep: 'Unfold noise on modify'
		do: [ :aStep | 
			aStep
				assertStep: [ :s | 
					s
						label: 'Count lines before folding';
						value: [ :editor | editor children size ] equals: 6 ].
			aStep
				shortcutStep: [ :s | 
					s
						label: 'Fold noise';
						combination: BlKeyCombinationBuilder new primary shift n build ].
			aStep
				clickStep: [ :s | 
					s
						label: 'Focus editor';
						onChildAt: 4 ].
			aStep
				doStep: [ :s | 
					s
						label: 'Move to end of editor';
						block: [ :e | e navigator moveToEnd ] ].
			aStep
				typeStep: [ :s | 
					s
						label: 'Modify text';
						text: '"Comment"' ].
			aStep
				assertStep: [ :s | 
					s
						label: 'Count lines after modification unfolding';
						value: [ :editor | editor children size ] equals: 6 ] ].

	^ aScripter
]
