Class {
	#name : #GtPharoMethodCoderViewModelExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Examples-Coder - Method'
}

{ #category : #'examples - instance creation' }
GtPharoMethodCoderViewModelExamples >> forUnaryInstanceMethod [
	<gtExample>
	| aViewModel |
	
	aViewModel := (GtPharoMethodCoderExamples new forUnaryInstanceMethod) asCoderViewModel.

	self assert: aViewModel elementClass equals: GtExpandableMethodCoderForBehaviorElement.
	self assert: aViewModel headerElementClass equals: GtPharoMethodCoderHeaderElement.
	self assert: aViewModel protocol equals: 'accessing'.
	self assert: aViewModel selector equals: #unaryMethod.
	self assert: aViewModel isMeta not.
	self assert: aViewModel isFromTrait not.
	self assert: aViewModel isSaveEnabled.
	self assert: (aViewModel hasDeclaredVariableNamed: #variable) not.
	
	^ aViewModel
]

{ #category : #'examples - instance creation' }
GtPharoMethodCoderViewModelExamples >> unaryInstanceMethodPlayAll [
	<gtExample>
	| aViewModel failed |
	
	aViewModel := self forUnaryInstanceMethod.
	
	self assert: aViewModel receiverObjectToPlay equals: nil.
	
	failed := [ aViewModel playAll. false ]
		on: GtCoderEvaluationUnhandledError
		do: [ :anError | true ].
	
	self assert: failed.
	
	^ aViewModel
]
