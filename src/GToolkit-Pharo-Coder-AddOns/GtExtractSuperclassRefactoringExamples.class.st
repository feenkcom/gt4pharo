Class {
	#name : #GtExtractSuperclassRefactoringExamples,
	#superclass : #Object,
	#instVars : [
		'ignore'
	],
	#classVars : [
		'Ignore'
	],
	#classInstVars : [
		'ignore'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-Examples'
}

{ #category : #accessing }
GtExtractSuperclassRefactoringExamples >> badClassName [
	<gtExample>
	| model refactoring |
	model := GtRBNamespace new.
	refactoring := GtExtractSuperclassRefactoring
			model: model
			addClass: #'T est'
			superclass: self class superclass
			subclasses: {self class}
			category: self class category.
	[ refactoring primitiveExecute ] on: RBRefactoringError do: [ :ex | ^ ex ].
	self error: 'Refactoring should fail'
]

{ #category : #accessing }
GtExtractSuperclassRefactoringExamples >> emptyClass [
	<gtExample>
	| model refactoring class |
	model := GtRBNamespace new.
	refactoring := GtExtractSuperclassRefactoring
			model: model
			addClass: #NewClassName
			superclass: Object
			subclasses: {self class.
					GtRBNamespaceExamples}
			category: self class category.
	refactoring primitiveExecute.
	
	"There is nothing common between the two classes to push up"
	class := model classNamed: #NewClassName.
	self assert: class selectors isEmpty.
	self assert: class classSide selectors isEmpty.
	self assert: class instanceVariableNames isEmpty.
	self assert: class classSide instanceVariableNames isEmpty.
	self assert: class classVariableNames isEmpty.
	self assert: (model classFor: self class) superclass equals: class.
	self assert: (model classFor: GtRBNamespaceExamples) superclass equals: class.
	self assert: class superclass equals: (model classFor: Object).
	^ model
]

{ #category : #accessing }
GtExtractSuperclassRefactoringExamples >> extractSuperclass [
	<gtExample>
	| model refactoring classA classB class |
	model := GtRBNamespace new.
	model
		performChange: (RBCompositeRefactoryChange named: 'Setup')
		around: [ model
				defineClass: 'Object subclass: #ClassA instanceVariableNames: ''a common'' classVariableNames: ''A Common'' poolDictionaries: '''' category: ''GToolkit-Pharo-Coder-AddOns-Examples'''.
			classA := model classNamed: #ClassA.
			classA classSide
				addInstanceVariable: 'aCIV';
				addInstanceVariable: 'commonCIV'.
			classA compile: 'a ^a' classified: #(accessing).
			classA compile: 'common ^common' classified: #(accessing).
			classA compile: 'classVar ^Common' classified: #(accessing).
			classA classSide compile: 'aCIV ^aCIV' classified: #(accessing).
			classA classSide compile: 'commonCIV ^commonCIV' classified: #(accessing).
			classA classSide compile: 'csClassVar ^Common' classified: #(accessing).
			model
				defineClass: 'Object subclass: #ClassB instanceVariableNames: ''b common'' classVariableNames: ''B Common'' poolDictionaries: '''' category: ''GToolkit-Pharo-Coder-AddOns-Examples'''.
			classB := model classNamed: #ClassB.
			classB classSide
				addInstanceVariable: 'bCIV';
				addInstanceVariable: 'commonCIV'.
			classB compile: 'b ^b' classified: #(accessing).
			classB compile: 'common ^common' classified: #(accessing).
			classB compile: 'classVar ^Common' classified: #(accessing).
			classB classSide compile: 'bCIV ^bCIV' classified: #(accessing).
			classB classSide compile: 'commonCIV ^commonCIV' classified: #(accessing).
			classB classSide compile: 'csClassVar ^Common' classified: #(accessing) ].
	refactoring := GtExtractSuperclassRefactoring
			model: model
			addClass: #NewClassName
			superclass: Object
			subclasses: {classA.
					classB}
			category: self class category.
	refactoring primitiveExecute.
	class := model classNamed: #NewClassName.
	self assert: class instanceVariableNames asArray equals: #('common').
	self
		assert: class classSide instanceVariableNames asArray
		equals: #('commonCIV').
	self assert: class classVariableNames isEmpty.
	self assert: classA superclass equals: class.
	self assert: classB superclass equals: class.
	self assert: class superclass equals: (model classFor: Object).
	self
		assert: (class methodFor: #common) ast
		equals: (RBParser parseMethod: 'common ^common').
	self
		assert: (class methodFor: #classVar) ast
		equals: (RBParser parseMethod: 'classVar ^ self subclassResponsibility').
	self assert: (classA directlyDefinesMethod: #a).
	self assert: (classB directlyDefinesMethod: #b).
	self
		assert: (class classSide methodFor: #commonCIV) ast
		equals: (RBParser parseMethod: 'commonCIV ^commonCIV').
	self
		assert: (class classSide methodFor: #csClassVar) ast
		equals: (RBParser parseMethod: 'csClassVar ^ self subclassResponsibility').
	self assert: (classA classSide directlyDefinesMethod: #aCIV).
	self assert: (classB classSide directlyDefinesMethod: #bCIV).
	self assert: (classA directlyDefinesMethod: #classVar).
	self assert: (classB directlyDefinesMethod: #classVar).
	self assert: (classA classSide directlyDefinesMethod: #csClassVar).
	self assert: (classB classSide directlyDefinesMethod: #csClassVar).
	^ model
]

{ #category : #accessing }
GtExtractSuperclassRefactoringExamples >> invalidSubclasses [
	<gtExample>
	| model refactoring |
	model := GtRBNamespace new.
	refactoring := GtExtractSuperclassRefactoring
			model: model
			addClass: #NewClassName
			superclass: self class superclass
			subclasses: {self class.
					OrderedCollection}
			category: self class category.
	[ refactoring primitiveExecute ] on: RBRefactoringError do: [ :ex | ^ ex ].
	self error: 'Refactoring should fail'
]
