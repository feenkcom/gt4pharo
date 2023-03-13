Extension { #name : #GtSlotsDefinition }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSlotsDefinition >> modelClassFrom: aModel [
	^ aModel classNamed: self definition topMostParent name
]
