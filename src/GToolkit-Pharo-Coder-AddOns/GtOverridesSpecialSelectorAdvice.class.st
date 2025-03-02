Class {
	#name : #GtOverridesSpecialSelectorAdvice,
	#superclass : #GtMethodAdvice,
	#category : #'GToolkit-Pharo-Coder-AddOns-MethodAdvices'
}

{ #category : #testing }
GtOverridesSpecialSelectorAdvice >> classSideSelectors [
	^ #(basicNew basicNew: class comment name)
]

{ #category : #accessing }
GtOverridesSpecialSelectorAdvice >> description [
	^ 'Class overrides a special selector that is essential for the functioning of the image.'
]

{ #category : #testing }
GtOverridesSpecialSelectorAdvice >> instanceSideSelectors [
	^ #(#== #~~ #class #basicAt: #basicAt:put: #basicSize #identityHash)
]

{ #category : #testing }
GtOverridesSpecialSelectorAdvice >> matches: aNode from: aCriticRunner [
	aNode isErrorNode ifTrue: [ ^ false ].
	aNode isMethodPattern ifFalse: [ ^ false ].
	^ aCriticRunner behavior superclass notNil
		and: [ ((aCriticRunner behavior isClassSide
				ifTrue: [ self classSideSelectors ]
				ifFalse: [ self instanceSideSelectors ]) includes: aNode selector)
				and: [ (aCriticRunner behavior superclass whichClassIncludesSelector: aNode selector)
						notNil ] ]
]

{ #category : #accessing }
GtOverridesSpecialSelectorAdvice >> name [
	^ 'Overrides special selector'
]

{ #category : #accessing }
GtOverridesSpecialSelectorAdvice >> potentialFilter [
	^ (self classSideSelectors
		inject: (self instanceSideSelectors
				inject: GtSearchNullFilter new
				into: [ :sum :each | sum | each gtImplementors ])
		into: [ :sum :each | sum | each gtImplementors ]) asAsyncStream
]
