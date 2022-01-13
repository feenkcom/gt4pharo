Extension { #name : #GtPharoPackageTagsCoder }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtPharoPackageTagsCoder >> asCoderViewModel [
	^ GtPharoPackageTagsViewModel new pharoPackageTagsCoderModel: self
]
