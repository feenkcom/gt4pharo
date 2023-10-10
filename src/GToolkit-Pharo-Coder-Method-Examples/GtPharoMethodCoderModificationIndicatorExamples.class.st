Class {
	#name : #GtPharoMethodCoderModificationIndicatorExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Method-Examples-Coder'
}

{ #category : #examples }
GtPharoMethodCoderModificationIndicatorExamples >> cleanMethodCoder [
	<gtExample>
	| aScripter |
	aScripter := BlScripter new element: self methodCoderElement.

	aScripter
		assertStep: [ :s | 
			s
				id: GtTextualCoderModificationIndicatorId;
				value: [ :anIndicator | anIndicator visibility ]
					equals: [ BlVisibility gone ] ].

	^ aScripter
]

{ #category : #examples }
GtPharoMethodCoderModificationIndicatorExamples >> dirtyMethodCoder [
	<gtExample>
	| aScripter |
	aScripter := self cleanMethodCoder.

	aScripter
		doStep: [ :s | 
			s
				onChildFromMessage: #textualCoderViewModel;
				action: [ :aViewModel | 
					aViewModel
						sourceText: 'modified' asRopedText
						from: aViewModel
						synchronously: true ] ].

	aScripter
		assertStep: [ :s | 
			s
				id: GtTextualCoderModificationIndicatorId;
				value: [ :anIndicator | anIndicator visibility ]
					equals: [ BlVisibility visible ] ].

	^ aScripter
]

{ #category : #examples }
GtPharoMethodCoderModificationIndicatorExamples >> methodCoderElement [
	<gtExample>
	| aCoder aViewModel |
	
	aCoder := GtPharoMethodCoder forMethod: GtPharoCoderMockedClass >> #instanceMethodC.
	aViewModel := aCoder asCoderViewModel
		expanded: true.

	^ GtExpandableMethodCoderElement new textualCoderViewModel: aViewModel
]
