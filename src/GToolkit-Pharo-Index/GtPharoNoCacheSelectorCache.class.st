Class {
	#name : #GtPharoNoCacheSelectorCache,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Index'
}

{ #category : #iterating }
GtPharoNoCacheSelectorCache >> asyncStreamStartingWith: aString [
	| selectors |
	selectors := OrderedCollection new.
	self do: [ :each | selectors add: each ] startingWith: aString.
	^ selectors asAsyncStream
]

{ #category : #iterating }
GtPharoNoCacheSelectorCache >> asyncWeightedStreamStartingWith: aString [
	^ self asyncStreamStartingWith: aString
]

{ #category : #iterating }
GtPharoNoCacheSelectorCache >> do: aBlock startingWith: aString [
	| found |
	found := IdentitySet new.
	self class environment allBehaviors
		do: [ :class | 
			class selectors
				do: [ :sel | 
					((sel beginsWith: aString) and: [ (found includes: sel) not ])
						ifTrue: [ found add: sel.
							aBlock cull: sel cull: 1 ] ] ]
]

{ #category : #accessing }
GtPharoNoCacheSelectorCache >> notInstalledMethods [
	^ #()
]
