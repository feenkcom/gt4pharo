"
I exercise message visibility transitions of {{gtClass:GtRefactoringsMessagesElement}} with {{gtClass:BlScripter}}.
"
Class {
	#name : #GtRefactoringsMessagesElementExamples,
	#superclass : #Object,
	#traits : 'TBlDevScripterExamples',
	#classTraits : 'TBlDevScripterExamples classTrait',
	#category : #'GToolkit-Pharo-Coder-Examples-Refactorings'
}

{ #category : #'examples - messages' }
GtRefactoringsMessagesElementExamples >> computedResultWithoutMessagesHidesPreviousError [
	<gtExample>
	| scripter |
	scripter := self scripterWithElement: [ GtRefactoringsMessagesElement new ].

	scripter
		doStep: [ :step | 
			step
				label: 'Show previous error';
				block: [ :element | 
					(element childNamed: #refactoringMessagesContainer)
						addChild: (BrLabel new text: 'Previous error');
						visibility: BlVisibility visible ];
				onSpaceRoot;
				// GtRefactoringsMessagesElement ].

	scripter
		assertStep: [ :step | 
			step
				label: 'Previous error is visible';
				value: [ :element | element visibility ] equals: BlVisibility visible;
				onSpaceRoot;
				// #refactoringMessagesContainer ].

	scripter
		doStep: [ :step | 
			step
				label: 'Receive computed result without messages';
				block: [ :element | element updateAsComputedRefactorings: GtExecutedRefactorings new ];
				onSpaceRoot;
				// GtRefactoringsMessagesElement ].

	scripter
		assertStep: [ :step | 
			step
				label: 'Previous error is hidden';
				value: [ :element | element visibility ] equals: BlVisibility gone;
				onSpaceRoot;
				// #refactoringMessagesContainer ].

	^ scripter
]
