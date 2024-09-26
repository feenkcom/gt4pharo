Extension { #name : #AllProtocol }

{ #category : #'*GToolkit-Pharo-Metamodels' }
AllProtocol >> gtClassSide: aClass [
	^ self class protocolOrganizer: (aClass classSide organization protocolOrganizer)
]
