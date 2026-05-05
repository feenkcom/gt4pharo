"
I am a refactoring for rename class variables.

I rename the class variable in the class definition and in all methods refering to this variable.

My precondition verifies that the new variable is valid and not yet used in the whole class hierarchy.
"
Class {
	#name : #RBRenameClassVariableRefactoring,
	#superclass : #RBVariableRefactoring,
	#instVars : [
		'newName'
	],
	#category : #'GToolkit-Pharo-BaseRefactorings-Refactorings'
}

{ #category : #'instance creation' }
RBRenameClassVariableRefactoring class >> model: aRBSmalltalk rename: aVarName to: aName in: aClass [
	^ self new
		model: aRBSmalltalk;
		rename: aVarName
			to: aName
			in: aClass;
		yourself
]

{ #category : #'instance creation' }
RBRenameClassVariableRefactoring class >> rename: aVarName to: aName in: aClass [
	^ self new
		rename: aVarName
		to: aName
		in: aClass
]

{ #category : #preconditions }
RBRenameClassVariableRefactoring >> applicabilityPreconditions [
	| conds |
	conds := OrderedCollection new.
	conds add: (RBCondition isMetaclass: class) not.
	conds add: (RBCondition isValidClassVarName: newName asString for: class).
	conds add: (RBCondition definesClassVariable: variableName asString in: class).
	conds
		add: (RBCondition hierarchyOf: class definesVariable: newName asString) not.
	conds add: (RBCondition isGlobal: newName asString in: self model) not.
	^ self applicabilityPreconditionsFor: conds
]

{ #category : #transforming }
RBRenameClassVariableRefactoring >> basicTransform [
	class
		renameClassVariable: variableName
		to: newName
		around: [ self renameReferences ]
]

{ #category : #'gt - extensions' }
RBRenameClassVariableRefactoring >> gtDescription [
	<return: #String or: #BlRunRopedText>
	
	^ ('Rename' asRopedText glamorousRoundedBackground)
		append: ' class variable ' asRopedText;
		append: variableName asRopedText glamorousRoundedBackground;
		append: ' to ' asRopedText;
		append: newName asRopedText glamorousRoundedBackground;
		append: ' in ' asRopedText;
		append: class name asRopedText
]

{ #category : #accessing }
RBRenameClassVariableRefactoring >> newName [
	^ newName
]

{ #category : #accessing }
RBRenameClassVariableRefactoring >> newName: anObject [
	newName := anObject
]

{ #category : #transforming }
RBRenameClassVariableRefactoring >> privateTransform [
	self basicTransform
]

{ #category : #initialization }
RBRenameClassVariableRefactoring >> rename: aVarName to: aName in: aClass [
	self variable: aVarName class: aClass.
	newName := aName
]

{ #category : #transforming }
RBRenameClassVariableRefactoring >> renameReferences [
	| replacer methods |
	replacer := self parseTreeRewriterClass
		rename: variableName
		to: newName
		handler:
			[ self refactoringError: ('<1s> is already defined as a method or block temporary <n> variable in this class or one of its subclasses' expandMacrosWith: newName) ].

	methods := class methodsUsingClassVariableNamed: variableName.
	methods do: [ :method | self convertMethod: method selector for: method modelClass using: replacer ]
]

{ #category : #printing }
RBRenameClassVariableRefactoring >> storeOn: aStream [
	aStream nextPut: $(.
	self class storeOn: aStream.
	aStream
		nextPutAll: ' rename: ''';
		nextPutAll: variableName;
		nextPutAll: ''' to: ''';
		nextPutAll: newName;
		nextPutAll: ''' in: '.
	class storeOn: aStream.
	aStream nextPut: $)
]

{ #category : #transforming }
RBRenameClassVariableRefactoring >> transform [
	self basicTransform
]
