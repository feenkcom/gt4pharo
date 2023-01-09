Extension { #name : #GtPharoProgramNode }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoProgramNode >> cascadeNode [
	^ self nodeOfType: GtPharoCascadeNode
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoProgramNode >> messageNode [
	^ self nodeOfType: GtPharoMessageNode
]
