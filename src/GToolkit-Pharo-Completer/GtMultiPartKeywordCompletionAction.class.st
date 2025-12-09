Class {
	#name : #GtMultiPartKeywordCompletionAction,
	#superclass : #GtCompositeCompletionAction,
	#category : #'GToolkit-Pharo-Completer-Completion'
}

{ #category : #executing }
GtMultiPartKeywordCompletionAction >> finishCompletionOn: aCompletionController moveCursor: aBoolean [
	| first |
	actions
		do: [ :each | 
			| underscorePosition |
			each finishCompletionOn: aCompletionController moveCursor: aBoolean.
			each isInsertion
				ifTrue: [ (each text endsWith: '_')
						ifTrue: [ underscorePosition := each position + each text size ]
						ifFalse: [ (each text endsWith: '_ ')
								ifTrue: [ underscorePosition := each position + each text size - 1 ] ].
					underscorePosition
						ifNotNil: [ first := each position.
							(aCompletionController text
								from: underscorePosition
								to: underscorePosition) attributes: {GtCompletionPartAttribute new} ] ] ].
	first
		ifNotNil: [ aCompletionController textEditor moveCursorTo: first.
			aCompletionController moveCursorToNextUncompletedItem: 1 ]
]
