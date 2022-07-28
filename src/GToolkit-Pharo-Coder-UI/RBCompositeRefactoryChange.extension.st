Extension { #name : #RBCompositeRefactoryChange }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
RBCompositeRefactoryChange >> recursivelyRemoveChange: aChange [
	self removeChange: aChange.
	changes do: [ :each | each recursivelyRemoveChange: aChange ]
]
