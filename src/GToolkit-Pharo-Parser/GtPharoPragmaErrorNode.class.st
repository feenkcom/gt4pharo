Class {
	#name : #GtPharoPragmaErrorNode,
	#superclass : #GtPharoPragmaNode,
	#instVars : [
		'smaccError'
	],
	#category : #'GToolkit-Pharo-Parser-Parser'
}

{ #category : #generated }
GtPharoPragmaErrorNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitPragmaError: self
]

{ #category : #accessing }
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

{ #category : #generated }
GtPharoPragmaErrorNode >> nodeVariables [
	^ #(#smaccError)
]

{ #category : #accessing }
GtPharoPragmaErrorNode >> pragmaActionFor: aSelector startingWith: prefix strategy: aStrategy [
	| action composite gtAction |
	action := self
			actionForSelector: aSelector
			startingWith: prefix
			at: aStrategy index
			needsParensKeywords: false
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

{ #category : #generated }
GtPharoPragmaErrorNode >> smaccError [
	^ smaccError
]

{ #category : #generated }
GtPharoPragmaErrorNode >> smaccError: aSmaCCErrorNode [
	self smaccError notNil ifTrue: [ self smaccError parent: nil ].
	smaccError := aSmaCCErrorNode.
	self smaccError notNil ifTrue: [ self smaccError parent: self ]
]
