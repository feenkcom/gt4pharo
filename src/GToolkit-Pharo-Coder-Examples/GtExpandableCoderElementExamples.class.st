Class {
	#name : #GtExpandableCoderElementExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Examples'
}

{ #category : #'as yet unclassified' }
GtExpandableCoderElementExamples >> forCollapsedMethodCoder [
	<gtExample>
	| anElement aCoder |
	aCoder := GtPharoMethodCoder forMethod: GtPharoMethodCoderExamples >> #example.
	anElement := GtExpandableSourceCoderElement new.
	anElement coderViewModel: (aCoder asCoderViewModel expanded: false).
	self assert: anElement isExpanded not.
	^ anElement
]

{ #category : #'as yet unclassified' }
GtExpandableCoderElementExamples >> forExpandedMethodCoder [
	<gtExample>
	| anElement aCoder |
	aCoder := GtPharoMethodCoder forMethod: GtPharoMethodCoderExamples >> #example.
	anElement := GtExpandableSourceCoderElement new.
	anElement coderViewModel: (aCoder asCoderViewModel expanded: true).
	self assert: anElement isExpanded.
	^ anElement
]
