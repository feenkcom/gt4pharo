Class {
	#name : #GtAllSubclassesDefineVariableCritic,
	#superclass : #GtClassCritic,
	#category : #'GToolkit-Pharo-Coder-AddOns-Critics'
}

{ #category : #accessing }
GtAllSubclassesDefineVariableCritic >> description [
	^ 'All subclasses define same instance variable.'
]

{ #category : #accessing }
GtAllSubclassesDefineVariableCritic >> matches: aBehavior from: aCriticRunner [
	| vars subclasses |
	subclasses := aBehavior subclasses.
	subclasses size <= 1 ifTrue: [ ^ false ].
	vars := Bag new.
	subclasses
		do: [ :cls | cls instVarNames ifNotEmpty: [ :col | vars addAll: col ] ifEmpty: [ ^ false ] ].
	vars
		doWithOccurrences: [ :var :count | count = subclasses size ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #accessing }
GtAllSubclassesDefineVariableCritic >> name [
	^ 'Variable defined in all subclasses'
]
