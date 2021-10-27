Trait {
	#name : #TGtPharoSuiteViewModel,
	#category : #'GToolkit-Pharo-Coder-AddOns-Test Case'
}

{ #category : #accessing }
TGtPharoSuiteViewModel >> allStates [

	"Return all suite states that can be displays to users as summary."

	^ self explicitRequirement
]
