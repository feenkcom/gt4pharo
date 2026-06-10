Class {
	#name : #GtPharoIncrementalParserExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Parser-Examples'
}

{ #category : #'as yet unclassified' }
GtPharoIncrementalParserExamples >> checkIncrementalASTWhenContainsInvalidToken [
	<gtExample>
	| originalAST updatedAST |
	originalAST := GtPharoIncrementalParser
			parseWithErrors: 'self flag: ''Hello. How are you?'
			startingAt: GtPharoIncrementalParser startingStateForMethodSequence.
	originalAST
		invalidateFrom: originalAST source size + 1
		to: originalAST source size
		inserting: 1.
	updatedAST := GtPharoIncrementalParser
			parseWithErrors: 'self flag: ''Hello. How are you?'''
			startingAt: GtPharoIncrementalParser startingStateForMethodSequence
			previous: originalAST.
	self
		assert: updatedAST
		equals: (GtPharoIncrementalParser
				parseWithErrors: 'self flag: ''Hello. How are you?'''
				startingAt: GtPharoIncrementalParser startingStateForMethodSequence).
	^ updatedAST
]
