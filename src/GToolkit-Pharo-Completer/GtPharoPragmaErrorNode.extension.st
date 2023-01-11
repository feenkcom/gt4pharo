Extension { #name : #GtPharoPragmaErrorNode }

{ #category : #'*GToolkit-Pharo-Completer' }
GtPharoPragmaErrorNode >> completionActionStreamFor: aStrategy [
	| index |
	index := aStrategy index.
	index = lessThan stopPosition
		ifTrue: [ ^ (aStrategy pragmas asyncWeightedStreamStartingWith: '')
				collect: [ :each | 
					self
						pragmaActionFor: each
						startingWith: ''
						strategy: aStrategy ] ].
	(smaccError stackContents at: 1 ifAbsent: [  ])
		ifNotNil: [ :token | 
			token stopPosition = index
				ifTrue: [ ^ (aStrategy pragmas asyncWeightedStreamStartingWith: token source)
						collect: [ :each | 
							self
								pragmaActionFor: each
								startingWith: token source
								strategy: aStrategy ] ] ].
	^ super completionActionStreamFor: aStrategy
]

{ #category : #'*GToolkit-Pharo-Completer' }
GtPharoPragmaErrorNode >> pragmaActionFor: aSelector startingWith: prefix strategy: aStrategy [
	| action composite gtAction |
	action := self
			actionForSelector: aSelector
			startingWith: prefix
			at: aStrategy index
			strategy: aStrategy.
	composite := GtCompositeCompletionAction labeled: action displayText.
	gtAction := GtInsertTextCompletionAction
			labeled: '>'
			completion: '>'
			position: aStrategy index.
	gtAction searchStartPosition: aStrategy index.
	composite addAction: gtAction.
	composite addAction: action.
	^ composite
]
