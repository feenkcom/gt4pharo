Class {
	#name : #GtKeywordPartCompletionAction,
	#superclass : #GtCompletionAction,
	#instVars : [
		'keywordMessage',
		'completionToken',
		'selector',
		'offset'
	],
	#category : #'GToolkit-Pharo-Completer-Completion'
}

{ #category : #'instance creation' }
GtKeywordPartCompletionAction class >> on: aToken forMessage: aMessage completing: aSelector [
	^ self new
		completionToken: aToken;
		keywordMessage: aMessage;
		selector: aSelector;
		computeLabel;
		yourself
]

{ #category : #comparing }
GtKeywordPartCompletionAction >> = anObject [
	^ super = anObject
		and: [ self selector = anObject selector
				and: [ self keywordMessage selector = anObject keywordMessage selector ] ]
]

{ #category : #testing }
GtKeywordPartCompletionAction >> affectsText [
	^ true
]

{ #category : #accessing }
GtKeywordPartCompletionAction >> completionToken [
	^ completionToken
]

{ #category : #accessing }
GtKeywordPartCompletionAction >> completionToken: aSmaCCToken [
	completionToken := aSmaCCToken
]

{ #category : #private }
GtKeywordPartCompletionAction >> computeLabel [
	| label parts map position attributes partIndex |
	label := selector asRopedText glamorousCodeFont.
	parts := keywordMessage keywordArrayWithToken: completionToken.
	map := GtPharoIndex current map: selector toKeywords: parts.
	attributes := GtCompletionStrategy matchingCharacterAttributes.
	position := 1.
	selector keywords
		doWithIndex: [ :each :index | 
			(partIndex := map indexOf: index) > 0
				ifTrue: [ (parts at: partIndex) last = $:
						ifTrue: [ label
								attributes: attributes
								from: position
								to: position + each size - 1 ]
						ifFalse: [ | charOffset |
							charOffset := 1.
							(parts at: partIndex)
								do: [ :ch | 
									charOffset := each asLowercase indexOf: ch asLowercase startingAt: charOffset.
									label
										attributes: attributes
										from: position + charOffset - 1
										to: position + charOffset - 1 ] ] ].
			position := position + each size ].
	self label: label
]

{ #category : #accessing }
GtKeywordPartCompletionAction >> finishCompletionOn: aCompletionController moveCursor: aBoolean [
	| parts map keywords partIndex position startString endString underscorePosition currentPosition processedReplacement |
	parts := keywordMessage keywordArrayWithToken: completionToken.
	map := GtPharoIndex current map: selector toKeywords: parts.
	keywords := selector keywords.
	currentPosition := keywordMessage stopPosition + 1.
	processedReplacement := false.
	keywords size
		to: 1
		by: -1
		do: [ :i | 
			position := 0.
			startString := endString := ''.
			(partIndex := map indexOf: i) > 0
				ifTrue: [ (parts at: partIndex) last = $:
						ifTrue: [ currentPosition := (keywordMessage selectorParts
									at: (processedReplacement ifTrue: [ partIndex ] ifFalse: [ partIndex - 1 ]))
									startPosition ]
						ifFalse: [ processedReplacement := true.
							currentPosition := completionToken startPosition.
							self
								delete: completionToken startPosition + offset - 1
								to: completionToken stopPosition + offset
								on: aCompletionController.
							position := completionToken startPosition + offset ] ]
				ifFalse: [ currentPosition > keywordMessage selectorParts last startPosition
						ifTrue: [ startString := ' ' ]
						ifFalse: [ endString := ' ' ].
					position := currentPosition ].
			position > 0
				ifTrue: [ self
						insert: startString , (keywords at: i) , ' _' , endString
						at: position - 1
						on: aCompletionController.
					underscorePosition := position + startString size + (keywords at: i) size
							+ 1.
					(aCompletionController text from: underscorePosition to: underscorePosition)
						attributes: {GtCompletionPartAttribute new} ] ].
	aBoolean
		ifTrue: [ aCompletionController textEditor
				moveCursorTo: keywordMessage parent startPosition + offset.
			aCompletionController moveCursorToNextUncompletedItem: 1 ]
]

{ #category : #comparing }
GtKeywordPartCompletionAction >> hash [
	^ super hash hashMultiply bitXor: selector hash
]

{ #category : #accessing }
GtKeywordPartCompletionAction >> initialize [
	super initialize.
	offset := 0
]

{ #category : #testing }
GtKeywordPartCompletionAction >> isEmpty [
	^ false
]

{ #category : #accessing }
GtKeywordPartCompletionAction >> keywordMessage [
	^ keywordMessage
]

{ #category : #accessing }
GtKeywordPartCompletionAction >> keywordMessage: aMessageNode [
	keywordMessage := aMessageNode
]

{ #category : #executing }
GtKeywordPartCompletionAction >> previewOn: aCompletionController [
	
]

{ #category : #accessing }
GtKeywordPartCompletionAction >> searchStartPosition [
	^ completionToken startPosition + offset
]

{ #category : #accessing }
GtKeywordPartCompletionAction >> selector [
	^ selector
]

{ #category : #accessing }
GtKeywordPartCompletionAction >> selector: aSymbol [
	selector := aSymbol
]

{ #category : #translating }
GtKeywordPartCompletionAction >> translateBy: anIndex [
	super translateBy: anIndex.
	offset := offset + anIndex
]

{ #category : #executing }
GtKeywordPartCompletionAction >> undoPreviewOn: aCompletionController [
	
]
