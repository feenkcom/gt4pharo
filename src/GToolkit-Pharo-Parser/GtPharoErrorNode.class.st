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
GtPharoErrorNode >> guessType: completionStrategy [
	| token item |
	"Check if the error is from parsing a cascaded message with an ending ';'"
	smaccError stackContents size > 1
		ifTrue: [ token := smaccError stackContents last.
			((token isKindOf: SmaCCToken) and: [ token source = ';' ])
				ifTrue: [ item := smaccError stackContents at: smaccError stackContents size - 1.
					(item isArray and: [ item size = 2 ])
						ifTrue: [ (item first isKindOf: GtPharoValueNode)
								ifTrue: [ ^ item first guessType: completionStrategy ]
								ifFalse: [ (smaccError stackContents size > 2
										and: [ (item first isKindOf: OrderedCollection)
												and: [ item first notEmpty
														and: [ (item first first isKindOf: SmaCCToken) and: [ item first first source = ';' ] ] ] ])
										ifTrue: [ item := smaccError stackContents at: smaccError stackContents size - 2.
											(item isArray
												and: [ item size = 2 and: [ item first isKindOf: GtPharoValueNode ] ])
												ifTrue: [ ^ item first guessType: completionStrategy ] ] ] ] ] ].
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
