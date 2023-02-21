Class {
	#name : #GtTraitCreationForm,
	#superclass : #GtCreationForm,
	#instVars : [
		'traits',
		'slots',
		'newClassName'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Forms - Models'
}

{ #category : #accessing }
GtTraitCreationForm class >> componentName [
	^ 'Trait'
]

{ #category : #accessing }
GtTraitCreationForm class >> priority [
	^ 2
]

{ #category : #accessing }
GtTraitCreationForm >> commit [
	| category |
	category := self commitPackage categoryName.
	^ Smalltalk classInstaller
		make: [ :builder | 
			builder
				name: newClassName;
				category: category;
				slots: slots;
				traitComposition: self traitComposition;
				beTrait ]
]

{ #category : #accessing }
GtTraitCreationForm >> defaultName [
	^ 'TNameOfTrait'
]

{ #category : #initialization }
GtTraitCreationForm >> initialize [
	super initialize.

	self newClassName: ''.
	traits := OrderedCollection new.
	slots := OrderedCollection new
]

{ #category : #magritte }
GtTraitCreationForm >> nameDescription [
	<magritteDescription>
	^ GtMATextDescription new
		label: 'Name*';
		priority: 1;
		accessor: #newClassName;
		kind: Object;
		labelStyler: #glamorousFormLabelStyle;
		textStyler: #glamorousCodeFont;
		addCondition: [ :aValue | aValue asString trim isNotEmpty ]
			labelled: 'Name cannot be empty';
		addCondition: [ :aValue | (Smalltalk classNamed: aValue asString trim) isNil ]
			labelled: 'Name is already taken';
		addCondition: [ :aValue | aValue size > 0 ifTrue: [ aValue first isUppercase ] ifFalse: [ true ] ]
			labelled: 'First character must be uppercase';
		addCondition: [ :aValue | aValue  asString allSatisfy: [:c | c isAlphaNumeric or: [c = $_ ] ] ]
			labelled: 'Name must be alphanumeric';
		addCondition: [ :aValue | (aValue = 'TNameOfTrait') not and: [ (aValue = 'NameOfSubclass') not ] ]
			labelled: 'Name cannot be example value'
]

{ #category : #accessing }
GtTraitCreationForm >> newClassName [
	^ newClassName asRopedText attribute: (self ghostTextFor: self defaultName)
]

{ #category : #accessing }
GtTraitCreationForm >> newClassName: aClassName [
	newClassName := aClassName asString
]

{ #category : #accessing }
GtTraitCreationForm >> rawClassName [
	^ newClassName asString
]

{ #category : #accessing }
GtTraitCreationForm >> slots [

	^ slots
]

{ #category : #accessing }
GtTraitCreationForm >> slots: anObject [

	slots := anObject
]

{ #category : #accessing }
GtTraitCreationForm >> slotsDescription [
	<magritteDescription>
	^ MAToManyRelationDescription new
		label: 'Slots';
		priority: 5;
		accessor: #slots;
		labelStyler: #glamorousFormLabelStyle;
		classes: {String};
		blocListStencil: (self taggerStencilWithCompletion: nil);
		addCondition: [ :aValue | aValue asSet size = aValue size ]
			labelled: 'All slot names must be unique'
]

{ #category : #accessing }
GtTraitCreationForm >> traitComposition [
	^ (self traits collect: #asClass) asArray asTraitComposition
]

{ #category : #accessing }
GtTraitCreationForm >> traits [

	^ traits
]

{ #category : #accessing }
GtTraitCreationForm >> traits: anObject [

	traits := anObject
]

{ #category : #accessing }
GtTraitCreationForm >> traitsDescription [
	<magritteDescription>
	^ MAToManyRelationDescription new
		label: 'Traits';
		priority: 5;
		accessor: #traits;
		classes: {String};
		labelStyler: #glamorousFormLabelStyle;
		blocListStencil: (self taggerStencilWithCompletion: GtClassesCompletionStrategy new)
]
