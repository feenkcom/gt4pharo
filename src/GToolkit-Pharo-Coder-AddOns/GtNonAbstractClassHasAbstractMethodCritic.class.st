Class {
	#name : #GtNonAbstractClassHasAbstractMethodCritic,
	#superclass : #GtClassCritic,
	#category : #'GToolkit-Pharo-Coder-AddOns-Critics'
}

{ #category : #accessing }
GtNonAbstractClassHasAbstractMethodCritic >> description [
	^ 'Non abstract class defines methods with subclassResponsibility, and it has no subclasses.'
]

{ #category : #accessing }
GtNonAbstractClassHasAbstractMethodCritic >> matches: aBehavior from: aCriticRunner [
	aBehavior instanceSide isAbstract ifTrue: [ ^ false ].
	aBehavior isTrait ifTrue: [ ^ false ].
	aBehavior subclasses notEmpty ifTrue: [ ^ false ].
	((GtPharoCompletionStrategy sendersOf: #subclassResponsibility)
		anySatisfy: [ :each | each methodClass = aBehavior ]) ifTrue: [ ^ true ].
	^ false
]

{ #category : #accessing }
GtNonAbstractClassHasAbstractMethodCritic >> name [
	^ 'Abstract methods in non abstract class'
]
