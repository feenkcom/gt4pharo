Class {
	#name : #GtExtractMethodRefactoring,
	#superclass : #RBExtractMethodRefactoring,
	#category : 'GToolkit-Pharo-Coder-AddOns-Extract method'
}

{ #category : #accessing }
GtExtractMethodRefactoring >> initialize [
	super initialize.
	self
		setOption: #alreadyDefined
		toUse: [ :ref :cls :sel | self gtSignalMethodOverwritten: sel in: cls ]
]

{ #category : #transforming }
GtExtractMethodRefactoring >> isParseTreeEquivalentTo: aSelector [
	| result |
	result := super isParseTreeEquivalentTo: aSelector.
	^ self
		forPharo12AndNewer: [ result and: [ self shouldUseExistingMethod: aSelector ] ]
		forPharo11: [ result ]
]

{ #category : #transforming }
GtExtractMethodRefactoring >> shouldUseExistingMethod: aSelector [
	^ (self options at: #useExistingMethod ifAbsent: [ true ])
		cull: self
		cull: aSelector
]
