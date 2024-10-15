Extension { #name : #AsyncWithoutDuplicatesStream }

{ #category : #'*GToolkit-Pharo-StrictSymbolChanges' }
AsyncWithoutDuplicatesStream >> useEqualityComparison [
	setClass := GtStringContentSet.
	seenItems ifNotNil: [ seenItems := setClass withAll: seenItems ]
]
