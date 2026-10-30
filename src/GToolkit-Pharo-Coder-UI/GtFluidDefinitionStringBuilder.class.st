"
I build a fluid definition of a class (`Superclass << #Name …`) or a trait (`Trait << #Name …`) from names, as entered in the class and trait forms, including the class-side slots.
The names do not describe everything a definition has. ${method:GtFluidDefinitionStringBuilder>>#fillFromBehavior:}$ copies it from an existing class or trait, as strings, into my `existing…` slots: the layout, the definitions of the slots and class-side slots (such as `#cache => WeakSlot`) and the trait composition with its exclusions and aliases. The definition keeps them for the names that are still there. I do not keep a reference to the class or trait.
See ${class:GtFluidDefinitionStringBuilderExamples}$.
"
Class {
	#name : #GtFluidDefinitionStringBuilder,
	#superclass : #Object,
	#instVars : [
		'className',
		'superclassName',
		'isTrait',
		'traitNames',
		'slotNames',
		'sharedVariableNames',
		'sharedPoolNames',
		'classSlotNames',
		'tagName',
		'packageName',
		'existingLayoutName',
		'existingSlotDefinitions',
		'existingClassSlotDefinitions',
		'existingTraitNames',
		'existingTraitComposition'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Forms - Models'
}

{ #category : #accessing }
GtFluidDefinitionStringBuilder >> beTrait [
	isTrait := true
]

{ #category : #accessing }
GtFluidDefinitionStringBuilder >> className: aString [
	className := aString
]

{ #category : #accessing }
GtFluidDefinitionStringBuilder >> classSlotNames: aCollectionOfStrings [
	classSlotNames := aCollectionOfStrings ifNil: [ #() ]
]

{ #category : #building }
GtFluidDefinitionStringBuilder >> definitionString [
	"Answer a fluid definition, such as Object << #Name slots: { #a }; package: 'Package'.
	Each part ends with ;, except the package, which is always written last"

	^ String
		streamContents: [ :aStream |
			self writeHeaderOn: aStream.
			isTrait ifFalse: [ self writeLayoutOn: aStream ].
			self writeTraitsOn: aStream.
			self writeSlotsOn: aStream.
			isTrait ifFalse: [ 
					self writeSharedVariablesOn: aStream.
					self writeSharedPoolsOn: aStream ].
			self writeClassSlotsOn: aStream.
			self writeTagOn: aStream.
			self writePackageOn: aStream ]
]

{ #category : #private }
GtFluidDefinitionStringBuilder >> definitionsFrom: someAssociations [
	| someDefinitions |
	someDefinitions := OrderedDictionary new.
	someAssociations do: [ :each | 
		someDefinitions at: each key asSymbol put: each value asString ].
	^ someDefinitions
]

{ #category : #private }
GtFluidDefinitionStringBuilder >> definitionsOf: someNames in: someDefinitions [
	"Answer the definition of the existing slot with the same name, so that its kind is kept
	(#cache => WeakSlot), or a plain slot"

	^ someNames collect: [ :each | 
			someDefinitions 
				at: each asSymbol 
				ifAbsent: [ each asSymbol printString ] ]
]

{ #category : #private }
GtFluidDefinitionStringBuilder >> definitionsOfSlots: someSlots definedIn: aBehavior [
	^ (someSlots select: [ :each | each definingClass == aBehavior ])
			collect: [ :each | each name -> each definitionString ]
]

{ #category : #private }
GtFluidDefinitionStringBuilder >> existingBehaviorItems [
	"Answer what is kept from the existing class or trait, as triples of what, name and definition"

	| someItems |
	someItems := OrderedCollection new.
	
	existingLayoutName ifNotNil: [ :aName | 
		someItems add: {'layout'. ''. aName} ].
	existingTraitComposition ifNotNil: [ :aString | 
		someItems add: {'trait composition'. ' ' join: existingTraitNames. aString} ].
	existingSlotDefinitions keysAndValuesDo: [ :aName :aDefinition | 
		someItems add: {'slot'. aName. aDefinition} ].
	existingClassSlotDefinitions keysAndValuesDo: [ :aName :aDefinition | 
		someItems add: {'class-side slot'. aName. aDefinition} ].
		
	^ someItems
]

{ #category : #'accessing - existing behavior' }
GtFluidDefinitionStringBuilder >> existingClassSlotDefinitions [
	"Answer the definitions of the existing class-side slots by name"

	^ existingClassSlotDefinitions
]

{ #category : #'accessing - existing behavior' }
GtFluidDefinitionStringBuilder >> existingClassSlotDefinitions: someAssociations [
	existingClassSlotDefinitions := self definitionsFrom: someAssociations
]

{ #category : #'accessing - existing behavior' }
GtFluidDefinitionStringBuilder >> existingLayoutName [
	"Answer the name of the layout of the existing class, or nil for a fixed layout"

	^ existingLayoutName
]

{ #category : #'accessing - existing behavior' }
GtFluidDefinitionStringBuilder >> existingLayoutName: aString [
	existingLayoutName := aString asString
]

{ #category : #'accessing - existing behavior' }
GtFluidDefinitionStringBuilder >> existingSlotDefinitions [
	"Answer the definitions of the existing slots by name, such as #w -> '#w => WeakSlot'"

	^ existingSlotDefinitions
]

{ #category : #'accessing - existing behavior' }
GtFluidDefinitionStringBuilder >> existingSlotDefinitions: someAssociations [
	existingSlotDefinitions := self definitionsFrom: someAssociations
]

{ #category : #'accessing - existing behavior' }
GtFluidDefinitionStringBuilder >> existingTraitComposition [
	"Answer the trait composition of the existing class or trait, such as 'T - {#m}', or nil without traits"

	^ existingTraitComposition
]

{ #category : #'accessing - existing behavior' }
GtFluidDefinitionStringBuilder >> existingTraitNames [
	^ existingTraitNames
]

{ #category : #'accessing - existing behavior' }
GtFluidDefinitionStringBuilder >> existingTraitNames: someNames composition: aString [
	"The composition is used when the trait names are the same"

	existingTraitNames := someNames collect: [ :each | each asString ] as: Array.
	existingTraitComposition := aString
]

{ #category : #'accessing - existing behavior' }
GtFluidDefinitionStringBuilder >> fillFromBehavior: aBehavior [
	"Copy from aBehavior what the names do not describe, so that the definition keeps it:
	its layout, the definitions of its slots and class-side slots, and its trait composition.
	Only strings are kept, not aBehavior"

	(aBehavior isTrait or: [ aBehavior classLayout class = FixedLayout ])
		ifFalse: [ self existingLayoutName: aBehavior classLayout class name ].
		
	self 
		existingSlotDefinitions: (self 
			definitionsOfSlots: aBehavior slots definedIn: aBehavior);
		existingClassSlotDefinitions: (self 
			definitionsOfSlots: aBehavior classSide slots definedIn: aBehavior classSide).
			
	aBehavior traits
		ifNotEmpty: [ :someTraits |
			self
				existingTraitNames: (someTraits collect: [ :each | each name ] as: Array)
				composition: aBehavior traitComposition printString ]
]

{ #category : #views }
GtFluidDefinitionStringBuilder >> gtDefinitionFor: aView [
	<gtView>
	
	className ifNil: [ ^ aView empty ].
	^ aView textEditor
		title: 'Definition';
		priority: 5;
		aptitude: BrGlamorousCodeEditorAptitude;
		styler: (BrRBTextStyler new
				isForWorkspace: true;
				yourself);
		text: [ self definitionString ]
]

{ #category : #views }
GtFluidDefinitionStringBuilder >> gtExistingBehaviorFor: aView [
	<gtView>
	
	self hasExistingBehavior ifFalse: [ ^ aView empty ].
	
	^ aView columnedList
		title: 'Existing behavior';
		priority: 10;
		items: [ self existingBehaviorItems ];
		column: 'Kept'
			text: [ :each | each first ]
			width: 130;
		column: 'Name'
			text: [ :each | each second ]
			width: 150;
		column: 'Definition' text: [ :each | each third ]
]

{ #category : #'accessing - existing behavior' }
GtFluidDefinitionStringBuilder >> hasExistingBehavior [
	^ existingLayoutName notNil
		or: [ existingTraitComposition notNil
				or: [ existingSlotDefinitions notEmpty 
					or: [ existingClassSlotDefinitions notEmpty ] ] ]
]

{ #category : #initialization }
GtFluidDefinitionStringBuilder >> initialize [
	super initialize.
	
	superclassName := 'Object'.
	isTrait := false.
	traitNames := #().
	slotNames := #().
	sharedVariableNames := #().
	sharedPoolNames := #().
	classSlotNames := #().
	existingSlotDefinitions := OrderedDictionary new.
	existingClassSlotDefinitions := OrderedDictionary new.
	existingTraitNames := #()
]

{ #category : #accessing }
GtFluidDefinitionStringBuilder >> isTrait [
	^ isTrait
]

{ #category : #accessing }
GtFluidDefinitionStringBuilder >> packageName: aString [
	packageName := aString
]

{ #category : #accessing }
GtFluidDefinitionStringBuilder >> sharedPoolNames: aCollectionOfStrings [
	sharedPoolNames := aCollectionOfStrings ifNil: [ #() ]
]

{ #category : #accessing }
GtFluidDefinitionStringBuilder >> sharedVariableNames: aCollectionOfStrings [
	sharedVariableNames := aCollectionOfStrings ifNil: [ #() ]
]

{ #category : #accessing }
GtFluidDefinitionStringBuilder >> slotNames: aCollectionOfStrings [
	slotNames := aCollectionOfStrings ifNil: [ #() ]
]

{ #category : #accessing }
GtFluidDefinitionStringBuilder >> superclassName: aStringOrNil [
	superclassName := aStringOrNil
]

{ #category : #accessing }
GtFluidDefinitionStringBuilder >> tagName: aStringOrNil [
	tagName := aStringOrNil
]

{ #category : #accessing }
GtFluidDefinitionStringBuilder >> traitNames: aCollectionOfStrings [
	traitNames := aCollectionOfStrings ifNil: [ #() ]
]

{ #category : #writing }
GtFluidDefinitionStringBuilder >> write: aKeyword elements: someStrings on: aStream [
	aStream
		crtab;
		nextPutAll: aKeyword;
		nextPutAll: ' {'.
	someStrings
		do: [ :each |
			aStream
				space;
				nextPutAll: each ]
		separatedBy: [ aStream nextPutAll: ' .' ].
	aStream nextPutAll: ' };'
]

{ #category : #writing }
GtFluidDefinitionStringBuilder >> writeClassSlotsOn: aStream [
	self
		write: 'classSlots:'
		elements: (self definitionsOf: classSlotNames in: existingClassSlotDefinitions)
		on: aStream
]

{ #category : #writing }
GtFluidDefinitionStringBuilder >> writeHeaderOn: aStream [
	aStream
		nextPutAll: (isTrait 
			ifTrue: [ 'Trait' ] 
			ifFalse: [ (superclassName ifNil: [ 'nil' ]) asString ]);
		nextPutAll: ' << ';
		print: className asSymbol
]

{ #category : #writing }
GtFluidDefinitionStringBuilder >> writeLayoutOn: aStream [
	"Nothing for a fixed layout"

	existingLayoutName ifNil: [ ^ self ].
	aStream
		crtab;
		nextPutAll: 'layout: ';
		nextPutAll: existingLayoutName;
		nextPut: $;
]

{ #category : #writing }
GtFluidDefinitionStringBuilder >> writePackageOn: aStream [
	aStream
		crtab;
		nextPutAll: 'package: ';
		print: packageName asString
]

{ #category : #writing }
GtFluidDefinitionStringBuilder >> writeSharedPoolsOn: aStream [
	self
		write: 'sharedPools:'
		elements: (sharedPoolNames collect: [ :each | each asString ])
		on: aStream
]

{ #category : #writing }
GtFluidDefinitionStringBuilder >> writeSharedVariablesOn: aStream [
	self
		write: 'sharedVariables:'
		elements: (sharedVariableNames collect: [ :each | each asSymbol printString ])
		on: aStream
]

{ #category : #writing }
GtFluidDefinitionStringBuilder >> writeSlotsOn: aStream [
	self
		write: 'slots:'
		elements: (self definitionsOf: slotNames in: existingSlotDefinitions)
		on: aStream
]

{ #category : #writing }
GtFluidDefinitionStringBuilder >> writeTagOn: aStream [
	"Nothing for no tag, the root tag and a tag named like the package"

	(tagName isEmptyOrNil
		or: [ tagName asString = packageName asString
				or: [ tagName asString = Package rootTagName asString ] ]) ifTrue: [ ^ self ].
	aStream
		crtab;
		nextPutAll: 'tag: ';
		print: tagName asString;
		nextPut: $;
]

{ #category : #writing }
GtFluidDefinitionStringBuilder >> writeTraitsOn: aStream [
	"The existing composition is kept if the traits are the same,
	so that exclusions and aliases are not lost"

	| someNames |
	someNames := traitNames collect: [ :each | each asString trimBoth ] as: Array.
	someNames ifEmpty: [ ^ self ].
	aStream
		crtab;
		nextPutAll: 'traits: '.
	(existingTraitComposition notNil and: [ existingTraitNames = someNames ])
		ifTrue: [ aStream nextPutAll: existingTraitComposition ]
		ifFalse: [ someNames
				do: [ :each | aStream nextPutAll: each ]
				separatedBy: [ aStream nextPutAll: ' + ' ] ].
	aStream nextPut: $;
]
