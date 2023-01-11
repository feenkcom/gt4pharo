Class {
	#name : #GtPharoErrorNode,
	#superclass : #GtPharoValueNode,
	#instVars : [
		'smaccError'
	],
	#category : #'GToolkit-Pharo-Parser-Parser'
}

{ #category : #generated }
GtPharoErrorNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitError: self
]

{ #category : #accessing }
GtPharoErrorNode >> cascadeReceiver [
	"If it appears that we are in a cascade node, return the receiver."

	| token item |
	smaccError stackContents size > 1
		ifTrue: [ token := smaccError stackContents last.
			((token isKindOf: SmaCCToken) and: [ token source = ';' ])
				ifTrue: [ item := smaccError stackContents at: smaccError stackContents size - 1.
					(item isArray and: [ item size = 2 ])
						ifTrue: [ (item first isKindOf: GtPharoValueNode)
								ifTrue: [ ^ item first ]
								ifFalse: [ (smaccError stackContents size > 2
										and: [ (item first isKindOf: OrderedCollection)
												and: [ item first notEmpty
														and: [ (item first first isKindOf: SmaCCToken) and: [ item first first source = ';' ] ] ] ])
										ifTrue: [ item := smaccError stackContents at: smaccError stackContents size - 2.
											(item isArray
												and: [ item size = 2 and: [ item first isKindOf: GtPharoValueNode ] ])
												ifTrue: [ ^ item first ] ] ] ] ] ].
	^ nil
]

{ #category : #accessing }
GtPharoErrorNode >> guessType: completionStrategy [
	self cascadeReceiver ifNotNil: [ :node | ^ node guessType: completionStrategy ].
	^ super guessType: completionStrategy
]

{ #category : #testing }
GtPharoErrorNode >> isErrorNode [
	^ true
]

{ #category : #generated }
GtPharoErrorNode >> nodeVariables [
	^ #(#smaccError)
]

{ #category : #accessing }
GtPharoErrorNode >> priority [
	^ 0
]

{ #category : #generated }
GtPharoErrorNode >> smaccError [
	^ smaccError
]

{ #category : #generated }
GtPharoErrorNode >> smaccError: aSmaCCErrorNode [
	self smaccError notNil ifTrue: [ self smaccError parent: nil ].
	smaccError := aSmaCCErrorNode.
	self smaccError notNil ifTrue: [ self smaccError parent: self ]
]
