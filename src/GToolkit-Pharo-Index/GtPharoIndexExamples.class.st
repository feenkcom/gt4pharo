Class {
	#name : #GtPharoIndexExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Index'
}

{ #category : #private }
GtPharoIndexExamples >> addClassVar [
	self
		forPharo12AndNewer: [ self class classInstaller new
				makeWithBuilder: (Smalltalk compiler
						evaluate: self class definitionString , '; sharedVariables: { #GtMessageSendIterator }') ]
		forPharo11: [ Smalltalk compiler
				evaluate: (self class definitionString
						copyReplaceAll: 'classVariableNames: '''''
						with: 'classVariableNames: ''GtMessageSendIterator''') ]
]

{ #category : #examples }
GtPharoIndexExamples >> addInstVarRemovesUndeclaredReferences [
	<gtExample>
	[ ((Object << #FooBar)
		slots: {};
		package: self class package name) install.

	#FooBar asClass
		compile: 'accessAndWriteSlotA
	^ slotA := slotA '
		classified: 'accessing'.

	#FooBar asClass addSlot: #slotA.
	self
		assert: ((GtPharoIndex current allSendersOf: #runtimeUndeclaredReadInContext:)
				select: [ :each | each gtIsActive not ]) isEmpty.
	self
		assert: ((GtPharoIndex current allSendersOf: #runtimeUndeclaredWrite:inContext:)
				select: [ :each | each gtIsActive not ]) isEmpty.

	self
		assert: ((GtPharoIndex current allImplementersOf: #accessAndWriteSlotA)
				select: [ :each | each methodClass isObsolete ]) isEmpty ]
		ensure: [ #FooBar asClass removeFromSystem ]
]

{ #category : #private }
GtPharoIndexExamples >> addPoolVar [
	self
		forPharo12AndNewer: [ self class classInstaller new
				makeWithBuilder: (Smalltalk compiler
						evaluate: self class definitionString , '; sharedPools: {GtPharoIndexExamplesPool}') ]
		forPharo11: [ Smalltalk compiler
				evaluate: (self class definitionString
						copyReplaceAll: 'package: '
						with: 'poolDictionaries: ''GtPharoIndexExamplesPool'' package: ') ]
]

{ #category : #examples }
GtPharoIndexExamples >> addingAndRemovingClassWords [
	<gtExample>
	| index names |
	index := GtPharoIndex new.
	Collection
		withAllSubclassesDo: [ :each | 
			index
				classAdded: (self
						forPharo12AndNewer: [ ClassAdded class: each ]
						forPharo11: [ ClassAdded class: each category: nil ]) ].
	names := (index asyncClassNamesForWord: '') toArray wait.
	self assert: (names includes: #OrderedCollection).
	self assert: (names includes: #Array).
	Collection
		withAllSubclassesDo: [ :each | 
			index
				classRemoved: (self
						forPharo12AndNewer: [ ClassRemoved class: each ]
						forPharo11: [ ClassRemoved class: each category: nil ]) ].
	self assert: (index asyncClassNamesForWord: '') toArray wait isEmpty.
	^ index
]

{ #category : #examples }
GtPharoIndexExamples >> addingAndRemovingDuplicateWords [
	<gtExample>
	| index selectors |
	index := GtPharoIndex new.
	index
		methodAdded: (MethodAdded method: Collection class >> #with:with:with:with:).
	selectors := (index asyncSelectorsForWord: 'withWithWithWith') toArray wait.
	self assert: selectors size equals: 1.
	self assert: (selectors includes: #with:with:with:with:).
	index
		methodRemoved: (self
				forPharo12AndNewer: [ MethodRemoved
						methodRemoved: Collection class >> #with:with:with:with:
						origin: Collection class ]
				forPharo11: [ MethodRemoved
						methodRemoved: Collection class >> #with:with:with:with:
						protocol: #private
						origin: Collection class ]).
	selectors := (index asyncSelectorsForWord: '') toArray wait.
	self assert: selectors isEmpty.
	^ index
]

{ #category : #examples }
GtPharoIndexExamples >> addingWords [
	<gtExample>
	| index selectors |
	index := GtPharoIndex new.
	index methodAdded: (MethodAdded method: self class >> #dummyMethod).
	selectors := (index asyncSelectorsForWord: '') toArray wait.
	self assert: selectors size equals: 2.
	self assert: (selectors includes: #dummyMethod).
	self assert: (selectors includes: #printString).
	^ index
]

{ #category : #examples }
GtPharoIndexExamples >> checkGlobalAndClasses [
	<gtExample>
	self assert: (GtPharoIndex current globalCache includes: 'Transcript').
	self assert: (GtPharoIndex current classNameTree includes: 'Transcript') not.
	self assert: (GtPharoIndex current classNameTree includes: self class name).
	^ GtPharoIndex current
]

{ #category : #private }
GtPharoIndexExamples >> checkGtMessageSendIteratorRefs: aBoolean [
	| refs |
	GtMessageSendIterator printString.	"Create >1 refs in this method"
	self assert: GtMessageSendIterator isBehavior equals: aBoolean.
	refs := GtPharoIndex current
			globalVariableReferencesTo: (Object environment bindingOf: 'GtMessageSendIterator' asSymbol).
	self assert: (refs includes: thisContext method) equals: aBoolean.
	self assert: (refs allSatisfy: [ :each | each gtIsActive ])
]

{ #category : #accessing }
GtPharoIndexExamples >> checkReferencesToClassCreatedFromUndeclared [
	<gtExample>
	| refs var |
	[ Object
		subclass: #GtFoo1
		instanceVariableNames: ''
		classVariableNames: ''
		package: 'Foo'.
	#GtFoo1 asClass compile: 'm1 
	^ GtFoo2'.
	Object
		subclass: #GtFoo2
		instanceVariableNames: ''
		classVariableNames: ''
		package: 'Foo'.
	var := Smalltalk globals associationAt: #GtFoo2.
	refs := GtPharoIndex current globalVariableReferencesTo: var.
	self assert: (refs includes: thisContext method method).
	self assert: (refs includes: #GtFoo1 asClass >> #m1).
	refs := #GtFoo2 asClass gtReferences contents.
	self assert: (refs includes: #GtFoo1 asClass >> #m1) ]
		ensure: [ Smalltalk globals
				associationAt: #GtFoo1
				ifPresent: [ :assoc | assoc value removeFromSystem ].
			Smalltalk globals
				associationAt: #GtFoo2
				ifPresent: [ :assoc | assoc value removeFromSystem ].
			Undeclared removeKey: #GtFoo2 ifAbsent: [] ].
	refs := GtPharoIndex current globalVariableReferencesTo: var.
	self assert: (refs includes: thisContext method method).
	self assert: refs size = 1.
	^ refs
]

{ #category : #accessing }
GtPharoIndexExamples >> checkReferencesToClassCreatedFromUndeclaredInsideTrait [
	<gtExample>
	| refs var |
	
	[ Trait classInstaller
		make: [ :builder | 
			builder
				beTrait;
				name: #TGtFoo;
				slots: #();
				package: 'Foo';
				environment: Trait environment ].
	Object classInstaller
		make: [ :builder | 
			builder
				superclass: Object;
				name: #GtFoo1T;
				slots: #();
				sharedVariables: #();
				traitComposition: (Smalltalk globals at: #TGtFoo);
				package: 'Foo';
				environment: Object environment ].
	#TGtFoo asClass class
		compile: 'm1 
	^ GtFoo2T'.
	self assert: #GtFoo1T asClass class localMethods isEmpty.
	
	Object classInstaller
		make: [ :builder | 
			builder
				superclass: Object;
				name: #GtFoo2T;
				slots: #();
				package: 'Foo';
				environment: Object environment ].
		
	self assert: #GtFoo1T asClass class localMethods isEmpty.
	var := Smalltalk globals associationAt: #GtFoo2T.
	refs := GtPharoIndex current globalVariableReferencesTo: var.
	self assert: (refs includes: thisContext method method).
	self assert: (refs includes: (Smalltalk globals at: #TGtFoo) class >> #m1).
	refs := #GtFoo2T asClass gtReferences contents.
	self assert: (refs includes: (Smalltalk globals at: #TGtFoo) class >> #m1) ]
		ensure: [ Smalltalk globals
				associationAt: #GtFoo1T
				ifPresent: [ :assoc | assoc value removeFromSystem ].
			Smalltalk globals
				associationAt: #GtFoo2T
				ifPresent: [ :assoc | assoc value removeFromSystem ].
			Smalltalk globals
				associationAt: #TGtFoo
				ifPresent: [ :assoc | assoc value removeFromSystem ].
			Undeclared removeKey: #GtFoo2T ifAbsent: [  ] ].
	refs := GtPharoIndex current globalVariableReferencesTo: var.
	self assert: (refs includes: thisContext method method).
	self assert: refs size = 1.
	^ refs
]

{ #category : #'as yet unclassified' }
GtPharoIndexExamples >> checkReflectiveMethodReferences [
	<gtExample>
	| node reflectiveMethod |
	node := GtReferencesPrefixTree new.
	reflectiveMethod := ReflectiveMethod on: Object >> #printString.
	node addReference: reflectiveMethod.
	self assert: node referencesCollection size equals: 1.
	1
		to: 10000
		do: [ :i | 
			node addReference: thisContext method.
			self assert: node referencesCollection size equals: i + 1 ].
	^ node
]

{ #category : #examples }
GtPharoIndexExamples >> classReferenceInsideBlock [
	<gtExample>
	| refs |
	[ OrderedCollection new ] value.
	refs := GtPharoIndex current
			globalVariableReferencesTo: (self class environment bindingOf: ('Ordered' , 'Collection') asSymbol).
	self assert: (refs includes: thisContext method).
	^ refs
]

{ #category : #examples }
GtPharoIndexExamples >> classVarShadowsClass [
	<gtExample>
	| node originalWeight |
	node := GtPharoIndex current globalCache
			nodeFor: 'GtMessageSendIterator' asSymbol.
	originalWeight := node weight.
	[ self checkGtMessageSendIteratorRefs: true.
	self addClassVar.
	self assert: node weight + 2 equals: originalWeight.
	self checkGtMessageSendIteratorRefs: false.
	self removeClassVar.
	self assert: node weight equals: originalWeight.
	self checkGtMessageSendIteratorRefs: true ]
		ensure: [ (self class classVarNames includes: 'GtMessageSendIterator' asSymbol)
				ifTrue: [ self removeClassVar ] ].
	^ node
]

{ #category : #private }
GtPharoIndexExamples >> dummyMethod [
	^ self printString
]

{ #category : #examples }
GtPharoIndexExamples >> duplicateWordImplementers [
	<gtExample>
	| methods stream |
	stream := GtPharoIndex current asyncImplementersForWord: 'withWithWithWithWith'.
	methods := stream asyncSimilarCopy toArray wait.
	self assert: (methods includes: Collection class >> #with:with:with:with:with:).
	self assert: (methods includes: Collection class >> #with:with:with:with:) not.
	^ stream
]

{ #category : #examples }
GtPharoIndexExamples >> duplicateWordSelectors [
	<gtExample>
	| selectors stream |
	stream := GtPharoIndex current asyncSelectorsForWord: 'withWithWithWithWith'.
	selectors := stream asyncSimilarCopy toArray wait.
	self assert: (selectors includes: #with:with:with:with:with:).
	self assert: (selectors includes: #with:with:with:with:) not.
	^ stream
]

{ #category : #examples }
GtPharoIndexExamples >> implementer [
	<gtExample>
	| impls |
	impls := GtPharoIndex current implementersOf: thisContext method selector.
	self assert: (impls includes: thisContext method).
	^ impls
]

{ #category : #accessing }
GtPharoIndexExamples >> lowercaseWordSearch [
	<gtExample>
	| results |
	results := (GtPharoIndex current asyncClassNamesForWord: 'prefixtr') toArray
			wait.	"assumes no classes have 'prefixtr' as a word"
	self assert: (results includes: #GtPrefixTree).
	^ results
]

{ #category : #examples }
GtPharoIndexExamples >> messageSendInsideBlock [
	<gtExample>
	| refs |
	[ 4 printString ] ensure: [  ].
	refs := GtPharoIndex current sendersOf: ('print' , 'String') asSymbol.
	self assert: (refs includes: thisContext method).
	^ refs
]

{ #category : #examples }
GtPharoIndexExamples >> noImplementers [
	<gtExample>
	| impls |
	impls := GtPharoIndex current implementersOf: ('abc123' , 'xyz789') asSymbol.
	self assert: impls isEmpty.
	^ impls
]

{ #category : #examples }
GtPharoIndexExamples >> noSenders [
	<gtExample>
	| refs |
	refs := GtPharoIndex current sendersOf: ('abc123' , 'xyz789') asSymbol.
	self assert: refs isEmpty.
	^ refs
]

{ #category : #examples }
GtPharoIndexExamples >> notAClassReference [
	<gtExample>
	| refs index|
	index := GtPharoIndex new.
	index addSendsFrom: thisContext method.
	super printString.
	[ super printString ] value.
	refs := index globalVariableReferencesTo: self class binding.
	self assert: (refs includes: thisContext method) not.
	^ refs
]

{ #category : #examples }
GtPharoIndexExamples >> optimizedIfTrue [
	<gtExample>
	| refs |
	refs := GtPharoIndex current sendersOf: ('if' , 'True:') asSymbol.
	(refs includes: thisContext method) not ifTrue: [ self assert: false ].
	^ refs
]

{ #category : #examples }
GtPharoIndexExamples >> poolVarShadowsClass [
	<gtExample>
	| node originalWeight |
	node := GtPharoIndex current globalCache
			nodeFor: 'GtMessageSendIterator' asSymbol.
	originalWeight := node weight.
	[ self checkGtMessageSendIteratorRefs: true.
	self addPoolVar.
	self assert: node weight + 2 equals: originalWeight.
	self checkGtMessageSendIteratorRefs: false.
	self removePoolVar.
	self assert: node weight equals: originalWeight.
	self checkGtMessageSendIteratorRefs: true ]
		ensure: [ (self class sharedPoolNames includes: 'GtPharoIndexExamplesPool' asSymbol)
				ifTrue: [ self removePoolVar ] ].
	^ node
]

{ #category : #examples }
GtPharoIndexExamples >> recompileMethodUpdatesIndex [
	<gtExample>
	| processes count time senders |
	senders := #runtimeUndeclaredReadInContext: gtSenders.
	count := senders size.
	processes := OrderedCollection new.
	self assert: GtPharoIndex current selectorCache notInstalledMethods isEmpty.
	senders
		do: [ :each | 
			processes
				add: ([ each ast.
					each ast.
					count := count - 1 ] newProcess
						priority: 30;
						yourself) ].
	time := Time millisecondClockValue + 5000.
	[ [ (Delay forMilliseconds: 1) wait.
	count > 0 and: [ Time millisecondClockValue < time ] ] whileTrue.
	processes do: #terminate ] fork.
	processes do: #resume.
	self assert: GtPharoIndex current selectorCache notInstalledMethods isEmpty
]

{ #category : #examples }
GtPharoIndexExamples >> referenceInLiteralArray [
	<gtExample>
	| refs array |
	array := #(2 #(printString) 3).
	refs := GtPharoIndex current sendersOf: array second first.
	self assert: (refs includes: thisContext method).
	^ refs
]

{ #category : #private }
GtPharoIndexExamples >> removeClassVar [
	| definition |
	self
		forPharo12AndNewer: [ definition := self class definitionString
					copyReplaceAll: '#GtMessageSendIterator'
					with: ''.
			self class classInstaller new
				makeWithBuilder: (Smalltalk compiler evaluate: definition) ]
		forPharo11: [ definition := self class definitionString
					copyReplaceAll: 'GtMessageSendIterator'
					with: ''.
			Smalltalk compiler evaluate: definition ]
]

{ #category : #private }
GtPharoIndexExamples >> removePoolVar [
	| definition |
	definition := self class definitionString
			copyReplaceAll: 'GtPharoIndexExamplesPool'
			with: ''.
	self
		forPharo12AndNewer: [ self class classInstaller new
				makeWithBuilder: (Smalltalk compiler evaluate: definition) ]
		forPharo11: [ Smalltalk compiler evaluate: definition ]
]

{ #category : #examples }
GtPharoIndexExamples >> removingWords [
	<gtExample>
	| index selectors |
	index := self addingWords.
	index
		methodRemoved: (self
				forPharo12AndNewer: [ MethodRemoved methodRemoved: self class >> #dummyMethod origin: self class ]
				forPharo11: [ MethodRemoved
						methodRemoved: self class >> #dummyMethod
						protocol: #private
						origin: self class ]).
	selectors := (index asyncSelectorsForWord: '') toArray wait.
	self assert: selectors size equals: 0.
	^ index
]

{ #category : #examples }
GtPharoIndexExamples >> specialSelector [
	<gtExample>
	| refs |
	refs := GtPharoIndex current sendersOf: ('++' first: 1 + 0) asSymbol.
	self assert: (refs includes: thisContext method).
	^ refs
]

{ #category : #examples }
GtPharoIndexExamples >> symbolIsAlsoClassReference [
	<gtExample>
	| refs |
	refs := GtPharoIndex current
			globalVariableReferencesTo: (self class environment bindingOf: #OrderedCollection).
	self assert: (refs includes: thisContext method).
	^ refs
]

{ #category : #accessing }
GtPharoIndexExamples >> wordSearchOrdering [
	<gtExample>
	| prefixTree wordTree results names words |
	prefixTree := GtPrefixTree new.
	wordTree := GtNamesPrefixTree new.
	names := #('OneTwoThreeFour' 'TwoThreeFourOne' 'ThreeFourOneTwo' 'FourOneTwoThree').
	words := #('one' 'two' 'three' 'four').
	prefixTree addAll: names.
	prefixTree add: 'One'.
	wordTree addAll: words.
	names
		do: [ :each | words do: [ :word | (wordTree nodeFor: word) addName: each ] ].
	(wordTree nodeFor: 'one') addName: 'One'.

	results := (GtPharoIndex current
			asyncNamesForWord: 'One'
			usingPrefixCache: prefixTree
			andWordCache: wordTree) toArray wait.
	self assert: results first = 'One'.
	self assert: results second = 'OneTwoThreeFour'.
	self assert: results size = 5.

	results := (GtPharoIndex current
			asyncNamesForWord: 'OneTwo'
			usingPrefixCache: prefixTree
			andWordCache: wordTree) toArray wait.
	self assert: results first = 'OneTwoThreeFour'.
	self assert: results last = 'TwoThreeFourOne'.
	self assert: results size = 4.

	results := (GtPharoIndex current
			asyncNamesForWord: 'ThreeOneTwo'
			usingPrefixCache: prefixTree
			andWordCache: wordTree) toArray wait.
	self assert: results first = 'ThreeFourOneTwo'.
	self assert: results size = 4.

	^ results
]
