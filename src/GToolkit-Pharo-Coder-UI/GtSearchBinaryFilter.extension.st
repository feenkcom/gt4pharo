Extension { #name : #GtSearchBinaryFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchBinaryFilter >> filterDescriptorFor: aMethodsCoder [
	^ (left filterDescriptorFor: aMethodsCoder)
		ifNil: [ right filterDescriptorFor: aMethodsCoder ]
]
