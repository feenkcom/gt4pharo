Class {
	#name : #GtAllProtocol,
	#superclass : #GtVirtualProtocol,
	#category : #'GToolkit-Pharo-Metamodels-Protocols'
}

{ #category : #'as yet unclassified' }
GtAllProtocol class >> defaultName [
	^ #'All'
]

{ #category : #'as yet unclassified' }
GtAllProtocol >> allMethods [
	^ Array streamContents: [ :aStream |
		| anInstanceSide aClassSide|
		anInstanceSide := theClass instanceSide.
		anInstanceSide organization allMethodSelectors
			do: [ :eachSelector | 
				aStream nextPut: anInstanceSide >> eachSelector ].

		aClassSide := theClass classSide.
		aClassSide organization allMethodSelectors
			do: [ :eachSelector | 
				| eachMethod |
				eachMethod := aClassSide >> eachSelector.
				eachMethod isFromTrait
					ifFalse: [ aStream nextPut: eachMethod ] ] ]
]

{ #category : #testing }
GtAllProtocol >> canBeShownWhenEmpty [
	^ true
]

{ #category : #'as yet unclassified' }
GtAllProtocol >> name [
	^ 'All'
]
