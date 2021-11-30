Extension { #name : #GtPharoMethodPatternNode }

{ #category : #'*GToolkit-Pharo-Completer' }
GtPharoMethodPatternNode >> completionActionStreamFor: aStrategy [
	| seen prefix actions |
	(self selectorParts size = 1 and: [ self selectorParts first stopPosition = aStrategy index ])
		ifFalse: [ ^ #() asAsyncStream ].
	prefix := self selectorParts first source.
	seen := Set new.
	actions := OrderedCollection new.
	^ ((aStrategy hierarchyMethodsStartingWith: prefix) asAsyncStream
		select:
			[ :each | 
			((seen includes: each selector) or: [ aStrategy classOrMetaClass includesSelector: each selector ])
				ifTrue: [ false ]
				ifFalse:
					[ seen add: each selector.
					true ] ])
		collect:
			[ :each | 
			GtInsertTextCompletionAction
				labeled: each selector
				completion: ((aStrategy signatureFor: each) allButFirst: prefix size)
				position: aStrategy index
				from: aStrategy index - prefix size + 1 ]
]
