Extension { #name : #RBParser }

{ #category : #'*GToolkit-Pharo-Coder' }
RBParser >> parseKeywordMessageWith: node [ 
	| args isKeyword keywordsStartPositions selector selectorStream |
	args := OrderedCollection new: 3.
	keywordsStartPositions := OrderedCollection new: 3.
	selectorStream := WriteStream on: String new.
	isKeyword := false.
	[currentToken isKeyword] whileTrue: 
			[keywordsStartPositions add: currentToken start.
			selectorStream nextPutAll: currentToken value.
			self step.
			args add: self parseBinaryMessage.
			isKeyword := true].
	^isKeyword
		ifTrue: 
			[selector := self selectorNodeClass value: selectorStream contents.
			selector keywordPositions: keywordsStartPositions.
			self messageNodeClass 
				receiver: node
				selector: selector
				keywordsPositions: keywordsStartPositions
				arguments: args]
		ifFalse: [node]
]
