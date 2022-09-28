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
	
	aScripter assert
		id: GtTextualCoderModificationIndicatorId;
		value: [ :anIndicator | anIndicator visibility ] equals: [ BlVisibility gone ];
		play.

	^ aScripter
]

{ #category : #examples }
GtPharoMethodCoderModificationIndicatorExamples >> dirtyMethodCoder [
	<gtExample>
	| aScripter |
	
	aScripter := self cleanMethodCoder.
	
	aScripter do
		onChildFromMessage: #textualCoderViewModel;
		action: [ :aViewModel | aViewModel
			sourceText: 'modified' asRopedText
			from: aViewModel
			synchronously: true ];
		play.

	aScripter assert
		id: GtTextualCoderModificationIndicatorId;
		value: [ :anIndicator | anIndicator visibility ] equals: [ BlVisibility visible ];
		play.

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
