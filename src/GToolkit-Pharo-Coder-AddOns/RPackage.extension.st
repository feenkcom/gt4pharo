Extension { #name : #RPackage }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
RPackage >> gtTestCaseMethods [

	^ GtSearchPackageTestSuiteFilter new package: self
]
