Extension { #name : #GtSearchBinaryFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchBinaryFilter >> filterDescriptor2For: aMethodsCoder [
	^ (left filterDescriptor2For: aMethodsCoder)
		ifNil: [ right filterDescriptor2For: aMethodsCoder ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchBinaryFilter >> filterDescriptorFor: aMethodsCoder [
	^ (left filterDescriptorFor: aMethodsCoder)
		ifNil: [ right filterDescriptorFor: aMethodsCoder ]
]
