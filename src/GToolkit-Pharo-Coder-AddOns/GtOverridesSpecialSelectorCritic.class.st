Class {
	#name : #GtOverridesSpecialSelectorCritic,
	#superclass : #GtMethodCritic,
	#category : #'GToolkit-Pharo-Coder-AddOns-Critics'
}

{ #category : #testing }
GtOverridesSpecialSelectorCritic >> classSideSelectors [
	^ #(basicNew basicNew: class comment name)
]

{ #category : #accessing }
GtOverridesSpecialSelectorCritic >> description [
	^ 'Class overrides a special selector that is essential for the functioning of the image.'
]

{ #category : #testing }
GtOverridesSpecialSelectorCritic >> instanceSideSelectors [
	^ #(#== #~~ #class #basicAt: #basicAt:put: #basicSize #identityHash)
]

{ #category : #testing }
GtOverridesSpecialSelectorCritic >> matches: aNode from: aCriticRunner [
	aNode isMethodPattern ifFalse: [ ^ false ].
	^ aCriticRunner behavior superclass notNil
		and: [ ((aCriticRunner behavior isClassSide
				ifTrue: [ self classSideSelectors ]
				ifFalse: [ self instanceSideSelectors ]) includes: aNode selector)
				and: [ (aCriticRunner behavior superclass whichClassIncludesSelector: aNode selector)
						notNil ] ]
]

{ #category : #accessing }
GtOverridesSpecialSelectorCritic >> name [
	^ 'Overrides special selector'
]

{ #category : #accessing }
GtOverridesSpecialSelectorCritic >> potentialFilter [
	^ (self classSideSelectors
		inject: (self instanceSideSelectors
				inject: GtSearchNullFilter new
				into: [ :sum :each | sum | each gtImplementors ])
		into: [ :sum :each | sum | each gtImplementors ]) asAsyncStream
]
