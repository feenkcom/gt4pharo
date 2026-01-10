Extension { #name : #RBCompositeRefactoryChange }

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBCompositeRefactoryChange >> gtAllChangesDo: aBlock [
	super gtAllChangesDo: aBlock.
	changes do: [ :each | each gtAllChangesDo: aBlock ]
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBCompositeRefactoryChange >> gtBasicChangesInto: aCollection [
	self isBasicChange
		ifTrue: [ aCollection add: self ]
		ifFalse: [ changes do: [ :each | each gtBasicChangesInto: aCollection ] ]
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBCompositeRefactoryChange >> gtIncludesSubstring: aString [
	^ changes anySatisfy: [ :each | each gtIncludesSubstring: aString ]
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBCompositeRefactoryChange >> gtIsForSelector: aSymbol [
	^ changes anySatisfy: [ :each | each gtIsForSelector: aSymbol ]
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBCompositeRefactoryChange >> isBasicChange [
	^ false
]
