Extension { #name : #GtPharoProgramNode }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoProgramNode >> cascadeNode [
	^ self nodeOrParentOfType: GtPharoCascadeNode
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoProgramNode >> messageNode [
	^ self nodeOrParentOfType: GtPharoMessageNode
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoProgramNode >> nodeOrParentOfType: aClass [
	^ (self isKindOf: aClass)
		ifTrue: [ self ]
		ifFalse: [ self parentOfType: aClass withAllSubclasses ]
]
