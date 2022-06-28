Class {
	#name : #GtVariableCasingCritic,
	#superclass : #GtClassCritic,
	#category : #'GToolkit-Pharo-Coder-AddOns-Critics'
}

{ #category : #accessing }
GtVariableCasingCritic >> description [
	^ 'Class has instance variables that start with uppercase letters or class variables that start with lowercase letters.'
]

{ #category : #accessing }
GtVariableCasingCritic >> matches: aBehavior from: aCriticRunner [
	(aBehavior instVarNames anySatisfy: [ :each | each first isUppercase ])
		ifTrue: [ ^ true ].
	aBehavior isClassSide ifTrue: [ ^ false ].
	^ aBehavior classVarNames anySatisfy: [ :each | each first isLowercase ]
]

{ #category : #accessing }
GtVariableCasingCritic >> name [
	^ 'Variable has wrong case'
]
