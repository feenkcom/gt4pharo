Class {
	#name : #GtTraitCreationForm,
	#superclass : #GtBehaviorCreationForm,
	#category : #'GToolkit-Pharo-Coder-UI-Forms - Models'
}

{ #category : #accessing }
GtTraitCreationForm class >> componentName [
	^ 'Trait'
]

{ #category : #accessing }
GtTraitCreationForm >> commit [
	self defineTrait.
	^ Smalltalk classNamed: self rawClassName
]

{ #category : #accessing }
GtTraitCreationForm >> defaultName [
	^ 'TNameOfTrait'
]

{ #category : #'api - initialization' }
GtTraitCreationForm >> fillFormWithClass: aClass [
	super fillFormWithClass: aClass.
	aClass isTrait ifTrue: [ self traits: {aClass name} ]
]
