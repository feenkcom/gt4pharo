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
	| category aClass |
	category := self commitPackage categoryName.
	aClass := Smalltalk classInstaller
		make: [ :builder | 
			builder
				name: newClassName;
				category: category;
				slots: slots;
				traitComposition: self traitComposition;
				beTrait ].
	self installClassSlotsOn: aClass.
	^ aClass
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
