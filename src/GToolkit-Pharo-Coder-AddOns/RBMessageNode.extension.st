Extension { #name : #RBMessageNode }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
RBMessageNode >> gtInterestingHighlightingIntervals [
	^ self receiver gtInterestingHighlightingIntervals
		, {self arguments ifEmpty: [self selectorInterval] ifNotEmpty: [ self selectorInterval first to: self arguments last stop]}
]
