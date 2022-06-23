Class {
	#name : #GtOverridesSpecialSelectorCritic,
	#superclass : #GtClassCritic,
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
GtOverridesSpecialSelectorCritic >> matches: aBehavior from: aCriticRunner [
	^ (aBehavior isClassSide
		ifTrue: [ self classSideSelectors ]
		ifFalse: [ self instanceSideSelectors ])
		anySatisfy: [ :each | aBehavior includesSelector: each ]
]

{ #category : #accessing }
GtOverridesSpecialSelectorCritic >> name [
	^ 'Overrides special selector'
]
