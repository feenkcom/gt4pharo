Extension { #name : #AllProtocol }

{ #category : #'*GToolkit-Pharo-Metamodels' }
AllProtocol >> gtClassSide: aClass [
	"Ok to use #organization as it is only called in Pharo 11"
	^ self class protocolOrganizer: (aClass classSide organization protocolOrganizer)
]
