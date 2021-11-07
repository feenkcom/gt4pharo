Class {
	#name : #GtSourceCoderEditorElementByScripterExamples,
	#superclass : #GtCoderByScripterExamples,
	#category : #'GToolkit-Pharo-Coder-Examples'
}

{ #category : #'example - play example' }
GtSourceCoderEditorElementByScripterExamples >> playExample [
	<gtExample>
	| aScripter |

	aScripter := self scripterWithElement.
	
	aScripter substep: 'Play example' do: [ :aStep | 
		
		aStep check
			label: 'Check gray example status';
			value: [ :aStateElement | 
				aStateElement background paint color ]
			equals: GtFilterExampleNotExecutedState default color;
			onBreadthFirstChildOfClass: GtCoderExampleStateElement;
			play.
	
		aStep do
			label: 'Play button from model';
			block: [ :aUIModel | aUIModel coder playExample ];
			onModel;
			play.
		
		aStep check
			label: 'Check green example status';
			value: [ :aStateElement | 
				aStateElement background paint color ]
			equals: GtFilterExampleSuccessState default color;
			onBreadthFirstChildOfClass: GtCoderExampleStateElement;
			play.
			
		aStep check
			label: 'Check green example status after all actions (styling)';
			value: [ :aStateElement | 
				aStateElement background paint color ]
			equals: GtFilterExampleSuccessState default color;
			onBreadthFirstChildOfClass: GtCoderExampleStateElement;
			play  ].

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
