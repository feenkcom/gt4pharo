Extension { #name : #OCSelectorNode }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
OCSelectorNode >> gtInterestingHighlightingIntervals [
	| all |
	all := OrderedCollection new.
	self keywords
		paddedWith: self keywordPositions
		do: [ :aKeyword :aPosition | all add: (aPosition to: aPosition + aKeyword size - 1) ].
	^ all
]
