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

{ #category : #accessing }
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
