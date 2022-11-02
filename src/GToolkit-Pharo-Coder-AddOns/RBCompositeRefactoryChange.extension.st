Extension { #name : #RBCompositeRefactoryChange }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
RBCompositeRefactoryChange >> gtAllChanges [
	^ changes flatCollect: [ :each | each gtAllChanges ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
RBCompositeRefactoryChange >> gtCopyWithout: changesCollection [
	| newChanges |
	(changesCollection includes: self) ifTrue: [ ^ nil ].
	newChanges := (changes
			collect: [ :each | each gtCopyWithout: changesCollection ]) select: #notNil.
	^ self copy
		gtSetChanges: newChanges;
		yourself
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
RBCompositeRefactoryChange >> gtSetChanges: newChanges [
	changes := newChanges
]
