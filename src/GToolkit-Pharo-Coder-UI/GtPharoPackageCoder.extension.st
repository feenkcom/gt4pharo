Extension { #name : #GtPharoPackageCoder }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtPharoPackageCoder >> asCardElement [
	^ GtPackageCardElement new coder: self
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtPharoPackageCoder >> asCoderViewModel [
	^ GtPharoPackageCoderViewModel new pharoPackageCoderModel: self
]
