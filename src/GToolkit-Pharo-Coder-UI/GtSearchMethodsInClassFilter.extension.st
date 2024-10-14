Extension { #name : #GtSearchMethodsInClassFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchMethodsInClassFilter >> filterDescriptor2For: aMethodsCoder [
	^ (super filterDescriptor2For: aMethodsCoder)
		ifNotNil: [ :aFilterModel | aFilterModel selectedItem: upToSuperclass ]
]
