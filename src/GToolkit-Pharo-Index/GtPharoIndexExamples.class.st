Class {
	#name : #GtPharoIndexExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Index'
}

{ #category : #private }
GtPharoIndexExamples >> addClassVar [
	Object
		evaluate: (self class definitionString
				copyReplaceAll: 'classVariableNames: '''''
				with: 'classVariableNames: ''GtMessageSendIterator''')
]

{ #category : #private }
GtPharoIndexExamples >> addPoolVar [
	Object
		evaluate: (self class definitionString
				copyReplaceAll: 'package: '
				with: 'poolDictionaries: ''GtPharoIndexExamplesPool'' package: ')
]

{ #category : #examples }
GtPharoIndexExamples >> addingAndRemovingClassWords [
	<gtExample>
	| index names |
	index := GtPharoIndex new.
	Collection
		withAllSubclassesDo: [ :each | index classAdded: (ClassAdded class: each category: nil) ].
	names := (index asyncClassNamesForWord: '') toArray wait.
	self assert: (names includes: #OrderedCollection).
	self assert: (names includes: #Array).
	Collection
		withAllSubclassesDo: [ :each | index classRemoved: (ClassRemoved class: each category: nil) ].
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
		methodRemoved: (MethodRemoved
				methodRemoved: Collection class >> #with:with:with:with:
				protocol: #private
				origin: Collection class).
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
	| refs |
	super printString.
	[ super printString ] value.
	refs := GtPharoIndex current globalVariableReferencesTo: self class binding.
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
	Object
		evaluate: (self class definitionString copyReplaceAll: 'GtMessageSendIterator' with: '')
]

{ #category : #private }
GtPharoIndexExamples >> removePoolVar [
	Object
		evaluate: (self class definitionString copyReplaceAll: 'GtPharoIndexExamplesPool' with: '')
]

{ #category : #examples }
GtPharoIndexExamples >> removingWords [
	<gtExample>
	| index selectors |
	index := self addingWords.
	index
		methodRemoved: (MethodRemoved
				methodRemoved: self class >> #dummyMethod
				protocol: #private
				origin: self class).
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
