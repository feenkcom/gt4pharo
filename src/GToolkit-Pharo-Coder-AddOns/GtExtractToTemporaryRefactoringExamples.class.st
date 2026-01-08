Class {
	#name : #GtExtractToTemporaryRefactoringExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-AddOns-Examples'
}

{ #category : #'as yet unclassified' }
GtExtractToTemporaryRefactoringExamples >> doNotExtractFromCascade [
	<gtExample>
	| model refactoring source first last |
	model := GtRBNamespace new.
	source := 'bar ^ 1 + 2; + 3; + 4'.
	(model classFor: Object) compile: source classified: #accessing.
	first := source indexOf: $1.
	last := source indexOf: $3.
	refactoring := GtExtractToTemporaryRefactoring
			model: model
			extract: (first to: last)
			to: 'temp'
			from: #bar
			in: Object.
	^ [ refactoring primitiveExecute.
	self assert: false description: 'Should throw an error' ]
		on: RBRefactoringError
		do: [ :ex | ex return: ex messageText ]
]

{ #category : #'as yet unclassified' }
GtExtractToTemporaryRefactoringExamples >> expressionInsideBlock [
	<gtExample>
	| model refactoring source newSource index |
	model := GtRBNamespace new.
	source := 'bar^[2 ** 2] value * 2' withCRs.
	newSource := 'bar^[| two |\		two := 2.\		two ** two] value * 2' withCRs.
	(model classFor: Object) compile: source classified: #accessing.
	index := source indexOf: $2.
	refactoring := GtExtractToTemporaryRefactoring
			model: model
			extract: (index to: index)
			to: 'two'
			from: #bar
			in: Object.
	refactoring primitiveExecute.
	self assert: ((model classFor: Object) sourceCodeFor: #bar) equals: newSource.
	^ model changes gtAllChanges last
]

{ #category : #'as yet unclassified' }
GtExtractToTemporaryRefactoringExamples >> expressionWithParen [
	<gtExample>
	| model refactoring source newSource index |
	model := GtRBNamespace new.
	source := 'foo: aStream\	Transcript print: 3 + 4; cr; print: (3 + 4) factorial; cr'
			withCRs.
	newSource := 'foo: aStream\	| seven |\	seven := 3 + 4.\	Transcript print: seven; cr; print: seven factorial; cr'
			withCRs.
	(model classFor: Object) compile: source classified: #accessing.
	index := source indexOf: $(.
	refactoring := GtExtractToTemporaryRefactoring
			model: model
			extract: (index to: index + 6)
			to: 'seven'
			from: #foo:
			in: Object.
	refactoring primitiveExecute.
	self assert: ((model classFor: Object) sourceCodeFor: #foo:) equals: newSource.
	^ model changes gtAllChanges last
]

{ #category : #'as yet unclassified' }
GtExtractToTemporaryRefactoringExamples >> extractReceiverOfCascade [
	<gtExample>
	| model refactoring source newSource index last |
	model := GtRBNamespace new.
	source := 'bar ^ 1 + 2; + 3; + 4'.
	newSource := 'bar | one |\	one := 1.\	^ one + 2; + 3; + 4' withCRs.
	(model classFor: Object) compile: source classified: #accessing.
	index := source indexOf: $1.
	refactoring := GtExtractToTemporaryRefactoring
			model: model
			extract: (index to: index)
			to: 'one'
			from: #bar
			in: Object.
	refactoring primitiveExecute.
	self assert: ((model classFor: Object) sourceCodeFor: #bar) equals: newSource.
	^ model changes gtAllChanges last
]

{ #category : #'as yet unclassified' }
GtExtractToTemporaryRefactoringExamples >> extractTemp [
	<gtExample>
	| model refactoring source newSource index |
	model := GtRBNamespace new.
	source := 'bar | temp | temp := 2. ^temp * temp' withCRs.
	newSource := 'bar | temp two | temp := 2.\	two := temp. ^two * two' withCRs.
	(model classFor: Object) compile: source classified: #accessing.
	index := source indexOfSubCollection: 'temp'.
	refactoring := GtExtractToTemporaryRefactoring
			model: model
			extract: (index to: index + 3)
			to: 'two'
			from: #bar
			in: Object.
	refactoring primitiveExecute.
	self assert: ((model classFor: Object) sourceCodeFor: #bar) equals: newSource.
	^ model changes gtAllChanges last
]

{ #category : #'as yet unclassified' }
GtExtractToTemporaryRefactoringExamples >> variableIsAssigned [
	<gtExample>
	| model refactoring source newSource |
	model := GtRBNamespace new.
	source := 'foo: aStream\	start := 1.\	aStream nextPut: start.\	start := 2.\	aStream nextPut: start'
			withCRs.
	newSource := 'foo: aStream\	| var |\	start := 1.\	var := start.\	aStream nextPut: var.\	start := 2.\	var := start.\	aStream nextPut: var'
			withCRs.
	(model classFor: Object) compile: source classified: #accessing.
	refactoring := GtExtractToTemporaryRefactoring
			model: model
			extract: (source size - 4 to: source size)
			to: 'var'
			from: #foo:
			in: Object.
	refactoring primitiveExecute.
	self assert: ((model classFor: Object) sourceCodeFor: #foo:) equals: newSource.
	^ model changes gtAllChanges last
]
