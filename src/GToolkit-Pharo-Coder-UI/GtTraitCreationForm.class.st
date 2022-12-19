Class {
	#name : #GtTraitCreationForm,
	#superclass : #GtCreationForm,
	#instVars : [
		'className',
		'traits',
		'slots'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Forms - Models'
}

{ #category : #accessing }
GtTraitCreationForm >> className [
	^ className asRopedText
		attribute: (BrGhostTextAttribute
				for: (self defaultName asRopedText glamorousRegularFontAndSize foreground: Color lightGray))
]

{ #category : #accessing }
GtTraitCreationForm >> className: anObject [
	className := anObject
]

{ #category : #accessing }
GtTraitCreationForm >> commit [
	| category |
	category := self commitPackage categoryName.
	^ Smalltalk classInstaller
		make: [ :builder | 
			builder
				name: className;
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

	self className: ''.
	traits := OrderedCollection new.
	slots := OrderedCollection new
]

{ #category : #magritte }
GtTraitCreationForm >> nameDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Name*';
		priority: 1;
		accessor: #className;
		kind: Object;
		blocCompletion: [ GtStringsCompletionStrategy new
				completions: (GtPrefixTree withAll: (Smalltalk allClasses collect: #name)) ];
		addCondition: [ :aValue | aValue asString trim isNotEmpty ]
			labelled: 'Name cannot be empty';
		addCondition: [ :aValue | (Smalltalk classNamed: aValue asString trim) isNil ]
			labelled: 'Name is already taken';
		addCondition: [ :aValue | aValue size > 0 ifTrue: [ aValue first isUppercase ] ifFalse: [ true ] ]
			labelled: 'First character must be uppercase';
		addCondition: [ :aValue | aValue  asString isAllAlphaNumerics ]
			labelled: 'Name must be alphanumeric';
		addCondition: [ :aValue | (aValue = 'TNameOfTrait') not and: [ (aValue = 'NameOfSubclass') not ] ]
			labelled: 'Name cannot be example value'
]

{ #category : #accessing }
GtTraitCreationForm >> rawClassName [
	^ className asString
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
		classes: {String};
		blocListStencil: self taggerStencil;
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
		blocListStencil: self taggerStencil
]
