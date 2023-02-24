Class {
	#name : #GtBehaviorCreationForm,
	#superclass : #GtCreationForm,
	#instVars : [
		'traits',
		'slots',
		'newClassName',
		'classSlots'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Forms - Models'
}

{ #category : #accessing }
GtBehaviorCreationForm class >> isAdditionForm [
	^ false
]

{ #category : #accessing }
GtBehaviorCreationForm class >> priority [
	^ 2
]

{ #category : #accessing }
GtBehaviorCreationForm >> classSlots [
	^ classSlots
]

{ #category : #accessing }
GtBehaviorCreationForm >> classSlots: anObject [
	classSlots := anObject
]

{ #category : #accessing }
GtBehaviorCreationForm >> classSlotsDescription [
	<magritteDescription>
	^ MAToManyRelationDescription new
		label: 'Class Slots';
		priority: 10;
		accessor: #classSlots;
		classes: {String};
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		blocListStencil: (self taggerStencilWithCompletion: nil andContextMenuBlock: nil);
		addCondition: [ :aValue | aValue asSet size = aValue size ]
			labelled: 'All slot names must be unique'
]

{ #category : #initialization }
GtBehaviorCreationForm >> initialize [
	super initialize.

	self newClassName: ''.
	traits := OrderedCollection new.
	slots := OrderedCollection new.
	classSlots := OrderedCollection new
]

{ #category : #accessing }
GtBehaviorCreationForm >> installClassSlotsOn: aClass [
	classSlots
		do: [ :aSlot | (RBAddInstanceVariableChange add: aSlot to: aClass classSide) execute ]
]

{ #category : #magritte }
GtBehaviorCreationForm >> nameDescription [
	<magritteDescription>
	^ GtMATextDescription new
		label: 'Name*';
		priority: 1;
		accessor: #newClassName;
		kind: Object;
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		addCondition: [ :aValue | aValue asString trim isNotEmpty ]
			labelled: 'Name cannot be empty';
		addCondition: [ :aValue | (Smalltalk classNamed: aValue asString trim) isNil ]
			labelled: 'Name is already taken';
		addCondition: [ :aValue | aValue size > 0 ifTrue: [ aValue first isUppercase ] ifFalse: [ true ] ]
			labelled: 'First character must be uppercase';
		addCondition: [ :aValue | aValue asString allSatisfy: [ :c | c isAlphaNumeric or: [ c = $_ ] ] ]
			labelled: 'Name must be alphanumeric';
		addCondition: [ :aValue | (aValue = 'TNameOfTrait') not and: [ (aValue = 'NameOfSubclass') not ] ]
			labelled: 'Name cannot be example value'
]

{ #category : #accessing }
GtBehaviorCreationForm >> newClassName [
	^ newClassName asRopedText attribute: (self ghostTextFor: self defaultName)
]

{ #category : #accessing }
GtBehaviorCreationForm >> newClassName: aClassName [
	newClassName := aClassName asString
]

{ #category : #accessing }
GtBehaviorCreationForm >> rawClassName [
	^ newClassName asString
]

{ #category : #accessing }
GtBehaviorCreationForm >> slots [

	^ slots
]

{ #category : #accessing }
GtBehaviorCreationForm >> slots: anObject [

	slots := anObject
]

{ #category : #accessing }
GtBehaviorCreationForm >> slotsDescription [
	<magritteDescription>
	^ MAToManyRelationDescription new
		label: 'Slots';
		priority: 5;
		accessor: #slots;
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		classes: {String};
		blocListStencil: (self taggerStencilWithCompletion: nil andContextMenuBlock: nil);
		addCondition: [ :aValue | aValue asSet size = aValue size ]
			labelled: 'All slot names must be unique'
]

{ #category : #accessing }
GtBehaviorCreationForm >> traitComposition [
	^ (self traits collect: #asClass) asArray asTraitComposition
]

{ #category : #accessing }
GtBehaviorCreationForm >> traits [

	^ traits
]

{ #category : #accessing }
GtBehaviorCreationForm >> traits: anObject [

	traits := anObject
]

{ #category : #accessing }
GtBehaviorCreationForm >> traitsDescription [
	<magritteDescription>
	^ MAToManyRelationDescription new
		label: 'Traits';
		priority: 5;
		accessor: #traits;
		classes: {String};
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		blocListStencil: (self
				taggerStencilWithCompletion: GtClassesCompletionStrategy new
				andContextMenuBlock: nil)
]
