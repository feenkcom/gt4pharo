Class {
	#name : #GtMessageNotImplementedAdvice,
	#superclass : #GtMethodAdvice,
	#category : #'GToolkit-Pharo-Coder-AddOns-MethodAdvices'
}

{ #category : #accessing }
GtMessageNotImplementedAdvice >> description [
	^ 'The message has no implementers. If the code is executed, then it will case a #doesNotUnderstand: message to be sent.'
]

{ #category : #private }
GtMessageNotImplementedAdvice >> fixItActionsFor: aNode using: aCriticStyler [
	| actions type |
	actions := OrderedCollection new.
	type := aCriticStyler
			typeOf: (aNode isMessage
					ifTrue: [ aNode parent receiver ]
					ifFalse: [ aNode parent arguments last ]).
	type
		ifNotNil: [ actions
				add: ((GtDefineMethodFixItAction forCoder: aCriticStyler coderModel node: aNode)
						classOrMetaClass: type) ].
	actions
		addAll: (self
				potentialRenameActionsFor: aNode
				type: type
				using: aCriticStyler).
	^ actions
]

{ #category : #testing }
GtMessageNotImplementedAdvice >> matches: aNode from: aCriticRunner [
	| receiverType selector |
	aCriticRunner hasRefactoring ifTrue: [ ^ false ].
	aNode isMessage
		ifTrue: [ receiverType := aCriticRunner typeOf: aNode parent receiver.
			selector := aNode selector ]
		ifFalse: [ (aNode isLiteral
				and: [ aNode isSymbol
						and: [ aNode parent isMessage
								and: [ aNode parent selector = #when:send:to:
										and: [ (aNode parent arguments at: 2) == aNode
												and: [ aNode literalValue numArgs >= 0 ] ] ] ] ])
				ifFalse: [ ^ false ].
			receiverType := aCriticRunner typeOf: aNode parent arguments last.
			selector := aNode literalValue ].
	receiverType
		ifNil: [ ^ (GtPharoIndex current implementersOf: selector) isEmpty ].
	^ (receiverType whichClassIncludesSelector: selector) isNil
		and: [ receiverType isTrait not
				or: [ (Object whichClassIncludesSelector: selector) isNil ] ]
]

{ #category : #accessing }
GtMessageNotImplementedAdvice >> name [
	^ 'Message is not implemented'
]

{ #category : #private }
GtMessageNotImplementedAdvice >> potentialRenameActionsFor: aNode type: type using: aCriticStyler [
	| selectors block args currentSelector index minRating |
	selectors := OrderedCollection new.
	currentSelector := aNode isMessage
			ifTrue: [ aNode selector ]
			ifFalse: [ aNode literalValue ].
	args := currentSelector numArgs.
	minRating := currentSelector size / 2.0.
	block := [ :each | 
		| rating |
		each numArgs = args
			ifTrue: [ rating := currentSelector alike: each.
				rating > minRating
					ifTrue: [ (selectors size = 10 and: [ selectors last value > rating ])
							ifFalse: [ selectors addLast: each -> rating.
								index := selectors size.
								[ index > 1 ]
									whileTrue: [ (selectors at: index - 1) value < rating
											ifTrue: [ selectors swap: index - 1 with: index.
												index := index - 1 ]
											ifFalse: [ index := 0 ] ].
								selectors size > 10 ifTrue: [ selectors removeLast ] ] ] ] ].
	type
		ifNil: [ GtPharoIndex current implementersDo: block ]
		ifNotNil: [ (type allSelectors
				addAll: (type isTrait ifTrue: [ Object allSelectors ] ifFalse: [ #() ]);
				yourself) do: block ].
	^ selectors
		collect: [ :each | 
			(GtRenameMessageFixItAction forCoder: aCriticStyler coderModel node: aNode)
				selector: each key;
				yourself ]
]
