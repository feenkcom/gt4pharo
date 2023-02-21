Class {
	#name : #GtClassUpdateForm,
	#superclass : #GtClassCreationForm,
	#instVars : [
		'classSlots'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Forms - Models'
}

{ #category : #accessing }
GtClassUpdateForm class >> isAdditionForm [
	^ false
]

{ #category : #accessing }
GtClassUpdateForm class >> onClass: aClass [
	^ self new onClass: aClass
]

{ #category : #accessing }
GtClassUpdateForm >> abstractClassVariable: varName [
	| aModel aClass |
	aModel := self createRefactoringModel.
	aClass := (self modelClassFrom: aModel) classSide.

	^ RBAbstractInstanceVariableRefactoring
		model: aModel
		variable: varName
		class: aClass
]

{ #category : #accessing }
GtClassUpdateForm >> abstractVariable: varName [
	| aModel aClass |
	aModel := self createRefactoringModel.
	aClass := self modelClassFrom: aModel.

	^ RBAbstractInstanceVariableRefactoring
		model: aModel
		variable: varName
		class: aClass
]

{ #category : #accessing }
GtClassUpdateForm >> classSlots [
	^ classSlots
]

{ #category : #accessing }
GtClassUpdateForm >> classSlots: anObject [
	classSlots := anObject
]

{ #category : #accessing }
GtClassUpdateForm >> classSlotsDescription [
	<magritteDescription>
	^ MAToManyRelationDescription new
		label: 'Class Slots';
		priority: 10;
		accessor: #classSlots;
		classes: {String};
		labelStyler: #glamorousFormLabelStyle;
		blocListStencil: (self taggerStencilWithCompletion: nil andContextMenuBlock: [ :aVariable :anElement | self createSlotsContextMenuContentFor: aVariable editor: self ]);
		addCondition: [ :aValue | aValue asSet size = aValue size ]
			labelled: 'All slot names must be unique'
]

{ #category : #accessing }
GtClassUpdateForm >> classVarsDescription [
	<magritteDescription>
	^ super classVarsDescription
		blocListStencil: (self
				taggerStencilWithCompletion: nil
				andContextMenuBlock: [ :aVariable :anElement | self createClassVarsContextMenuContentFor: aVariable editor: self ])
]

{ #category : #accessing }
GtClassUpdateForm >> commit [
	| aClass |
	aClass := newClassName asClass.
	aClass classSide slots
		do: [ :aSlot | (RBRemoveInstanceVariableChange remove: aSlot name from: aClass classSide) execute ].
	aClass := super commit.

	classSlots
		do: [ :aSlot | (RBAddInstanceVariableChange add: aSlot to: aClass classSide) execute ].
	^ aClass
]

{ #category : #accessing }
GtClassUpdateForm >> createClassSlotsContextMenuContentFor: aSlotName editor: anElement [
	| theContextMenu items |
	theContextMenu := GtCoderContextMenuContent new editorElement: anElement.
	items := OrderedCollection new.
	items
		addAll: {GtCoderContextMenuAction new
					action: [ self executeRefactoring: (self pushUpClassSlotRefactoringFor: aSlotName) ];
					title: (self createLabelTextFor: 'Push up ' description: aSlotName).
				GtCoderContextMenuAction new
					action: [ self executeRefactoring: (self pushDownClassSlotRefactoringFor: aSlotName) ];
					title: (self createLabelTextFor: 'Push down ' description: aSlotName).
				GtCoderContextMenuAction new
					action: [ self executeRefactoring: (self generateClassAccessorsFor: aSlotName) ];
					title: (self createLabelTextFor: 'Create accessors for ' description: aSlotName).
				GtCoderContextMenuAction new
					action: [ self executeRefactoring: (self abstractClassVariable: aSlotName) ];
					title: (self createLabelTextFor: 'Abstract ' description: aSlotName).
				GtCoderContextMenuAction new
					action: [ self executeRefactoring: (self protectClassVariable: aSlotName) ];
					title: (self createLabelTextFor: 'Protect ' description: aSlotName)}.
	theContextMenu items: items.
	^ theContextMenu
]

{ #category : #accessing }
GtClassUpdateForm >> createClassVarsContextMenuContentFor: aClassVarName editor: anElement [
	| theContextMenu items |
	theContextMenu := GtCoderContextMenuContent new editorElement: anElement.
	items := OrderedCollection new.
	items
		addAll: {GtCoderContextMenuAction new
					action: [ self
							executeRefactoring: (self pushUpClassVariableRefactoringFor: aClassVarName) ];
					title: 'Push up ' , aClassVarName.
				GtCoderContextMenuAction new
					action: [ self
							executeRefactoring: (self pushDownClassVariableRefactoringFor: aClassVarName) ];
					title: 'Push down ' , aClassVarName.
				GtCoderContextMenuAction new
					action: [ self
							executeRefactoring: (self generateAccessorsFor: aClassVarName asClassVar: true) ];
					title: 'Create accessors for ' , aClassVarName}.
	theContextMenu items: items.
	^ theContextMenu
]

{ #category : #accessing }
GtClassUpdateForm >> createLabelTextFor: aString description: description [
	^ aString asRopedText glamorousRegularFont
		, ((' ' , description) asRopedText
				glamorousCodeFont;
				foreground: Color gray;
				glamorousCodeTinySize)
]

{ #category : #accessing }
GtClassUpdateForm >> createRefactoringModel [
	^ RBClassModelFactory rbNamespace onEnvironment: RBBrowserEnvironment new
]

{ #category : #accessing }
GtClassUpdateForm >> createSlotsContextMenuContentFor: aSlotName editor: anElement [
	| theContextMenu items |
	theContextMenu := GtCoderContextMenuContent new editorElement: anElement.
	items := OrderedCollection new.
	items
		addAll: {GtCoderContextMenuAction new
					action: [ self executeRefactoring: (self pushUpSlotRefactoringFor: aSlotName) ];
					title: (self createLabelTextFor: 'Push up ' description: aSlotName).
				GtCoderContextMenuAction new
					action: [ self executeRefactoring: (self pushDownSlotRefactoringFor: aSlotName) ];
					title: (self createLabelTextFor: 'Push down ' description: aSlotName).
				GtCoderContextMenuAction new
					action: [ self
							executeRefactoring: (self generateAccessorsFor: aSlotName asClassVar: false) ];
					title: (self createLabelTextFor: 'Create accessors for ' description: aSlotName).
				GtCoderContextMenuAction new
					action: [ self executeRefactoring: (self abstractVariable: aSlotName) ];
					title: (self createLabelTextFor: 'Abstract ' description: aSlotName).
				GtCoderContextMenuAction new
					action: [ self executeRefactoring: (self protectVariable: aSlotName) ];
					title: (self createLabelTextFor: 'Protect ' description: aSlotName)}.
	theContextMenu items: items.
	^ theContextMenu
]

{ #category : #accessing }
GtClassUpdateForm >> definitionString [
	| aStream aPackage |
	aStream := (String new: 800) writeStream.
	aStream nextPutAll: self superclassName.

	aStream
		nextPutAll: ' subclass: ';
		store: self rawClassName asSymbol.

	self traits isEmpty
		ifFalse: [ aStream
				cr;
				tab;
				nextPutAll: 'uses: ';
				nextPutAll: (' + ' join: self traits) ].
	aStream
		cr;
		tab;
		nextPutAll: 'instanceVariableNames: ';
		store: (' ' join: self slots).	"Class vars"
	aStream
		cr;
		tab;
		nextPutAll: 'classVariableNames: ';
		store: (' ' join: self classVars).	"Pool Dictionaries"
	aStream
		cr;
		tab;
		nextPutAll: 'poolDictionaries: ';
		store: (' ' join: self pools).

	aPackage := self commitPackage.

	aStream
		cr;
		tab;
		nextPutAll: 'package: ';
		store: aPackage categoryName asString.

	^ aStream contents
]

{ #category : #accessing }
GtClassUpdateForm >> executeRefactoring: refactoring [
	[ refactoring execute ]
		on: RBRefactoringError
		do: [ :ex | 
			| message |
			message := ex messageText.
			(message endsWith: 'Browse references?')
				ifTrue: [ message := message allButLast: 18 ].
			self inform: message ]
]

{ #category : #accessing }
GtClassUpdateForm >> generateAccessorsFor: varName asClassVar: aBoolean [
	| aModel aClass |
	aModel := self createRefactoringModel.
	aClass := self modelClassFrom: aModel.

	^ RBCreateAccessorsForVariableRefactoring
		model: aModel
		variable: varName
		class: aClass
		classVariable: aBoolean
]

{ #category : #accessing }
GtClassUpdateForm >> generateClassAccessorsFor: varName [
	| aModel aClass |
	aModel := self createRefactoringModel.
	aClass := (self modelClassFrom: aModel) classSide.

	^ RBCreateAccessorsForVariableRefactoring
		model: aModel
		variable: varName
		class: aClass
		classVariable: false
]

{ #category : #accessing }
GtClassUpdateForm >> initialize [
	super initialize.
	
	classSlots := OrderedCollection new.
]

{ #category : #accessing }
GtClassUpdateForm >> modelClassFrom: aModel [
	^ aModel classNamed: self newClassName asString asSymbol
]

{ #category : #accessing }
GtClassUpdateForm >> nameDescription [
	^ nil
]

{ #category : #accessing }
GtClassUpdateForm >> onClass: aClass [
	self newClassName: aClass name.
	self superclassName: aClass superclass name.
	self slots: (aClass slots collect: #name).
	self traits: (aClass traits collect: #name).
	self
		packageAndTagName: (GtPackageAndTagName new
				packageName: aClass package name;
				tagName: (aClass package classTagForClass: aClass) name).
	self pools: (aClass sharedPools collect: #name).
	self classVars: (aClass classVarNames collect: #asString).
	self classSlots: (aClass classSide slots collect: #name).
]

{ #category : #accessing }
GtClassUpdateForm >> protectClassVariable: varName [
	| aModel aClass |
	aModel := self createRefactoringModel.
	aClass := (self modelClassFrom: aModel) classSide.

	^ RBProtectInstanceVariableRefactoring
		model: aModel
		variable: varName
		class: aClass
]

{ #category : #accessing }
GtClassUpdateForm >> protectVariable: varName [
	| aModel aClass |
	aModel := self createRefactoringModel.
	aClass := self modelClassFrom: aModel.

	^ RBProtectInstanceVariableRefactoring
		model: aModel
		variable: varName
		class: aClass
]

{ #category : #accessing }
GtClassUpdateForm >> pushDownClassSlotRefactoringFor: varName [
	| aModel aClass |
	aModel := self createRefactoringModel.
	aClass := (self modelClassFrom: aModel) classSide.

	^ RBPushDownInstanceVariableRefactoring
		model: aModel
		variable: varName
		class: aClass
]

{ #category : #accessing }
GtClassUpdateForm >> pushDownClassVariableRefactoringFor: varName [ 
	| aModel aClass |
	aModel := self createRefactoringModel.
	aClass := self modelClassFrom: aModel.

	^ RBPushDownClassVariableRefactoring
		model: aModel
		variable: varName
		class: aClass
]

{ #category : #accessing }
GtClassUpdateForm >> pushDownSlotRefactoringFor: varName [
	| aModel aClass |
	aModel := self createRefactoringModel.
	aClass := self modelClassFrom: aModel.

	^ RBPushDownInstanceVariableRefactoring
		model: aModel
		variable: varName
		class: aClass
]

{ #category : #accessing }
GtClassUpdateForm >> pushUpClassSlotRefactoringFor: varName [
	| aModel aClass |
	aModel := self createRefactoringModel.
	aClass := (self modelClassFrom: aModel) classSide.

	^ RBPullUpInstanceVariableRefactoring
		model: aModel
		variable: varName
		class: aClass superclass
]

{ #category : #accessing }
GtClassUpdateForm >> pushUpClassVariableRefactoringFor: varName [ 
	| aModel aClass |
	aModel := self createRefactoringModel.
	aClass := self modelClassFrom: aModel.

	^ RBPullUpClassVariableRefactoring
		model: aModel
		variable: varName
		class: aClass superclass
]

{ #category : #accessing }
GtClassUpdateForm >> pushUpSlotRefactoringFor: varName [
	| aModel aClass |
	aModel := self createRefactoringModel.
	aClass := self modelClassFrom: aModel.

	^ RBPullUpInstanceVariableRefactoring
		model: aModel
		variable: varName
		class: aClass superclass
]

{ #category : #accessing }
GtClassUpdateForm >> slotsDescription [
	<magritteDescription>
	^ super slotsDescription
		blocListStencil: (self
				taggerStencilWithCompletion: nil
				andContextMenuBlock: [ :aVariable :anElement | self createSlotsContextMenuContentFor: aVariable editor: self ])
]

{ #category : #accessing }
GtClassUpdateForm >> textualCoderViewModel [
	"Hack to use context menus"
	^self
]
