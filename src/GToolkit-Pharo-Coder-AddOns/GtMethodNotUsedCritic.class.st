Class {
	#name : #GtMethodNotUsedCritic,
	#superclass : #GtMethodCritic,
	#category : #'GToolkit-Pharo-Coder-AddOns-Critics'
}

{ #category : #accessing }
GtMethodNotUsedCritic class >> isDefault [
	^ false
]

{ #category : #accessing }
GtMethodNotUsedCritic >> description [
	^ 'Method has no senders. If it is not called through a constructed selector, then it can be removed.'
]

{ #category : #private }
GtMethodNotUsedCritic >> fixItActionsFor: aNode using: aCriticStyler [
	^ {(GtRemoveMethodFixItAction forCoder: aCriticStyler coderModel node: aNode)
			behavior: aCriticStyler behavior;
			yourself}
]

{ #category : #testing }
GtMethodNotUsedCritic >> matches: aNode from: aCriticRunner [
	(aNode isMethodPattern
		and: [ (GtPharoCompletionStrategy sendersOf: aNode selector) isEmpty ])
		ifFalse: [ ^ false ].
	(aNode selector beginsWith: 'test')
		ifTrue: [ (aCriticRunner behavior isMeta not
				and: [ (aCriticRunner behavior
						whichSuperclassSatisfies: [ :cls | cls name = #TestCase ]) notNil ])
				ifTrue: [ ^ false ] ].
	(aNode parent body pragmas
		anySatisfy: [ :pragma | #(gtExample gtView gtSearch gtSlide gtClassView) includes: pragma selector ])
		ifTrue: [ ^ false ].
	^ aCriticRunner behavior includesSelector: aNode selector
]

{ #category : #enumerating }
GtMethodNotUsedCritic >> potentialMethodsDo: aBlock [
	GtPharoCompletionStrategy
		cachedSelectorsDo: [ :selector :implementers :senders | senders isEmpty ifTrue: [ implementers do: aBlock ] ]
]
