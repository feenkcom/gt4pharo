Extension { #name : #Protocol }

{ #category : #'*GToolkit-Pharo-Metamodels' }
Protocol >> gtClassSide: aClass [
	^ aClass classSide 
		protocolNamed: self name 
		ifAbsent: [ self class name: self name ]
]
