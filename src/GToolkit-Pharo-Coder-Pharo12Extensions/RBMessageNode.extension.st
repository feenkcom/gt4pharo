Extension { #name : #RBMessageNode }

{ #category : #'*GToolkit-Pharo-Coder-Pharo12Extensions' }
RBMessageNode >> gtInterestingHighlightingIntervals [
	^ self receiver gtInterestingHighlightingIntervals
		, {self arguments ifEmpty: [self selectorInterval] ifNotEmpty: [ self selectorInterval first to: self arguments last stop]}
]
