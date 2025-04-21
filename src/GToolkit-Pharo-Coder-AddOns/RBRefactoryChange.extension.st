Extension { #name : #RBRefactoryChange }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
RBRefactoryChange >> gtAllChanges [
	^ self changes
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
RBRefactoryChange >> gtCopyWithout: changesCollection [
	(changesCollection identityIncludes: self) ifTrue: [ ^ nil ].
	^ self copy
]
