Class {
	#name : #GtCriticFixItAction,
	#superclass : #GtFixItAction,
	#category : #'GToolkit-Pharo-Coder-AddOns-Critics-FixIt'
}

{ #category : #executing }
GtCriticFixItAction >> deleteStartOfLineWhitespace: aSmaCCString before: aNode [
	| index char |
	index := aNode startPosition - 1.
	[ index > 0
		and: [ (char := aSmaCCString at: index) = Character space
				or: [ char = Character tab ] ] ] whileTrue: [ index := index - 1 ].
	index > 0
		ifTrue: [ char = Character lf
				ifTrue: [ index := index - 1.
					index > 0
						ifTrue: [ (char := aSmaCCString at: index) = Character cr ifTrue: [ index := index - 1 ] ] ]
				ifFalse: [ char = Character cr ifTrue: [ index := index - 1 ] ] ].
	index + 1 = aNode startPosition ifTrue: [ ^ self ].
	aSmaCCString deleteFrom: index + 1 to: aNode startPosition - 1
]

{ #category : #executing }
GtCriticFixItAction >> executeOn: anEditorElement [
	| newSource |
	newSource := sourceCoder currentSourceString.
	newSource = node topParent completeSource asString ifFalse: [ ^ self ].
	newSource := self updateSource.
	sourceCoder currentSourceString: newSource
]

{ #category : #executing }
GtCriticFixItAction >> updateSource [
	^ self subclassResponsibility
]
