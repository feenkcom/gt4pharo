Class {
	#name : #GtBehaviorCreationForm,
	#superclass : #GtPharoCreationForm,
	#instVars : [
		'traits',
		'slots',
		'newClassName',
		'classSlots'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Forms - Models'
}

{ #category : #accessing }
GtBehaviorCreationForm class >> componentName [
	^ self subclassResponsibility
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
		label: 'Class-side slots';
		priority: 7;
		accessor: #classSlots;
		classes: {String};
		labelAptitude: [ (BrGlamorousLabelAptitude new glamorousFormLabelStyle) + (BrGlamorousWithExplicitTooltipAptitude text: 'Variables whose values are shared across all instances of a class and that class itself. Subclasses allocate their own memory for the class-side vars of the superclasses and don''t inherit their values.') ];
		blocListStencil: (self taggerStencilWithCompletion: nil andContextMenuBlock: nil);
		addCondition: [ :aValue | aValue asSet size = aValue size ]
			labelled: 'All slot names must be unique'
]

{ #category : #accessing }
GtBehaviorCreationForm >> createTraitsContextMenuContentFor: aTrait editor: anElement [
	| theContextMenu items |
	theContextMenu := GtFormContextMenuContent new editorElement: anElement.
	items := OrderedCollection new.
	items
		addAll: {GtCoderContextMenuAction new
					action: [ :form :elem | elem phlow spawnObject: (Smalltalk at: aTrait asSymbol) users ];
					title: 'Browse users' asText}.
	theContextMenu items: items.
	^ theContextMenu
]

{ #category : #accessing }
GtBehaviorCreationForm >> defaultName [
	^ ''
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
	| changes |
	classSlots isEmpty ifTrue: [ ^ self ].
	changes := classSlots
			collect: [ :aSlot | RBAddInstanceVariableChange add: aSlot to: aClass classSide ].
	(RBCompositeRefactoryChange new
		name: 'Add class slots';
		changes: changes;
		yourself) gtExecuteWithUndo
]

{ #category : #magritte }
GtBehaviorCreationForm >> nameDescription [
	<magritteDescription>
	^ GtMATextDescription new
		label: 'Name';
		beRequired;
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
		label: 'Instance-side slots';
		priority: 6;
		accessor: #slots;
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle +  (BrGlamorousWithExplicitTooltipAptitude text: 'Variables whose value is scoped to an instance of a class.')];
		classes: {String};
		blocListStencil: (self taggerStencilWithCompletion: nil andContextMenuBlock: nil);
		addCondition: [ :aValue | aValue asSet size = aValue size ]
			labelled: 'All slot names must be unique'
]

{ #category : #accessing }
GtBehaviorCreationForm >> traitClassesOrNils [
	"Return collection of Traits. If a Trait does not exist, `nil` value is used."

	<return: #Collection of: #Trait>
	^ self traitClassesOrNilsFor: self traits
]

{ #category : #accessing }
GtBehaviorCreationForm >> traitClassesOrNilsFor: aCollectionOfTraitNames [
	"Return collection of Traits. If a Trait does not exist, `nil` value is used."

	<return: #Collection of: #Trait>
	^ aCollectionOfTraitNames
		collect: [ :eachTraitName | Smalltalk classOrTraitNamed: eachTraitName asString trimBoth ]
]

{ #category : #accessing }
GtBehaviorCreationForm >> traitComposition [
	^ self traitCompositionFor: self traitClassesOrNils
]

{ #category : #accessing }
GtBehaviorCreationForm >> traitCompositionFor: aCollectionOfTraits [
	^ (aCollectionOfTraits reject: #isNil) asArray asTraitComposition
]

{ #category : #accessing }
GtBehaviorCreationForm >> traits [
	<return: #Collection of: #String>
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
				andContextMenuBlock: [ :aTrait :anElement :aMemento | 
					aMemento overallStatus valueOrNil isChanged
						ifTrue: [ GtCoderContextMenuContent new editorElement: anElement ]
						ifFalse: [ self createTraitsContextMenuContentFor: aTrait editor: anElement ] ]);
		blocShortcuts: [ {BlShortcutWithAction new
					name: 'Browse trait';
					description: 'Browses the trait indicated by the editor';
					combination: BlKeyCombination primaryB;
					action: [ :anEvent | 
						anEvent target phlow
							spawnTool: (GtClassCoderTool forClass: anEvent target text asString asClass) ].
				BlShortcutWithAction new
					name: 'Inspect trait';
					description: 'Inspects the trait indicated by the editor';
					combination: BlKeyCombination primaryG;
					action: [ :anEvent | anEvent target phlow spawnObject: anEvent target text asString asClass ].
				BlShortcutWithAction new
					name: 'Browse trait references';
					description: 'Browses references to the trait indicated by the editor';
					combination: BlKeyCombination primaryN;
					action: [ :anEvent | 
						anEvent target phlow
							spawnObject: anEvent target text asString asClass gtReferences ]} ];
		addCondition: [ :aValue | aValue asSet size = aValue size ]
			labelled: 'All Trait names must be unique';
		addCondition: [ :aValue | 
				aValue
					allSatisfy: [ :eachTraitName | (Smalltalk classOrTraitNamed: eachTraitName asString trim) isNotNil ] ]
			labelled: 'Unknown Trait(s)';
		addCondition: [ :aValue | 
				| givenTraitsOrNils |
				givenTraitsOrNils := self traitClassesOrNilsFor: aValue.
				givenTraitsOrNils allSatisfy: [ :each | each isNil or: [ each isTrait ] ] ]
			labelled: 'Only Traits are allowed';
		addCondition: [ :aValue | 
				aValue size > 1
					ifTrue: [ | givenTraits aTraitComposition |
						givenTraits := self traitClassesOrNilsFor: aValue.

						((givenTraits allSatisfy: #isNotNil)
							and: [ givenTraits size = givenTraits asSet size ])
							ifTrue: [ aTraitComposition := self traitCompositionFor: givenTraits.
								aTraitComposition methods
									allSatisfy: [ :each | (aTraitComposition isConflictingSelector: each selector) not ] ]
							ifFalse: [ true ] ]
					ifFalse: [ true ] ]
			labelled: 'Conflicting Traits'
]
