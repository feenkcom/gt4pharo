Class {
	#name : #GtBehaviorUpdateForm,
	#superclass : #GtClassCreationForm,
	#category : #'GToolkit-Pharo-Coder-UI-Forms - Models'
}

{ #category : #accessing }
GtBehaviorUpdateForm class >> isAdditionForm [
	^ false
]

{ #category : #accessing }
GtBehaviorUpdateForm >> abstractClassVariable: varName [
	| aModel aClass |
	aModel := self createRefactoringModel.
	aClass := (self modelClassFrom: aModel) classSide.

	^ RBAbstractInstanceVariableRefactoring
		model: aModel
		variable: varName
		class: aClass
]

{ #category : #accessing }
GtBehaviorUpdateForm >> abstractVariable: varName [
	| aModel aClass |
	aModel := self createRefactoringModel.
	aClass := self modelClassFrom: aModel.

	^ RBAbstractInstanceVariableRefactoring
		model: aModel
		variable: varName
		class: aClass
]

{ #category : #accessing }
GtBehaviorUpdateForm >> classSlotsDescription [
	<magritteDescription>
	^ super classSlotsDescription
		blocListStencil: (self
				taggerStencilWithCompletion: nil
				andContextMenuBlock: [ :aVariable :anElement | self createSlotsContextMenuContentFor: aVariable editor: self ])
]

{ #category : #accessing }
GtBehaviorUpdateForm >> classVarsDescription [
	<magritteDescription>
	^ super classVarsDescription
		blocListStencil: (self
				taggerStencilWithCompletion: nil
				andContextMenuBlock: [ :aVariable :anElement | self createClassVarsContextMenuContentFor: aVariable editor: self ])
]

{ #category : #accessing }
GtBehaviorUpdateForm >> commit [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtBehaviorUpdateForm >> createClassSlotsContextMenuContentFor: aSlotName editor: anElement [
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
GtBehaviorUpdateForm >> createClassVarsContextMenuContentFor: aClassVarName editor: anElement [
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
GtBehaviorUpdateForm >> createLabelTextFor: aString description: description [
	^ aString asRopedText glamorousRegularFont
		, ((' ' , description) asRopedText
				glamorousCodeFont;
				foreground: Color gray;
				glamorousCodeTinySize)
]

{ #category : #accessing }
GtBehaviorUpdateForm >> createRefactoringModel [
	^ RBClassModelFactory rbNamespace onEnvironment: RBBrowserEnvironment new
]

{ #category : #accessing }
GtBehaviorUpdateForm >> createSlotsContextMenuContentFor: aSlotName editor: anElement [
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
GtBehaviorUpdateForm >> definitionString [
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
GtBehaviorUpdateForm >> executeRefactoring: refactoring [
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
GtBehaviorUpdateForm >> generateAccessorsFor: varName asClassVar: aBoolean [
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
GtBehaviorUpdateForm >> generateClassAccessorsFor: varName [
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
GtBehaviorUpdateForm >> initialize [
	super initialize.
	
	classSlots := OrderedCollection new.
]

{ #category : #accessing }
GtBehaviorUpdateForm >> modelClassFrom: aModel [
	^ aModel classNamed: self newClassName asString asSymbol
]

{ #category : #accessing }
GtBehaviorUpdateForm >> nameDescription [
	^ nil
]

{ #category : #accessing }
GtBehaviorUpdateForm >> protectClassVariable: varName [
	| aModel aClass |
	aModel := self createRefactoringModel.
	aClass := (self modelClassFrom: aModel) classSide.

	^ RBProtectInstanceVariableRefactoring
		model: aModel
		variable: varName
		class: aClass
]

{ #category : #accessing }
GtBehaviorUpdateForm >> protectVariable: varName [
	| aModel aClass |
	aModel := self createRefactoringModel.
	aClass := self modelClassFrom: aModel.

	^ RBProtectInstanceVariableRefactoring
		model: aModel
		variable: varName
		class: aClass
]

{ #category : #accessing }
GtBehaviorUpdateForm >> pushDownClassSlotRefactoringFor: varName [
	| aModel aClass |
	aModel := self createRefactoringModel.
	aClass := (self modelClassFrom: aModel) classSide.

	^ RBPushDownInstanceVariableRefactoring
		model: aModel
		variable: varName
		class: aClass
]

{ #category : #accessing }
GtBehaviorUpdateForm >> pushDownClassVariableRefactoringFor: varName [ 
	| aModel aClass |
	aModel := self createRefactoringModel.
	aClass := self modelClassFrom: aModel.

	^ RBPushDownClassVariableRefactoring
		model: aModel
		variable: varName
		class: aClass
]

{ #category : #accessing }
GtBehaviorUpdateForm >> pushDownSlotRefactoringFor: varName [
	| aModel aClass |
	aModel := self createRefactoringModel.
	aClass := self modelClassFrom: aModel.

	^ RBPushDownInstanceVariableRefactoring
		model: aModel
		variable: varName
		class: aClass
]

{ #category : #accessing }
GtBehaviorUpdateForm >> pushUpClassSlotRefactoringFor: varName [
	| aModel aClass |
	aModel := self createRefactoringModel.
	aClass := (self modelClassFrom: aModel) classSide.

	^ RBPullUpInstanceVariableRefactoring
		model: aModel
		variable: varName
		class: aClass superclass
]

{ #category : #accessing }
GtBehaviorUpdateForm >> pushUpClassVariableRefactoringFor: varName [ 
	| aModel aClass |
	aModel := self createRefactoringModel.
	aClass := self modelClassFrom: aModel.

	^ RBPullUpClassVariableRefactoring
		model: aModel
		variable: varName
		class: aClass superclass
]

{ #category : #accessing }
GtBehaviorUpdateForm >> pushUpSlotRefactoringFor: varName [
	| aModel aClass |
	aModel := self createRefactoringModel.
	aClass := self modelClassFrom: aModel.

	^ RBPullUpInstanceVariableRefactoring
		model: aModel
		variable: varName
		class: aClass superclass
]

{ #category : #accessing }
GtBehaviorUpdateForm >> slotsDescription [
	<magritteDescription>
	^ super slotsDescription
		blocListStencil: (self
				taggerStencilWithCompletion: nil
				andContextMenuBlock: [ :aVariable :anElement | self createSlotsContextMenuContentFor: aVariable editor: self ])
]

{ #category : #accessing }
GtBehaviorUpdateForm >> textualCoderViewModel [
	"Hack to use context menus"
	^self
]
