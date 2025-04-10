Class {
	#name : #GtSplitCascadesRefactoring,
	#superclass : #GtCascadesRefactoring,
	#instVars : [
		'semicolonPosition',
		'splitAfter'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring'
}

{ #category : #examples }
GtSplitCascadesRefactoring class >> dummyMethod [
	| stream |
	stream := WriteStream on: String new.
	stream
		nextPutAll: 'This';
		space;
		nextPutAll: 'is';
		cr;
		nextPut: $a;
		space;
		nextPutAll: 'test'.
	^ stream contents
]

{ #category : #examples }
GtSplitCascadesRefactoring class >> exampleCreatingTemporary [
	<gtExample>
	| model source index refactoring |
	model := GtRBNamespace new.
	source := 'foo ^(WriteStream on: String new) print: self; contents'.
	(model classFor: self class) compile: source classified: #accessing.
	index := source indexOf: $;.

	refactoring := self
			model: model
			splitAt: index
			inMethod: #foo
			forClass: self class.
	refactoring options at: #receiverName put: [ :each | 'temp' ].
	refactoring primitiveExecute.
	self
		assert: ((model classFor: self class) parseTreeForSelector: #foo)
		equals: (RBParser
				parseMethod: 'foo | temp | temp := WriteStream on: String new. temp print: self. ^temp contents').

	^ model
]

{ #category : #examples }
GtSplitCascadesRefactoring class >> exampleWithVariableReceiver [
	<gtExample>
	| model source index refactoring |
	model := GtRBNamespace new.
	source := self class sourceCodeAt: #dummyMethod.
	index := (source indexOfSubCollection: 'cr;') + 2.

	refactoring := self
			model: model
			splitAt: index
			inMethod: #dummyMethod
			forClass: self class.
	refactoring primitiveExecute.
	self
		assert: ((model classFor: self class) parseTreeForSelector: #dummyMethod)
		equals: (RBParser parseMethod: (source copyReplaceAll: 'cr;' with: 'cr. stream ')).

	source := (model classFor: self class) sourceCodeFor: #dummyMethod.
	index := source indexOf: $;.
	refactoring := self
			model: model
			splitAt: index
			inMethod: #dummyMethod
			forClass: self class.
	refactoring primitiveExecute.
	self
		assert: ((model classFor: self class) parseTreeForSelector: #dummyMethod)
		equals: (RBParser
				parseMethod: (source first: index - 1) , '. stream ' , (source allButFirst: index)).

	source := (model classFor: self class) sourceCodeFor: #dummyMethod.
	index := source lastIndexOf: $;.
	refactoring := self
			model: model
			splitAt: index
			inMethod: #dummyMethod
			forClass: self class.
	refactoring primitiveExecute.
	self
		assert: ((model classFor: self class) parseTreeForSelector: #dummyMethod)
		equals: (RBParser
				parseMethod: (source first: index - 1) , '. stream ' , (source allButFirst: index)).

	^ model
]

{ #category : #'instance creation' }
GtSplitCascadesRefactoring class >> model: model splitAt: anInteger inMethod: aSelector forClass: aClass [
	^ self new
		model: model;
		splitAt: anInteger
			inMethod: aSelector
			forClass: aClass;
		yourself
]

{ #category : #'instance creation' }
GtSplitCascadesRefactoring class >> splitAt: anInteger inMethod: aSelector forClass: aClass [
	^ self new
		splitAt: anInteger
			inMethod: aSelector
			forClass: aClass;
		yourself
]

{ #category : #private }
GtSplitCascadesRefactoring >> findNode [
	| sourceTree |
	sourceTree := class parseTreeForSelector: selector.
	sourceTree ifNil: [ self refactoringFailure: 'Could not parse source' ].
	sourceTree
		nodesDo: [ :each | 
			(each isCascade and: [ each semicolons includes: semicolonPosition ])
				ifTrue: [ splitAfter := each semicolons indexOf: semicolonPosition.
					^ each ] ].
	^ nil
]

{ #category : #accessing }
GtSplitCascadesRefactoring >> gtDescription [
	^ 'Split cascades'
]

{ #category : #initialization }
GtSplitCascadesRefactoring >> splitAt: anInteger inMethod: aSelector forClass: aClassOrSymbol [
	semicolonPosition := anInteger.
	selector := aSelector.
	class := self model classObjectFor: aClassOrSymbol
]

{ #category : #transforming }
GtSplitCascadesRefactoring >> transformNode: aNode [
	| statement startingMessages endingMessages beforeStatement replacement |
	statement := aNode statementNode.
	startingMessages := aNode messages first: splitAfter.
	beforeStatement := startingMessages size = 1
			ifTrue: [ startingMessages first copy ]
			ifFalse: [ RBCascadeNode messages: (startingMessages collect: #copy) ].
	endingMessages := aNode messages allButFirst: splitAfter.
	replacement := endingMessages size = 1
			ifTrue: [ endingMessages first copy ]
			ifFalse: [ RBCascadeNode messages: (endingMessages collect: #copy) ].
	statement parent addNode: beforeStatement before: statement.
	aNode parent replaceNode: aNode withNode: replacement.
	class compileTree: aNode methodNode
]
