Class {
	#name : #GtChildrenToSiblingsRefactoringExamples,
	#superclass : #Object,
	#instVars : [
		'environment'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Examples'
}

{ #category : #examples }
GtChildrenToSiblingsRefactoringExamples >> changeAllSubclasses [
	<gtExample>
	<after: #cleanUp>
	| refactoring realClass subclass |
	self setUp.
	realClass := self realClass.
	subclass := realClass subclasses first.
	refactoring := GtChildrenToSiblingsRefactoring
			name: self newClassName
			class: realClass
			subclasses: {subclass}.
	refactoring primitiveExecute.
	refactoring model changes gtExecuteWithUndo.
	self assert: realClass superclass name equals: self newClassName.
	self assert: realClass subclasses isEmpty.
	self assert: realClass superclass subclasses size equals: 2.
	self assert: realClass superclass classSide instVarNames size equals: 1.
	self assert: subclass superclass name equals: self newClassName.
	self
		assert: (realClass selectors allSatisfy: [ :each | subclass selectors includes: each ]).
	self
		assert: (realClass classSide selectors
				allSatisfy: [ :each | subclass classSide selectors includes: each ]).
	^ refactoring model
]

{ #category : #examples }
GtChildrenToSiblingsRefactoringExamples >> changeNoSubclasses [
	<gtExample>
	<after: #cleanUp>
	| refactoring realClass subclass |
	self setUp.
	realClass := self realClass.
	subclass := realClass subclasses first.
	refactoring := GtChildrenToSiblingsRefactoring
			name: self newClassName
			class: realClass
			subclasses: {}.
	refactoring primitiveExecute.
	refactoring model changes gtExecuteWithUndo.
	self assert: realClass superclass name equals: self newClassName.
	self assert: realClass subclasses size equals: 1.
	self assert: realClass superclass subclasses size equals: 1.
	self assert: realClass superclass classSide instVarNames size equals: 1.
	self assert: subclass superclass equals: realClass.
	self assert: realClass selectors isEmpty.
	self assert: realClass classSide selectors isEmpty.
	^ refactoring model
]

{ #category : #private }
GtChildrenToSiblingsRefactoringExamples >> cleanUp [
	environment ifNotNil: [ :anEnvironment | anEnvironment removeFromSystem ]
]

{ #category : #private }
GtChildrenToSiblingsRefactoringExamples >> newClassName [
	^ #CONVERT_TO_SIBLING_TEST
]

{ #category : #private }
GtChildrenToSiblingsRefactoringExamples >> realClass [
	| rootClass |
	rootClass := environment anyDummyRootClass.
	^ rootClass realClass
]

{ #category : #private }
GtChildrenToSiblingsRefactoringExamples >> setUp [
	environment := GtPharoDummiesGenerator withPackages: 1 classHierarchy: 2.
	self realClass classSide
		addInstVarNamed: 'asdf';
		compile: 'asdf ^asdf' classified: #accessing
]

{ #category : #examples }
GtChildrenToSiblingsRefactoringExamples >> undoChangeAllSubclasses [
	<gtExample>
	<after: #cleanUp>
	| realClass |
	self changeAllSubclasses.
	GtRefactoryChangeManager instance undoChange.
	realClass := self realClass.
	self assert: realClass superclass name equals: #Object.
	self assert: realClass subclasses size equals: 1.
	self assert: realClass classSide instVarNames size equals: 1
]

{ #category : #examples }
GtChildrenToSiblingsRefactoringExamples >> undoChangeNoSubclasses [
	<gtExample>
	<after: #cleanUp>
	| realClass |
	self changeNoSubclasses.
	GtRefactoryChangeManager instance undoChange.
	realClass := self realClass.
	self assert: realClass superclass name equals: #Object.
	self assert: realClass subclasses size equals: 1.
	self assert: realClass classSide instVarNames size equals: 1
]
