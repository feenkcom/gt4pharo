Extension { #name : #RBMessageNode }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
RBMessageNode >> gtInterestingHighlightingIntervals [
	^ self receiver gtInterestingHighlightingIntervals
		, self selectorNode gtInterestingHighlightingIntervals
]
