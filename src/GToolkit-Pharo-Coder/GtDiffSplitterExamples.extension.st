Extension { #name : #GtDiffSplitterExamples }

{ #category : #'*GToolkit-Pharo-Coder' }
GtDiffSplitterExamples >> pharoSplitter [
	<gtExample>
	<return: #GtDiffSplitCollection>
	| splits words |
	words := #('method' '"' 'This' ' ' 'is' ' ' 'a' ' ' 'test' '"' '^' 'self' 'printString' ',' '''' 'a' ' ' 'b' ' ' 'c' '''').
	splits := GtSmaCCDiffSplitter forPharo
			split: 'method
	"This is a test"
	^self printString , ''a b c'''.
	self assert: splits size equals: words size.
	words
		doWithIndex: [ :each :i | self assert: (splits at: i) object equals: each ].
	^ splits
]

{ #category : #'*GToolkit-Pharo-Coder' }
GtDiffSplitterExamples >> pharoTokenSplitter [
	<gtExample>
	<return: #GtDiffSplitCollection>
	| splits words |
	words := #('method' '"This is a test"' '^' 'self' 'printString' ',' '''a b c''').
	splits := GtSmaCCDiffSplitter forPharoTokens
			split: 'method
	"This is a test"
	^self printString , ''a b c'''.
	self assert: splits size equals: words size.
	words
		doWithIndex: [ :each :i | self assert: (splits at: i) object equals: each ].
	^ splits
]
