Extension { #name : #GtPharoPackageCoder }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtPharoPackageCoder >> asCardElement [
	^ GtPackageCardElement new coder: self
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtPharoPackageCoder >> asCoderUIModel [
	^ GtPharoPackageCoderViewModel new pharoPackageCoderModel: self
]
