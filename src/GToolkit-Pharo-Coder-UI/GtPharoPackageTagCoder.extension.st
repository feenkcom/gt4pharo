Extension { #name : #GtPharoPackageTagCoder }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtPharoPackageTagCoder >> asCardElement [
	^ GtPackageTagCardElement new coder: self
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtPharoPackageTagCoder >> asElement [
	^ GtPharoPackageTagCoderElement new packageTagCoder: self
]
