Extension { #name : #RBCompositeRefactoryChange }

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBCompositeRefactoryChange >> gtBasicChangesInto: aCollection [
	self isBasicChange
		ifTrue: [ aCollection add: self ]
		ifFalse: [ changes do: [ :each | each gtBasicChangesInto: aCollection ] ]
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBCompositeRefactoryChange >> isBasicChange [
	^ false
]
