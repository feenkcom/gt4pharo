Extension { #name : #RBSequenceNode }

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBSequenceNode >> gtAddTemporaryNamed: newVariableName toSource: source [
	self temporaries isEmpty
		ifTrue: [ self rightBar
				ifNotNil: [ :rBar | 
					source
						insert: (self leftBar + 1 = rBar
								ifTrue: [ ' ' , newVariableName , ' ' ]
								ifFalse: [ newVariableName , ' ' ])
						at: rBar ]
				ifNil: [ | pos ws |
					ws := self gtStartOfLineWhitespace.
					pos := self statements first start.
					source
						insert: '| ' , newVariableName , ' |' , String cr , ws
						at: (self periods notEmpty ifTrue: [ pos min: self periods first ] ifFalse: [ pos ]) ] ]
		ifFalse: [ source
				insert: ' ' , newVariableName
				at: self temporaries last stop + 1 ]
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBSequenceNode >> gtStartOfLineWhitespace [
	| methodSource |
	methodSource := self methodNode source.
	(self leftBar
		ifNotNil: [ :left | methodSource gtStartOfLineWhitespaceBefore: left ])
		ifNotNil: [ :ws | ^ ws ].
	self statements
		do: [ :each | 
			(methodSource gtStartOfLineWhitespaceBefore: each start)
				ifNotNil: [ :ws | ^ ws ] ].
	^ '	'
		, (self statementNode
				ifNil: [ '' ]
				ifNotNil: [ :node | node parent ifNotNil: [ node parent gtStartOfLineWhitespace ] ifNil: [ '' ] ])
]
