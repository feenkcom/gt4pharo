Extension { #name : 'GtPharoPackagesCoder' }

{ #category : '*GToolkit-Pharo-Coder-UI' }
GtPharoPackagesCoder >> asCoderUIModel [
	^ GtPharoPackagesCoderViewModel new pharoPackagesCoderModel: self
]
