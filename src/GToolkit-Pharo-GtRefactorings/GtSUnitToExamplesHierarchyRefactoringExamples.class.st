"
Examples for hierarchy wiring, inherited slot reads, closed input validation and staging failure isolation.
"
Class {
	#name : #GtSUnitToExamplesHierarchyRefactoringExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-GtRefactorings-Examples'
}

{ #category : #examples }
GtSUnitToExamplesHierarchyRefactoringExamples >> classSideMethodsSurviveHierarchyConversion [
	<gtExample>
	| model base child targetBase targetChild targetLeaf |
	model := self hierarchyModel.
	base := model classNamed: #GtHierarchyBaseTest.
	child := model classNamed: #GtHierarchyChildTest.
	base classSide
		compile: 'isAbstract ^ self = GtHierarchyBaseTest'
		classified: #testing.
	base classSide compile: 'answer ^ 42' classified: #accessing.
	child classSide compile: 'answer ^ super answer + 1' classified: #accessing.
	(GtSUnitToExamplesHierarchyRefactoring
		model: model
		classMapping: self hierarchyMapping) primitiveExecute.
	targetBase := model classNamed: #GtHierarchyBaseExamples.
	targetChild := model classNamed: #GtHierarchyChildExamples.
	targetLeaf := model classNamed: #GtHierarchyLeafExamples.
	self assert: (targetBase classSide directlyDefinesMethod: #isAbstract) not.
	self
		assert: (targetBase classSide sourceCodeFor: #answer)
		equals: (base classSide sourceCodeFor: #answer).
	self
		assert: (targetChild classSide sourceCodeFor: #answer)
		equals: (child classSide sourceCodeFor: #answer).
	self
		assert: (targetChild classSide protocolsFor: #answer)
		equals: (child classSide protocolsFor: #answer).
	self
		assert: (targetLeaf classSide whichClassIncludesSelector: #answer)
				== targetChild classSide.
	self
		assert: (base classSide sourceCodeFor: #isAbstract)
		equals: 'isAbstract ^ self = GtHierarchyBaseTest'.
	^ model
]

{ #category : #examples }
GtSUnitToExamplesHierarchyRefactoringExamples >> classesConstructorAcceptsTestsOrOtherNames [
	<gtExample>
	| model classes refactoring |
	model := GtRBNamespace new.
	model
		defineClass: 'TestCase subclass: #GtHierarchyTestTests instanceVariableNames: '''' classVariableNames: '''' package: ''SUnit-Conversion-Fixtures'''.
	model
		defineClass: 'TestCase subclass: #GtHierarchyTestFixture instanceVariableNames: '''' classVariableNames: '''' package: ''SUnit-Conversion-Fixtures'''.
	classes := #(#GtHierarchyTestTests #GtHierarchyTestFixture)
			collect: [ :name | model classNamed: name ].
	refactoring := GtSUnitToExamplesHierarchyRefactoring
			model: model
			classes: classes.
	refactoring primitiveExecute.
	self assert: (model classNamed: #GtHierarchyExamples) notNil.
	self assert: (model classNamed: #GtHierarchyTestFixtureExamples) notNil.
	^ refactoring
]

{ #category : #examples }
GtSUnitToExamplesHierarchyRefactoringExamples >> classesConstructorDerivesTargetNames [
	<gtExample>
	| model classes refactoring |
	model := self hierarchyModel.
	classes := #(#GtHierarchyLeafTest #GtHierarchyChildTest #GtHierarchyBaseTest)
			collect: [ :name | model classNamed: name ].
	refactoring := GtSUnitToExamplesHierarchyRefactoring
			model: model
			classes: classes.
	refactoring primitiveExecute.
	self
		assert: (model classNamed: #GtHierarchyBaseExamples) superclass name
		equals: #Object.
	self
		assert: (model classNamed: #GtHierarchyChildExamples) superclass name
		equals: #GtHierarchyBaseExamples.
	self
		assert: (model classNamed: #GtHierarchyLeafExamples) superclass name
		equals: #GtHierarchyChildExamples.
	^ refactoring
]

{ #category : #examples }
GtSUnitToExamplesHierarchyRefactoringExamples >> duplicateTargetsAbortInPreconditions [
	<gtExample>
	| model before refactoring rejected |
	model := self hierarchyModel.
	before := model changes changes asArray.
	refactoring := GtSUnitToExamplesHierarchyRefactoring
			model: model
			classMapping: (Dictionary new
					at: #GtHierarchyBaseTest put: #GtHierarchySameExamples;
					at: #GtHierarchyChildTest put: #GtHierarchySameExamples;
					yourself).
	rejected := false.
	[ refactoring primitiveExecute ]
		on: RBRefactoringError
		do: [ :error | rejected := true ].
	self assert: rejected.
	self assert: model changes changes asArray equals: before.
	self assert: (model classNamed: #GtHierarchySameExamples) isNil.
	^ refactoring
]

{ #category : #examples }
GtSUnitToExamplesHierarchyRefactoringExamples >> generatedHierarchyExecutes [
	<gtExample>
	| refactoring model runtimeClasses |
	refactoring := self preservesHierarchyAndSource.
	model := refactoring model.
	runtimeClasses := Dictionary new.
	refactoring orderedSourceNames
		do: [ :name | 
			| target parent runtime |
			target := model classNamed: (self hierarchyMapping at: name).
			parent := target superclass name = #Object
					ifTrue: [ Object ]
					ifFalse: [ runtimeClasses at: target superclass name ].
			runtime := Smalltalk anonymousClassInstaller
					make: [ :builder | 
						builder
							superclass: parent;
							slots: (target instanceVariableNames collect: [ :slot | slot asSymbol ]).
						parent = Object ifTrue: [ builder traitComposition: TAssertable ] ].
			target localSelectors
				do: [ :selector | runtime compile: (target sourceCodeFor: selector) classified: #examples ].
			runtimeClasses at: target name put: runtime ].
	(runtimeClasses at: #GtHierarchyBaseExamples) new perform: #base.
	(runtimeClasses at: #GtHierarchyChildExamples) new perform: #child.
	(runtimeClasses at: #GtHierarchyLeafExamples) new perform: #leaf.
	(runtimeClasses at: #GtHierarchySiblingExamples) new perform: #base.
	self
		assert: ((runtimeClasses at: #GtHierarchyChildExamples) new perform: #helper)
		equals: 43.
	(runtimeClasses at: #GtHierarchyLeafExamples) new
		should: [ Error signal: 'expected' ]
		raise: Error.
	^ refactoring
]

{ #category : #fixtures }
GtSUnitToExamplesHierarchyRefactoringExamples >> hierarchyMapping [
	^ Dictionary new
		at: #GtHierarchyLeafTest put: #GtHierarchyLeafExamples;
		at: #GtHierarchySiblingTest put: #GtHierarchySiblingExamples;
		at: #GtHierarchyChildTest put: #GtHierarchyChildExamples;
		at: #GtHierarchyBaseTest put: #GtHierarchyBaseExamples;
		yourself
]

{ #category : #examples }
GtSUnitToExamplesHierarchyRefactoringExamples >> hierarchyModel [
	<gtExample>
	| model base child leaf |
	model := GtRBNamespace new.
	model
		defineClass: 'TestCase subclass: #GtHierarchyBaseTest instanceVariableNames: ''a'' classVariableNames: '''' package: ''SUnit-Conversion-Fixtures'''.
	model
		defineClass: 'GtHierarchyBaseTest subclass: #GtHierarchyChildTest instanceVariableNames: ''b'' classVariableNames: '''' package: ''SUnit-Conversion-Fixtures'''.
	model
		defineClass: 'GtHierarchyChildTest subclass: #GtHierarchyLeafTest instanceVariableNames: ''c'' classVariableNames: '''' package: ''SUnit-Conversion-Fixtures'''.
	model
		defineClass: 'GtHierarchyBaseTest subclass: #GtHierarchySiblingTest instanceVariableNames: '''' classVariableNames: '''' package: ''SUnit-Conversion-Fixtures'''.
	base := model classNamed: #GtHierarchyBaseTest.
	base compile: 'setUp super setUp. a := 42' classified: #running.
	base compile: 'helper ^ a + 1' classified: #helpers.
	base compile: 'testBase self assert: a equals: 42' classified: #tests.
	child := model classNamed: #GtHierarchyChildTest.
	child
		compile: 'setUp | value | super setUp. value := a + 1. b := value'
		classified: #running.
	child
		compile: 'testChild self assert: a equals: 42. self assert: b equals: 43'
		classified: #tests.
	leaf := model classNamed: #GtHierarchyLeafTest.
	leaf compile: 'setUp super setUp. c := b + 1' classified: #running.
	leaf compile: 'testLeaf self assert: c equals: 44' classified: #tests.
	^ model
]

{ #category : #examples }
GtSUnitToExamplesHierarchyRefactoringExamples >> missingParentAbortsInPreconditions [
	<gtExample>
	| model refactoring before rejected |
	model := self hierarchyModel.
	model
		defineClass: 'Object subclass: #GtHierarchyBaseExamples instanceVariableNames: ''a'' classVariableNames: '''' package: ''SUnit-Conversion-Fixtures'''.
	before := model changes changes asArray.
	refactoring := GtSUnitToExamplesHierarchyRefactoring
			model: model
			classMapping: (Dictionary new
					at: #GtHierarchyChildTest put: #GtHierarchyChildExamples;
					yourself).
	self assert: refactoring failedApplicabilityPreconditions notEmpty.
	rejected := false.
	[ refactoring primitiveExecute ]
		on: RBRefactoringError
		do: [ :error | rejected := true ].
	self assert: rejected.
	self assert: model changes changes asArray equals: before.
	self assert: (model classNamed: #GtHierarchyChildExamples) isNil.
	^ refactoring
]

{ #category : #examples }
GtSUnitToExamplesHierarchyRefactoringExamples >> preservesHierarchyAndSource [
	<gtExample>
	| model mapping originals before refactoring base child leaf sibling definitions |
	model := self hierarchyModel.
	mapping := self hierarchyMapping.
	originals := Dictionary new.
	mapping
		keysDo: [ :name | 
			| source snapshot |
			source := model classNamed: name.
			snapshot := Dictionary new.
			source localSelectors
				do: [ :selector | snapshot at: selector put: (source sourceCodeFor: selector) ].
			originals at: name put: snapshot ].
	before := model changes changes asArray.
	refactoring := GtSUnitToExamplesHierarchyRefactoring
			model: model
			classMapping: mapping.
	refactoring primitiveExecute.
	base := model classNamed: #GtHierarchyBaseExamples.
	child := model classNamed: #GtHierarchyChildExamples.
	leaf := model classNamed: #GtHierarchyLeafExamples.
	sibling := model classNamed: #GtHierarchySiblingExamples.
	self assert: base superclass name equals: #Object.
	self assert: child superclass == base.
	self assert: leaf superclass == child.
	self assert: sibling superclass == base.
	self assert: child instanceVariableNames asArray equals: #('b').
	self assert: leaf instanceVariableNames asArray equals: #('c').
	self
		assert: (child parseTreeForSelector: #theB)
		equals: (RBParser parseMethod: 'theB ^ b ifNil: [ b := self theA + 1 ]').
	self
		assert: (leaf parseTreeForSelector: #theC)
		equals: (RBParser parseMethod: 'theC ^ c ifNil: [ c := self theB + 1 ]').
	self
		assert: (child parseTreeForSelector: #child)
		equals: (RBParser
				parseMethod: 'child <gtExample> <after: #tearDown> self assert: self theA equals: 42. self assert: self theB equals: 43').
	self assert: (child directlyDefinesMethod: #theA) not.
	self assert: sibling localSelectors isEmpty.
	self assert: (sibling canUnderstand: #base).
	originals
		keysAndValuesDo: [ :name :snapshot | 
			snapshot
				keysAndValuesDo: [ :selector :code | self assert: ((model classNamed: name) sourceCodeFor: selector) equals: code ] ].
	self assert: (model changes changes asArray first: before size) equals: before.
	self assert: model changes changes size equals: before size + 1.
	definitions := model changes changes last changes
			select: [ :change | change isKindOf: GtRBAddClassChange ].
	self assert: definitions size equals: mapping size.
	self assert: definitions first changeClassName equals: #GtHierarchyBaseExamples.
	self
		assert: (definitions first definitionString includesSubstring: 'uses: TAssertable').
	self
		assert: (definitions allButFirst
				allSatisfy: [ :change | (change definitionString includesSubstring: 'uses:') not ]).
	^ refactoring
]

{ #category : #examples }
GtSUnitToExamplesHierarchyRefactoringExamples >> unsupportedChildDoesNotPublishChanges [
	<gtExample>
	| model source original before message refactoring |
	model := self hierarchyModel.
	source := model classNamed: #GtHierarchyLeafTest.
	original := 'setUp super setUp. c := 9. Transcript cr'.
	source compile: original classified: #running.
	before := model changes changes asArray.
	refactoring := GtSUnitToExamplesHierarchyRefactoring
			model: model
			classMapping: self hierarchyMapping.
	message := nil.
	[ refactoring primitiveExecute ]
		on: Error
		do: [ :error | message := error messageText ].
	self
		assert: message
		equals: 'Expanded setUp must contain only direct slot assignments and super setUp'.
	self assert: model changes changes asArray equals: before.
	self hierarchyMapping
		valuesDo: [ :name | self assert: (model classNamed: name) isNil ].
	self assert: (source sourceCodeFor: #setUp) equals: original.
	source compile: 'setUp super setUp. c := b + 1' classified: #running.
	refactoring primitiveExecute.
	self hierarchyMapping
		valuesDo: [ :name | self assert: (model classNamed: name) notNil ].
	^ refactoring
]
