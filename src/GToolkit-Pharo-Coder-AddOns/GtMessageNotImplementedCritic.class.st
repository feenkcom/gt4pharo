Class {
	#name : #GtMessageNotImplementedCritic,
	#superclass : #GtMethodCritic,
	#category : #'GToolkit-Pharo-Coder-AddOns-Critics'
}

{ #category : #accessing }
GtMessageNotImplementedCritic >> description [
	^ 'The message has no implementers. If the code is executed, then it will case a #doesNotUnderstand: message to be sent.'
]

{ #category : #private }
GtMessageNotImplementedCritic >> fixItActionsFor: aNode using: aCriticStyler [
	| actions type |
	actions := OrderedCollection new.
	type := aCriticStyler typeOf: aNode parent receiver.
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
GtMessageNotImplementedCritic >> matches: aNode from: aCriticRunner [
	| receiverType |
	aNode isMessage ifFalse: [ ^ false ].
	aCriticRunner hasRefactoring ifTrue: [ ^ self ].
	receiverType := aCriticRunner typeOf: aNode parent receiver.
	receiverType
		ifNil: [ ^ (GtPharoCompletionStrategy implementersOf: aNode selector) isEmpty ].
	^ (receiverType whichClassIncludesSelector: aNode selector) isNil
		and: [ receiverType isTrait not
				or: [ (Object whichClassIncludesSelector: aNode selector) isNil ] ]
]

{ #category : #accessing }
GtMessageNotImplementedCritic >> name [
	^ 'Message is not implemented'
]

{ #category : #private }
GtMessageNotImplementedCritic >> potentialRenameActionsFor: aNode type: type using: aCriticStyler [
	| selectors block args currentSelector index minRating |
	selectors := OrderedCollection new.
	args := aNode arguments size.
	currentSelector := aNode selector.
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
		ifNil: [ GtPharoCompletionStrategy implementersDo: block ]
		ifNotNil: [ (type allSelectors
				addAll: (type isTrait ifTrue: [ Object allSelectors ] ifFalse: [ #() ]);
				yourself) do: block ].
	^ selectors
		collect: [ :each | 
			(GtRenameMessageFixItAction forCoder: aCriticStyler coderModel node: aNode)
				selector: each key;
				yourself ]
]
