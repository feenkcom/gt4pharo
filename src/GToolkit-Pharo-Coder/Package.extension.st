Extension { #name : #Package }

{ #category : #'*GToolkit-Pharo-Coder' }
Package >> gtMethodsInPackage [
	^ GtSearchMethodsInPackageFilter new package: self
]
