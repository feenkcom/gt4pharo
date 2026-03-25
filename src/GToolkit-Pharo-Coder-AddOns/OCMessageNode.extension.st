Extension { #name : #OCMessageNode }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
OCMessageNode >> gtInterestingHighlightingIntervals [
	^ self receiver gtInterestingHighlightingIntervals
		, {self arguments ifEmpty: [self selectorInterval] ifNotEmpty: [ self selectorInterval first to: self arguments last stop]}
]
