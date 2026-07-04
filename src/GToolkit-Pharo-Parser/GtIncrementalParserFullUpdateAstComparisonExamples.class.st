Class {
	#name : #GtIncrementalParserFullUpdateAstComparisonExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Parser-Examples'
}

{ #category : #examples }
GtIncrementalParserFullUpdateAstComparisonExamples >> comparisonFromIncrementalParsingPage [
	<gtExample>
	| initialSource modifiedSource initialAst updatedAst comparison |
	GtTextualCoder useIncrementalParsing.
	GtPharoClassExpanderStyler usedVersion: 6.
	initialSource := 'with: a with: b
	^ OrderedCollection new
		add: a;
		add: b;
		yourself'.
	modifiedSource := 'with: a with: b with: c
	^ OrderedCollection new
		add: a;
		add: b;
		add: c;
		yourself'.
	initialAst := GtPharoIncrementalParser
		parse: initialSource.
	initialAst invalidateFrom: 64 to: 63 inserting: 10.
	initialAst invalidateFrom: 16 to: 15 inserting: 8. 
	updatedAst := GtPharoIncrementalParser
		parse: modifiedSource
		previous: initialAst.
	comparison := GtIncrementalParserFullUpdateAstComparison from: initialAst to: updatedAst.
	self assert: comparison rootComparison notNil.
	self assert: comparison rootComparison newAstNode equals: updatedAst.
	^ comparison
]
