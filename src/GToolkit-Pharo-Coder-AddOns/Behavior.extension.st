Extension { #name : #Behavior }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
Behavior >> gtWithAllSubclassesDo: aBlock [
	aBlock value: self.
	self subclasses do: [ :each | each gtWithAllSubclassesDo: aBlock ]
]
