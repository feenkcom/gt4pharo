Class {
	#name : #GtClassCreationForm,
	#superclass : #GtBehaviorCreationForm,
	#instVars : [
		'superclassName',
		'classVars',
		'pools'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Forms - Models'
}

{ #category : #accessing }
GtClassCreationForm class >> componentName [
	^ 'Class'
]

{ #category : #accessing }
GtClassCreationForm class >> priority [
	^ 1
]

{ #category : #accessing }
GtClassCreationForm >> classDefinitionString [
	^ String
		streamContents: [ :stream | 
			stream << self superclassName << ' subclass: '
				<< self rawClassName asSymbol storeString.

			self traits ifNotEmpty: [ 
				stream << ' uses: ' << (' + ' join: self traits) ].

			stream 
				<< ' instanceVariableNames: ' << (' ' join: self slots) storeString
				<< ' classVariableNames: ' << (' ' join: self classVars) storeString
				<< ' poolDictionaries: ' << (' ' join: self pools) storeString
				<< ' category: ' << self commitPackage categoryName asString storeString ]
]

{ #category : #accessing }
GtClassCreationForm >> classVars [

	^ classVars
]

{ #category : #accessing }
GtClassCreationForm >> classVars: anObject [

	classVars := anObject
]

{ #category : #accessing }
GtClassCreationForm >> classVarsDescription [
	<magritteDescription>
	^ MAToManyRelationDescription new
		label: 'Class vars';
		priority: 8;
		accessor: #classVars;
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle
				+ (BrGlamorousWithExplicitTooltipAptitude
						text: 'Variables whose values (memory) is shared across all instances of a class and its subclasses.') ];
		classes: {String};
		blocListStencil: (self
				taggerStencilWithCompletion: nil
				contextMenuContentBlock: nil
				contextMenuBlock: nil)
]

{ #category : #accessing }
GtClassCreationForm >> commit [
	| aClass |
	self defineClass.
	aClass := Smalltalk classNamed: self rawClassName.
	self installClassSlotsOn: aClass.
	^ aClass
]

{ #category : #accessing }
GtClassCreationForm >> contextMenuItemsForSuperclass [
	^ {'Browse references'
			-> [ :aBrEditor | aBrEditor phlow spawnObject: aBrEditor text asString asClass gtReferences ]}
]

{ #category : #accessing }
GtClassCreationForm >> defaultName [
	^ 'NameOfSubclass'
]

{ #category : #accessing }
GtClassCreationForm >> defineClass [
	(GtRBAddClassChange definitionString: self classDefinitionString)
		gtExecuteWithUndo
]

{ #category : #'api - initialization' }
GtClassCreationForm >> fillFormWithClass: aClass [
	super fillFormWithClass: aClass.
	aClass isClass ifTrue: [ self superclassName: aClass name ].
	aClass isTrait ifTrue: [ self traits: {aClass name} ]
]

{ #category : #accessing }
GtClassCreationForm >> initialize [
	super initialize.

	self superclassName: 'Object'.

	classVars := OrderedCollection new.
	pools := OrderedCollection new
]

{ #category : #accessing }
GtClassCreationForm >> pools [

	^ pools
]

{ #category : #accessing }
GtClassCreationForm >> pools: anObject [

	pools := anObject
]

{ #category : #accessing }
GtClassCreationForm >> poolsDescription [
	<magritteDescription>
	^ MAToManyRelationDescription new
		label: 'Shared var. pools';
		priority: 10;
		accessor: #pools;
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		classes: {String};
		blocListStencil: (self
				taggerStencilWithCompletion: GtPoolsCompletionStrategy new
				contextMenuContentBlock: nil
				contextMenuBlock: nil)
]

{ #category : #accessing }
GtClassCreationForm >> superclassContextMenuFor: aClassName editor: anEditorElement [
	<return: #BrMenuItems or: nil>
	| aClass |
	aClass := Smalltalk at: aClassName asSymbol ifAbsent: [ ^ nil ].

	^ GtCoderClassTarget
		menuItemsForObject: aClass
		hostElement: anEditorElement
]

{ #category : #accessing }
GtClassCreationForm >> superclassDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Superclass';
		priority: 2;
		default: '';
		accessor: #superclassName;
		blocCompletion: [ GtStringsCompletionStrategy new
				completions: GtPharoIndex current classNameTree ];
		blocShortcuts: [ {BlShortcutWithAction new
					name: 'Browse class';
					description: 'Browses the class indicated by the editor';
					combination: BlKeyCombination primaryB;
					action: [ :anEvent | 
						anEvent target phlow
							spawnTool: (GtClassCoderTool forClass: anEvent target text asString asClass) ].
				BlShortcutWithAction new
					name: 'Inspect class';
					description: 'Inspects the class indicated by the editor';
					combination: BlKeyCombination primaryG;
					action: [ :anEvent | anEvent target phlow spawnObject: anEvent target text asString asClass ].
				BlShortcutWithAction new
					name: 'Browse class references';
					description: 'Browses references to the class indicated by the editor';
					combination: BlKeyCombination primaryN;
					action: [ :anEvent | 
						anEvent target phlow
							spawnObject: anEvent target text asString asClass gtReferences ]} ];
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize
				+ (BrGlamorousWithExplicitContextMenuAptitude new
						stencil: [ :aBrMenuInitialContext | 
							BrMenuExplicitHandle new
								submenu: [ self
										superclassContextMenuFor: aBrMenuInitialContext anchorElement text asString
										editor: aBrMenuInitialContext anchorElement ] ]) ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		addCondition: [ :aValue | (Smalltalk classNamed: aValue trim) isNotNil ]
			labelled: 'Unknown class';
		addCondition: [ :aValue | 
				| aClass |
				aClass := Smalltalk classNamed: aValue trim.
				aClass isNil or: [ aClass isClass ] ]
			labelled: 'Must be a class';
		addCondition: [ :aValue | 
				| aClass |
				aClass := Smalltalk classNamed: aValue trim.
				aClass isNil or: [ aClass isInstanceSide ] ]
			labelled: 'Must be an instance-side class';
		beRequired
]

{ #category : #accessing }
GtClassCreationForm >> superclassName [

	^ superclassName
]

{ #category : #accessing }
GtClassCreationForm >> superclassName: anObject [

	superclassName := anObject
]
