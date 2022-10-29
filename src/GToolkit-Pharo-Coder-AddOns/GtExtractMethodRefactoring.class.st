Class {
	#name : #GtExtractMethodRefactoring,
	#superclass : #RBExtractMethodRefactoring,
	#category : #'GToolkit-Pharo-Coder-AddOns-Extract method'
}

{ #category : #accessing }
GtExtractMethodRefactoring >> initialize [
	super initialize.
	self
		setOption: #alreadyDefined
		toUse: [ :ref :cls :sel | self gtSignalMethodOverwritten: sel in: cls ]
]
