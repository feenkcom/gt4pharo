Extension { #name : #Package }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
Package >> gtPackageMatches [
	^ self name gtPackageMatches
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
Package >> gtTestCaseMethods [

	^ GtSearchPackageTestSuiteFilter new package: self
]
