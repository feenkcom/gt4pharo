Extension { #name : #OCProgramNode }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
OCProgramNode >> gtInterestingHighlightingIntervals [
	"return a collection of interesting intervals to highlight"
	^ {self start to: self stop}
]
