Extension { #name : #Trait }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
Trait >> gtIsReferenced [
	^ self traitUsers notEmpty or: [ super gtIsReferenced ]
]
