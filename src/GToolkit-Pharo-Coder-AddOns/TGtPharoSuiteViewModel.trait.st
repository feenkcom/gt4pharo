Trait {
	#name : #TGtPharoSuiteViewModel,
	#category : #'GToolkit-Pharo-Coder-AddOns-Test Case'
}

{ #category : #'api - suite' }
TGtPharoSuiteViewModel >> allStates [

	"Return all suite states that can be displays to users as summary."

	^ self explicitRequirement
]

{ #category : #'api - suite' }
TGtPharoSuiteViewModel >> totalStringForState: aState [

	"Return string representing amount of items for a given state, 
	e.g., '6 examples' for success state."
	
	^ self explicitRequirement
]

{ #category : #'api - suite' }
TGtPharoSuiteViewModel >> updateCoderFilterWith: aState source: aSource [

	"Update MethodsCoder filters based on aState.
	aSource is an element that requests the change."

	^ self explicitRequirement
]
