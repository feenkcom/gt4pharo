Class {
	#name : #GtPharoIndexExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Index-GToolkit-Pharo-Index'
}

{ #category : #accessing }
GtPharoIndexExamples >> classReferenceInsideBlock [
	<gtExample>
	| refs |
	[ OrderedCollection new ] value.
	refs := GtPharoIndex current
			globalVariableReferencesTo: (self class environment bindingOf: ('Ordered' , 'Collection') asSymbol).
	self assert: (refs includes: thisContext method).
	^ refs
]

{ #category : #accessing }
GtPharoIndexExamples >> implementer [
	<gtExample>
	| impls |
	impls := GtPharoIndex current implementersOf: thisContext method selector.
	self assert: (impls includes: thisContext method).
	^ impls
]

{ #category : #accessing }
GtPharoIndexExamples >> messageSendInsideBlock [
	<gtExample>
	| refs |
	[ 4 printString ] ensure: [  ].
	refs := GtPharoIndex current sendersOf: ('print' , 'String') asSymbol.
	self assert: (refs includes: thisContext method).
	^ refs
]

{ #category : #accessing }
GtPharoIndexExamples >> noImplementers [
	<gtExample>
	| impls |
	impls := GtPharoIndex current implementersOf: ('abc123' , 'xyz789') asSymbol.
	self assert: impls isEmpty.
	^ impls
]

{ #category : #accessing }
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

{ #category : #accessing }
GtPharoIndexExamples >> optimizedIfTrue [
	<gtExample>
	| refs |
	refs := GtPharoIndex current sendersOf: ('if' , 'True:') asSymbol.
	(refs includes: thisContext method) not ifTrue: [ self assert: false ].
	^ refs
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

{ #category : #accessing }
GtPharoIndexExamples >> specialSelector [
	<gtExample>
	| refs |
	refs := GtPharoIndex current sendersOf: ('++' first: 1 + 0) asSymbol.
	self assert: (refs includes: thisContext method).
	^ refs
]

{ #category : #accessing }
GtPharoIndexExamples >> symbolIsAlsoClassReference [
	<gtExample>
	| refs |
	refs := GtPharoIndex current
			globalVariableReferencesTo: (self class environment bindingOf: #OrderedCollection).
	self assert: (refs includes: thisContext method).
	^ refs
]
