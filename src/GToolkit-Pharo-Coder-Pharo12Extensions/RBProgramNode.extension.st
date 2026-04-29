Extension { #name : #RBProgramNode }

{ #category : #'*GToolkit-Pharo-Coder-Pharo12Extensions' }
RBProgramNode >> gtASTMatches [
	^ GtSearchRBASTFilter ast: self
]

{ #category : #'*GToolkit-Pharo-Coder-Pharo12Extensions' }
RBProgramNode >> gtInterestingHighlightingIntervals [
	"return a collection of interesting intervals to highlight"
	^ {self start to: self stop}
]

{ #category : #'*GToolkit-Pharo-Coder-Pharo12Extensions' }
RBProgramNode >> gtLiterals [
	| literals |
	literals := Set new.
	self gtLiteralsInto: literals.
	^ literals
]

{ #category : #'*GToolkit-Pharo-Coder-Pharo12Extensions' }
RBProgramNode >> gtLiteralsInto: aSet [
	self children do: [ :each | each gtLiteralsInto: aSet ]
]
