Extension { #name : #Slot }

{ #category : #'*GToolkit-Pharo-Coder' }
Slot >> gtReferences [
	^ GtSearchInstanceSlotReferenceFilter
		forClass: self definingClass
		andVariable: self name
]
