"
Executable specifications for SUnit to gtExample conversion using isolated refactoring models.
"
Class {
	#name : #GtSUnitToExamplesRefactoringExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-GtRefactorings-Examples'
}

{ #category : #examples }
GtSUnitToExamplesRefactoringExamples >> basicConversion [
	<gtExample>
	| model source target tree |
	model := GtRBNamespace new.
	model
		defineClass: 'TestCase subclass: #GtConversionSourceTest instanceVariableNames: ''a b'' classVariableNames: '''' package: ''SUnit-Conversion-Fixtures'''.
	source := model classNamed: #GtConversionSourceTest.
	source compile: 'setUp super setUp. a := 42. b := a + 1' classified: #running.
	source
		compile: 'testSomething self assert: a equals: 42. self assert: b equals: 43'
		classified: #tests.
	(GtSUnitToExamplesRefactoring
		model: model
		from: source name
		to: #GtConversionTargetExamples) execute.
	target := model classNamed: #GtConversionTargetExamples.
	self assert: target superclass name equals: #Object.
	self
		assert: (target parseTreeForSelector: #a)
		equals: (RBParser parseMethod: 'a ^ a ifNil: [ a := 42 ]').
	self
		assert: (target parseTreeForSelector: #b)
		equals: (RBParser parseMethod: 'b ^ b ifNil: [ b := self a + 1 ]').
	tree := target parseTreeForSelector: #something.
	self assert: (tree hasPragmaNamed: #gtExample).
	self
		assert: tree
		equals: (RBParser
				parseMethod: 'something <gtExample> self assert: self a equals: 42. self assert: self b equals: 43').
	self assert: (source directlyDefinesMethod: #testSomething).
	^ model
]

{ #category : #examples }
GtSUnitToExamplesRefactoringExamples >> firstAssignmentAndUninitializedSlot [
	<gtExample>
	| model source target |
	model := GtRBNamespace new.
	model
		defineClass: 'TestCase subclass: #GtConversionFirstTest instanceVariableNames: ''a b c'' classVariableNames: '''' package: ''SUnit-Conversion-Fixtures'''.
	source := model classNamed: #GtConversionFirstTest.
	source compile: 'setUp a := 42. a := 99. b := a' classified: #running.
	source compile: 'testValue self assert: a equals: 99' classified: #tests.
	(GtSUnitToExamplesRefactoring
		model: model
		from: source name
		to: #GtConversionFirstExamples) execute.
	target := model classNamed: #GtConversionFirstExamples.
	self
		assert: (target parseTreeForSelector: #a)
		equals: (RBParser parseMethod: 'a ^ a ifNil: [ a := 42 ]').
	self
		assert: (target parseTreeForSelector: #b)
		equals: (RBParser parseMethod: 'b ^ b ifNil: [ b := self a ]').
	self
		assert: (target parseTreeForSelector: #c)
		equals: (RBParser parseMethod: 'c ^ c ifNil: [ c := nil ]').
	^ model
]

{ #category : #examples }
GtSUnitToExamplesRefactoringExamples >> rejectsUnsupportedSetup [
	<gtExample>
	| model source before rejected |
	model := GtRBNamespace new.
	model
		defineClass: 'TestCase subclass: #GtConversionUnsafeTest instanceVariableNames: ''a'' classVariableNames: '''' package: ''SUnit-Conversion-Fixtures'''.
	source := model classNamed: #GtConversionUnsafeTest.
	source compile: 'setUp a := 1. Transcript cr' classified: #running.
	before := model changes changesSize.
	rejected := false.
	[ (GtSUnitToExamplesRefactoring
		model: model
		from: source name
		to: #GtConversionUnsafeExamples) execute ]
		on: Error
		do: [ :error | rejected := true ].
	self assert: rejected.
	self assert: model changes changesSize equals: before.
	self assert: (model classNamed: #GtConversionUnsafeExamples) isNil.
	^ model
]

{ #category : #examples }
GtSUnitToExamplesRefactoringExamples >> setupSelfSends [
	<gtExample>
	| model source target |
	model := GtRBNamespace new.
	model
		defineClass: 'TestCase subclass: #GtConversionHelperTest instanceVariableNames: ''a b'' classVariableNames: '''' package: ''SUnit-Conversion-Fixtures'''.
	source := model classNamed: #GtConversionHelperTest.
	source compile: 'setUp super setUp. self initializeValues' classified: #running.
	source
		compile: 'initializeValues self initializeA: 40. b := self valueForB'
		classified: #helpers.
	source
		compile: 'initializeA: number | value | value := number + 2. a := value'
		classified: #helpers.
	source compile: 'valueForB ^ a + 1' classified: #helpers.
	source compile: 'testValue self assert: b equals: 43' classified: #tests.
	(GtSUnitToExamplesRefactoring
		model: model
		from: source name
		to: #GtConversionHelperExamples) execute.
	target := model classNamed: #GtConversionHelperExamples.
	self
		assert: (target parseTreeForSelector: #a)
		equals: (RBParser parseMethod: 'a ^ a ifNil: [ a := 40 + 2 ]').
	self
		assert: (target parseTreeForSelector: #b)
		equals: (RBParser parseMethod: 'b ^ b ifNil: [ b := self valueForB ]').
	self
		assert: (target parseTreeForSelector: #valueForB)
		equals: (RBParser parseMethod: 'valueForB ^ self a + 1').
	^ model
]

{ #category : #examples }
GtSUnitToExamplesRefactoringExamples >> setupTemporariesAreInlined [
	<gtExample>
	| model source target original |
	model := GtRBNamespace new.
	model
		defineClass: 'TestCase subclass: #GtConversionTemporaryTest instanceVariableNames: ''a b'' classVariableNames: '''' package: ''SUnit-Conversion-Fixtures'''.
	source := model classNamed: #GtConversionTemporaryTest.
	original := 'setUp | first second | super setUp. first := 40. second := first + 2. a := second. b := a + second'.
	source compile: original classified: #running.
	source compile: 'testValue self assert: a equals: 42' classified: #tests.
	(GtSUnitToExamplesRefactoring
		model: model
		from: source name
		to: #GtConversionTemporaryExamples) execute.
	target := model classNamed: #GtConversionTemporaryExamples.
	self
		assert: (target parseTreeForSelector: #a)
		equals: (RBParser parseMethod: 'a ^ a ifNil: [ a := 40 + 2 ]').
	self
		assert: (target parseTreeForSelector: #b)
		equals: (RBParser parseMethod: 'b ^ b ifNil: [ b := self a + (40 + 2) ]').
	self
		assert: (source parseTreeForSelector: #setUp)
		equals: (RBParser parseMethod: 'setUp super setUp. a := 40 + 2. b := a + (40 + 2)').
	self assert: (model classNamed: #GtSUnitSetupInliningScratch) isNil.
	^ model
]

{ #category : #examples }
GtSUnitToExamplesRefactoringExamples >> shadowingAndWrites [
	<gtExample>
	| model source target |
	model := GtRBNamespace new.
	model
		defineClass: 'TestCase subclass: #GtConversionScopeTest instanceVariableNames: ''a'' classVariableNames: '''' package: ''SUnit-Conversion-Fixtures'''.
	source := model classNamed: #GtConversionScopeTest.
	source compile: 'setUp a := 42' classified: #running.
	source
		compile: 'testWrite a := a + 1. self assert: a equals: 43'
		classified: #tests.
	source
		compile: 'testShadow | a | a := 7. self assert: a equals: 7. #(1) do: [ :a | self assert: a equals: 1 ]'
		classified: #tests.
	(GtSUnitToExamplesRefactoring
		model: model
		from: source name
		to: #GtConversionScopeExamples) execute.
	target := model classNamed: #GtConversionScopeExamples.
	self
		assert: (target parseTreeForSelector: #write)
		equals: (RBParser
				parseMethod: 'write <gtExample> a := self a + 1. self assert: self a equals: 43').
	self
		assert: (target parseTreeForSelector: #shadow)
		equals: (RBParser
				parseMethod: 'shadow <gtExample> | a | a := 7. self assert: a equals: 7. #(1) do: [ :a | self assert: a equals: 1 ]').
	^ model
]
