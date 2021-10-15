Extension { #name : #GtPharoPackageTagsCoder }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtPharoPackageTagsCoder >> asCoderUIModel [
	^ GtPharoPackageTagsViewModel new pharoPackageTagsCoderModel: self
]
