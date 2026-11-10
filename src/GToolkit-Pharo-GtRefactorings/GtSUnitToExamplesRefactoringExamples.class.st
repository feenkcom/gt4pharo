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
		to: #GtConversionTargetExamples) primitiveExecute.
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
GtSUnitToExamplesRefactoringExamples >> convertedExamplesUseTAssertable [
	<gtExample>
	| model source target definitionChange definitionTree |
	model := GtRBNamespace new.
	model
		defineClass: 'TestCase subclass: #GtConversionAssertionsTest instanceVariableNames: '''' classVariableNames: '''' package: ''SUnit-Conversion-Fixtures'''.
	source := model classNamed: #GtConversionAssertionsTest.
	source
		compile: 'testRaises self should: [ Error signal: ''expected'' ] raise: Error'
		classified: #tests.
	(GtSUnitToExamplesRefactoring
		model: model
		from: source name
		to: #GtConversionAssertionsExamples) primitiveExecute.
	target := model classNamed: #GtConversionAssertionsExamples.
	definitionChange := model changes changes
			detect: [ :change | 
				(change isKindOf: GtRBAddClassChange)
					and: [ change changeClassName = target name ] ].	"Check the emitted class definition: the namespace does not model trait methods."
	definitionTree := RBParser parseExpression: definitionChange definitionString.
	self assert: (definitionTree keywords includes: 'uses:').
	self
		assert: (definitionTree arguments at: (definitionTree keywords indexOf: 'uses:')) name
		equals: 'TAssertable'.
	self
		assert: (target parseTreeForSelector: #raises)
		equals: (RBParser
				parseMethod: 'raises <gtExample> self should: [ Error signal: ''expected'' ] raise: Error').
	self assert: (source directlyDefinesMethod: #testRaises).
	^ model
]

{ #category : #examples }
GtSUnitToExamplesRefactoringExamples >> existingTargetFailsPreconditions [
	<gtExample>
	| model refactoring before rejected |
	model := GtRBNamespace new.
	model
		defineClass: 'TestCase subclass: #GtConversionExistingTargetTest instanceVariableNames: '''' classVariableNames: '''' package: ''SUnit-Conversion-Fixtures'''.
	model
		defineClass: 'Object subclass: #GtConversionExistingTargetExamples instanceVariableNames: '''' classVariableNames: '''' package: ''SUnit-Conversion-Fixtures'''.
	refactoring := GtSUnitToExamplesRefactoring
			model: model
			from: #GtConversionExistingTargetTest
			to: #GtConversionExistingTargetExamples.
	before := model changes changes asArray.
	rejected := false.
	[ refactoring primitiveExecute ]
		on: RBRefactoringError
		do: [ :error | rejected := true ].
	self assert: rejected.
	self assert: model changes changes asArray equals: before.
	^ refactoring
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
		to: #GtConversionFirstExamples) primitiveExecute.
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
GtSUnitToExamplesRefactoringExamples >> missingSourceFailsPreconditions [
	<gtExample>
	| model refactoring before rejected |
	model := GtRBNamespace new.
	refactoring := GtSUnitToExamplesRefactoring
			model: model
			from: #GtConversionMissingSourceTest
			to: #GtConversionMissingSourceExamples.
	before := model changes changes asArray.
	rejected := false.
	[ refactoring primitiveExecute ]
		on: RBRefactoringError
		do: [ :error | rejected := true ].
	self assert: rejected.
	self assert: model changes changes asArray equals: before.
	self assert: (model classNamed: #GtConversionMissingSourceExamples) isNil.
	^ refactoring
]

{ #category : #examples }
GtSUnitToExamplesRefactoringExamples >> rejectionAfterExpansionPreservesModel [
	<gtExample>
	| model source original helper before message target |
	model := GtRBNamespace new.
	model
		defineClass: 'TestCase subclass: #GtConversionExpansionUnsafeTest instanceVariableNames: ''a'' classVariableNames: '''' package: ''SUnit-Conversion-Fixtures'''.
	source := model classNamed: #GtConversionExpansionUnsafeTest.
	original := 'setUp | value | value := 40. a := value. self initializeValue. Transcript cr'.
	helper := 'initializeValue a := 42'.
	source compile: original classified: #running.
	source compile: helper classified: #helpers.
	source compile: 'testValue self assert: a equals: 42' classified: #tests.
	before := model changes changes asArray.
	message := nil.
	[ (GtSUnitToExamplesRefactoring
		model: model
		from: source name
		to: #GtConversionExpansionUnsafeExamples) primitiveExecute ]
		on: Error
		do: [ :error | message := error messageText ].
	self
		assert: message
		equals: 'Expanded setUp must contain only direct slot assignments and super setUp'.
	self assert: (source sourceCodeFor: #setUp) equals: original.
	self assert: (source sourceCodeFor: #initializeValue) equals: helper.
	self assert: model changes changes asArray equals: before.
	self assert: (model classNamed: #GtConversionExpansionUnsafeExamples) isNil.	"Correct the setup and retry in the same model."
	source compile: 'setUp self initializeValue' classified: #running.
	(GtSUnitToExamplesRefactoring
		model: model
		from: source name
		to: #GtConversionExpansionUnsafeExamples) primitiveExecute.
	target := model classNamed: #GtConversionExpansionUnsafeExamples.
	self
		assert: (target parseTreeForSelector: #a)
		equals: (RBParser parseMethod: 'a ^ a ifNil: [ a := 42 ]').
	self
		assert: (source sourceCodeFor: #setUp)
		equals: 'setUp self initializeValue'.
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
		to: #GtConversionUnsafeExamples) primitiveExecute ]
		on: Error
		do: [ :error | rejected := true ].
	self assert: rejected.
	self assert: model changes changesSize equals: before.
	self assert: (model classNamed: #GtConversionUnsafeExamples) isNil.
	^ model
]

{ #category : #examples }
GtSUnitToExamplesRefactoringExamples >> setupExpansionUsesPendingHelperEdits [
	<gtExample>
	| model source target before |
	model := GtRBNamespace new.
	model
		defineClass: 'TestCase subclass: #GtConversionPendingHelperTest instanceVariableNames: ''a'' classVariableNames: '''' package: ''SUnit-Conversion-Fixtures'''.
	source := model classNamed: #GtConversionPendingHelperTest.
	source compile: 'setUp self initializeValue' classified: #running.
	source compile: 'initializeValue a := 1' classified: #helpers.
	source compile: 'testValue self assert: a equals: 42' classified: #tests.
	source
		compile: 'initializeValue | value | value := 40 + 2. a := value'
		classified: #helpers.
	before := model changes changes asArray.
	(GtSUnitToExamplesRefactoring
		model: model
		from: source name
		to: #GtConversionPendingHelperExamples) primitiveExecute.
	target := model classNamed: #GtConversionPendingHelperExamples.
	self
		assert: (target parseTreeForSelector: #a)
		equals: (RBParser parseMethod: 'a ^ a ifNil: [ a := 40 + 2 ]').
	self
		assert: (source sourceCodeFor: #setUp)
		equals: 'setUp self initializeValue'.
	self
		assert: (source sourceCodeFor: #initializeValue)
		equals: 'initializeValue | value | value := 40 + 2. a := value'.
	self assert: (model changes changes asArray first: before size) equals: before.
	self
		assert: model changes changes size
		equals: before size + target localSelectors size + 1.
	^ model
]

{ #category : #examples }
GtSUnitToExamplesRefactoringExamples >> setupSelfSends [
	<gtExample>
	| model source target originals before |
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
	originals := Dictionary new.
	source localSelectors
		do: [ :selector | originals at: selector put: (source sourceCodeFor: selector) ].
	before := model changes changes asArray.
	(GtSUnitToExamplesRefactoring
		model: model
		from: source name
		to: #GtConversionHelperExamples) primitiveExecute.
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
	originals
		keysAndValuesDo: [ :selector :code | self assert: (source sourceCodeFor: selector) equals: code ].
	self assert: (model changes changes asArray first: before size) equals: before.
	self
		assert: model changes changes size
		equals: before size + target localSelectors size + 1.
	^ model
]

{ #category : #examples }
GtSUnitToExamplesRefactoringExamples >> setupTemporariesAreInlined [
	<gtExample>
	| model source target original before |
	model := GtRBNamespace new.
	model
		defineClass: 'TestCase subclass: #GtConversionTemporaryTest instanceVariableNames: ''a b'' classVariableNames: '''' package: ''SUnit-Conversion-Fixtures'''.
	source := model classNamed: #GtConversionTemporaryTest.
	original := 'setUp | first second | super setUp. first := 40. second := first + 2. a := second. b := a + second'.
	source compile: original classified: #running.
	source compile: 'testValue self assert: a equals: 42' classified: #tests.
	before := model changes changes asArray.
	(GtSUnitToExamplesRefactoring
		model: model
		from: source name
		to: #GtConversionTemporaryExamples) primitiveExecute.
	target := model classNamed: #GtConversionTemporaryExamples.
	self
		assert: (target parseTreeForSelector: #a)
		equals: (RBParser parseMethod: 'a ^ a ifNil: [ a := 40 + 2 ]').
	self
		assert: (target parseTreeForSelector: #b)
		equals: (RBParser parseMethod: 'b ^ b ifNil: [ b := self a + (40 + 2) ]').
	self assert: (source sourceCodeFor: #setUp) equals: original.
	self assert: (model changes changes asArray first: before size) equals: before.
	self
		assert: model changes changes size
		equals: before size + target localSelectors size + 1.
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
		to: #GtConversionScopeExamples) primitiveExecute.
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
