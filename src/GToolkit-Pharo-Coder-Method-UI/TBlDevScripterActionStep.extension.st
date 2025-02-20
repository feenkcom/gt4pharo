Extension { #name : #TBlDevScripterActionStep }

{ #category : #'*GToolkit-Pharo-Coder-Method-UI' }
TBlDevScripterActionStep >> foldedInitialStylingDo: anOneArgBlock [
	^ self
		substeps: 'Folded initial styling'
		before: [ | anOldValue |
			anOldValue := GtPharoHidingStyler initiallyFolded.
			GtPharoHidingStyler initiallyFolded: true.
			anOldValue ]
		do: anOneArgBlock
		ensure: [ :anOldValue | 
			GtPharoHidingStyler initiallyFolded: anOldValue ]
]

{ #category : #'*GToolkit-Pharo-Coder-Method-UI' }
TBlDevScripterActionStep >> foldedInitialStylingPlay: anOneArgBlock [
	^ self
		substeps: 'Folded initial styling'
		before: [ | anOldValue |
			anOldValue := GtPharoHidingStyler initiallyFolded.
			GtPharoHidingStyler initiallyFolded: true.
			anOldValue ]
		play: anOneArgBlock
		ensure: [ :anOldValue | 
			GtPharoHidingStyler initiallyFolded: anOldValue ]
]

{ #category : #'*GToolkit-Pharo-Coder-Method-UI' }
TBlDevScripterActionStep >> unfoldedInitialStylingDo: anOneArgBlock [
	^ self
		substeps: 'Unfolded initial styling'
		before: [ | anOldValue |
			anOldValue := GtPharoHidingStyler initiallyFolded.
			GtPharoHidingStyler initiallyFolded: false.
			anOldValue ]
		do: anOneArgBlock
		ensure: [ :anOldValue | 
			GtPharoHidingStyler initiallyFolded: anOldValue ]
]

{ #category : #'*GToolkit-Pharo-Coder-Method-UI' }
TBlDevScripterActionStep >> unfoldedInitialStylingPlay: anOneArgBlock [
	^ self
		substeps: 'Unfolded initial styling'
		before: [ | anOldValue |
			anOldValue := GtPharoHidingStyler initiallyFolded.
			GtPharoHidingStyler initiallyFolded: false.
			anOldValue ]
		play: anOneArgBlock
		ensure: [ :anOldValue | 
			GtPharoHidingStyler initiallyFolded: anOldValue ]
]
