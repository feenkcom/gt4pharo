Extension { #name : #GtPharoPackagesCoder }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtPharoPackagesCoder >> asCoderViewModel [
	^ GtPharoPackagesCoderViewModel new pharoPackagesCoderModel: self
]
