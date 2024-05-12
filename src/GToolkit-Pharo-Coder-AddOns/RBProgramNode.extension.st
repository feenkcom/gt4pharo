Extension { #name : #RBProgramNode }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
RBProgramNode >> gtInterestingHighlightingIntervals [
	"return a collection of interesting intervals to highlight"
	^ {self start to: self stop}
]
