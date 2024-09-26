Extension { #name : #Protocol }

{ #category : #'*GToolkit-Pharo-Metamodels' }
Protocol >> gtClassSide: aClass [
	^ (aClass classSide organization protocolNamed: self name)
		ifNil: [ self class name: self name ]
]
