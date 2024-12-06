Extension { #name : #Slot }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
Slot >> gtIsReferenced [
	owningClass ifNil: [ ^ false ].
	owningClass
		gtWithAllSubclassesDo: [ :subclass | (subclass hasMethodAccessingVariable: self) ifTrue: [ ^ true ] ].
	^ false
]
