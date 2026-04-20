Class {
	#name : #GtPharoRenameSelectorModelExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Examples-Refactoring - Method New'
}

{ #category : #'as yet unclassified' }
GtPharoRenameSelectorModelExamples >> attributes [
	<gtExample>
	| aStencil aModel |
	aModel := self renameSelectorModelWithKeywordMethod.
	aStencil := GtPharoRenameSelectorAttributesStencil new.
	aStencil selectorModel: aModel.

	^ aStencil
]

{ #category : #examples }
GtPharoRenameSelectorModelExamples >> basicRenameSelectorModel [
	<gtExample>
	| aModel |
	aModel := GtPharoRenameSelectorModel new.
	^ aModel
]

{ #category : #examples }
GtPharoRenameSelectorModelExamples >> keywordMethod [
	<gtExample>
	| aMethod |
	aMethod := GtPharoDummyTwoObject >> #sumA:valueB:valueC:.
	^ aMethod
]

{ #category : #examples }
GtPharoRenameSelectorModelExamples >> renameSelectorModelWithKeywordMethod [
	<gtExample>
	| aModel aMethod |
	aMethod := self keywordMethod.
	aModel := GtPharoRenameSelectorModel forAstMethodNode: aMethod ast.
	^ aModel
]

{ #category : #'gt - extensions' }
GtPharoRenameSelectorModelExamples >> renameSelectorModelWithKeywordMethod_swapKeywordAndParameterWithNext [
	<gtExample>
	| aModel |
	aModel := self renameSelectorModelWithKeywordMethod.
	aModel swapKeywordAndParameterWithNext: 1.
	^ aModel
]

{ #category : #'gt - extensions' }
GtPharoRenameSelectorModelExamples >> renameSelectorModelWithKeywordMethod_swapKeywordAndParameterWithPrevious [
	<gtExample>
	| aModel |
	aModel := self renameSelectorModelWithKeywordMethod.
	aModel swapKeywordAndParameterWithPrevious: 3.
	^ aModel
]

{ #category : #'api - updating' }
GtPharoRenameSelectorModelExamples >> renameSelectorModelWithKeywordMethod_swapParameterWithNext [
	<gtExample>
	| aModel |
	aModel := self renameSelectorModelWithKeywordMethod.
	aModel swapParameterWithNext: 1.
	^ aModel
]

{ #category : #'api - updating' }
GtPharoRenameSelectorModelExamples >> renameSelectorModelWithKeywordMethod_swapParameterWithPrevious [
	<gtExample>
	| aModel |
	aModel := self renameSelectorModelWithKeywordMethod.
	aModel swapParameterWithPrevious: 2.
	^ aModel
]
