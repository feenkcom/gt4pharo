"
I check the String>>#= and Symbol>>#= patches that GtStrictSymbolInstallation>>#installStringAndSymbolEquals installs, the strict comparison flag and the content comparisons (#sameContentAs:, #isStrictString).
The patches are compiled but not installed: the examples run the compiled methods on strings and symbols, so they do not change String or Symbol.
"
Class {
	#name : #GtStrictSymbolComparisonPatchExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#category : #'GToolkit-Pharo-StrictSymbolComparison-Examples'
}

{ #category : #examples }
GtStrictSymbolComparisonPatchExamples >> assertIsStringWhenStrict [
	"With strict comparison, #assertIsStringWhenStrict: accepts only Strings that are not Symbols"

	<gtExample>
	<return: #GtStrictSymbolComparisonPatchExamples>
	| anObject |
	anObject := Object new.
	GtStrictSymbolComparisonFlag
		useStrictComparison: true
		during: [ anObject assertIsStringWhenStrict: 'abc'.
			self
				should: [ anObject assertIsStringWhenStrict: #abc ]
				raise: AssertionFailure ].
	GtStrictSymbolComparisonFlag
		useStrictComparison: false
		during: [ anObject assertIsStringWhenStrict: #abc ].
	^ self
]

{ #category : #examples }
GtStrictSymbolComparisonPatchExamples >> collectionSameContent [
	"Sets and Bags have the same content when each element occurs as often in both,
	comparing strings and symbols based on their content"

	<gtExample>
	<return: #GtStrictSymbolComparisonPatchExamples>
	self assert: ((Set with: #a with: #b) sameContentAs: (Set with: 'b' with: 'a')).
	self assert: ((Set with: #a with: #b) sameContentAs: (Bag with: #b with: #a)).
	self assert: ((Bag with: #a with: #a) sameContentAs: (Bag with: #a with: #b)) not.
	self assert: ((Set with: #a) sameContentAs: (Set with: #a with: #b)) not.
	^ self
]

{ #category : #examples }
GtStrictSymbolComparisonPatchExamples >> collectionSameContentCountsOccurrences [
	"Each element must occur as often in both collections, comparing strings and symbols based on their content"

	<gtExample>
	<return: #GtStrictSymbolComparisonPatchExamples>
	self assert: ((Bag withAll: #(#a #a #b)) sameContentAs: (Bag withAll: #('a' #b 'a'))).
	self assert: ((Bag withAll: #(#a #a #b)) sameContentAs: (Bag withAll: #(#a #b #b))) not.
	self assert: ((Bag withAll: #(#a #b)) sameContentAs: (Bag withAll: #('a' 'a'))) not.
	self assert: ((Set with: #a) sameContentAs: (Bag withAll: #(#a #a))) not.
	^ self
]

{ #category : #examples }
GtStrictSymbolComparisonPatchExamples >> collectionSameContentWithNil [
	"nil elements are counted like the other elements"

	<gtExample>
	<return: #GtStrictSymbolComparisonPatchExamples>
	self assert: ((Bag withAll: #(nil #a)) sameContentAs: #('a' nil)).
	self assert: ((Bag withAll: #(nil nil #a)) sameContentAs: #(nil #a #a)) not.
	self assert: ((Bag withAll: #(nil)) sameContentAs: #(#a)) not.
	^ self
]

{ #category : #examples }
GtStrictSymbolComparisonPatchExamples >> collectionSameContentWithOtherArguments [
	"The argument can be any collection, its order does not matter; anything else does not have the same content"

	<gtExample>
	<return: #GtStrictSymbolComparisonPatchExamples>
	self assert: ((Set with: #a with: #b) sameContentAs: #('b' 'a')).
	self assert: ((Set with: #a with: #b) sameContentAs: (OrderedCollection with: #b with: 'a')).
	self assert: (Set new sameContentAs: #()).
	self assert: ((Set with: #a) sameContentAs: nil) not.
	self assert: ((Set with: 1) sameContentAs: 1) not.
	^ self
]

{ #category : #private }
GtStrictSymbolComparisonPatchExamples >> compare: aReceiver to: anArgument with: aCompiledMethod [
	^ aCompiledMethod valueWithReceiver: aReceiver arguments: { anArgument }
]

{ #category : #examples }
GtStrictSymbolComparisonPatchExamples >> dictionarySameContentComparesKeys [
	"Dictionaries have the same content when they have the same keys, each with the same value,
	comparing strings and symbols based on their content"

	<gtExample>
	<return: #GtStrictSymbolComparisonPatchExamples>
	| aDictionary |
	aDictionary := Dictionary new
			at: #a put: 1;
			at: #b put: #x;
			yourself.
	self
		assert: (aDictionary
				sameContentAs: (Dictionary new
						at: 'b' put: 'x';
						at: 'a' put: 1;
						yourself)).
	self
		assert: (aDictionary
				sameContentAs: (GtStringContentDictionary new
						at: #a put: 1;
						at: #b put: #x;
						yourself)).
	self
		assert: (aDictionary
				sameContentAs: (Dictionary new
						at: #a put: 1;
						at: #c put: #x;
						yourself)) not.
	self
		assert: (aDictionary
				sameContentAs: (Dictionary new
						at: #a put: 1;
						at: #b put: #y;
						yourself)) not.
	self
		assert: (aDictionary
				sameContentAs: (Dictionary new
						at: #a put: 1;
						yourself)) not.
	self assert: (aDictionary sameContentAs: #(1 #x)) not.
	^ self
]

{ #category : #examples }
GtStrictSymbolComparisonPatchExamples >> isStrictString [
	<gtExample>
	<return: #GtStrictSymbolComparisonPatchExamples>
	self assert: 'abc' isStrictString.
	self assert: 'abc' asWideString isStrictString.
	self assert: '' isStrictString.
	self assert: #abc isStrictString not.
	self assert: 'abc' asWideString asSymbol isStrictString not.
	self assert: 'abc' asText isStrictString not.
	self assert: 42 isStrictString not.
	self assert: nil isStrictString not.
	^ self
]

{ #category : #examples }
GtStrictSymbolComparisonPatchExamples >> sequenceableCollectionSameContent [
	"Sequenceable collections have the same content when they have the same species and the same elements
	in the same order, comparing strings and symbols based on their content"

	<gtExample>
	<return: #GtStrictSymbolComparisonPatchExamples>
	self assert: (#(#a 'b') sameContentAs: #('a' #b)).
	self assert: ((OrderedCollection with: 'a') sameContentAs: (OrderedCollection with: #a)).
	self assert: (#(#a #b) sameContentAs: #(#b #a)) not.
	self assert: (#(#a) sameContentAs: (OrderedCollection with: #a)) not.
	^ self
]

{ #category : #examples }
GtStrictSymbolComparisonPatchExamples >> strictComparisonFlagDuring [
	"The flag is set during the block and restored afterwards, also when the block fails"

	<gtExample>
	<return: #GtStrictSymbolComparisonPatchExamples>
	| aPreviousValue |
	aPreviousValue := Symbol strictComparison.
	GtStrictSymbolComparisonFlag
		useStrictComparison: true
		during: [ self assert: Symbol strictComparison.
			GtStrictSymbolComparisonFlag
				useStrictComparison: false
				during: [ self assert: Symbol strictComparison not ].
			self assert: Symbol strictComparison ].
	self assert: Symbol strictComparison equals: aPreviousValue.
	[ GtStrictSymbolComparisonFlag
		useStrictComparison: aPreviousValue not
		during: [ Error signal: 'failure in the block' ] ]
		on: Error
		do: [ :anError | anError return: nil ].
	self assert: Symbol strictComparison equals: aPreviousValue.
	^ self
]

{ #category : #private }
GtStrictSymbolComparisonPatchExamples >> stringEqualsMethod [
	"String>>#= as installed by GtStrictSymbolInstallation>>#installStringAndSymbolEquals, compiled but not installed"

	<return: #CompiledMethod>
	^ String compiler compile: GtStrictSymbolInstallation new stringEqualsSource
]

{ #category : #examples }
GtStrictSymbolComparisonPatchExamples >> stringEqualsPatchWithStrictComparison [
	"With strict comparison, the patched String>>#= answers false for a Symbol and compares Strings as before"

	<gtExample>
	<return: #CompiledMethod>
	| aMethod |
	aMethod := self stringEqualsMethod.
	GtStrictSymbolComparisonFlag
		useStrictComparison: true
		during: [ self assert: (self compare: 'abc' to: #abc with: aMethod) not.
			self assert: (self compare: 'abc' asWideString to: #abc with: aMethod) not.
			self assert: (self compare: 'abc' to: 'abc' with: aMethod).
			self assert: (self compare: 'abc' to: 'abc' asWideString with: aMethod).
			self assert: (self compare: 'abc' to: 'abd' with: aMethod) not.
			self assert: (self compare: '' to: '' with: aMethod) ].
	^ aMethod
]

{ #category : #examples }
GtStrictSymbolComparisonPatchExamples >> stringEqualsPatchWithoutStrictComparison [
	"Without strict comparison, the patched String>>#= answers what the Pharo String>>#= answers"

	<gtExample>
	<return: #CompiledMethod>
	| aMethod |
	aMethod := self stringEqualsMethod.
	self assert: aMethod isInstalled not.
	GtStrictSymbolComparisonFlag
		useStrictComparison: false
		during: [ #(#('abc' 'abc') #('abc' 'abd') #('abc' 'ab') #('' '') #('abc' #abc) #('abc' #abd) #('abc' 42) #('abc' nil))
				do: [ :each |
					self
						assert: (self compare: each first to: each second with: aMethod)
						equals: each first = each second ].
			self assert: (self compare: 'abc' to: 'abc' asWideString with: aMethod).
			self assert: (self compare: 'abc' asWideString to: 'abc' with: aMethod).
			self assert: (self compare: 'abc' to: #abc with: aMethod) ].
	^ aMethod
]

{ #category : #private }
GtStrictSymbolComparisonPatchExamples >> symbolEqualsMethod [
	"Symbol>>#= as installed by GtStrictSymbolInstallation>>#installStringAndSymbolEquals, compiled but not installed"

	<return: #CompiledMethod>
	^ Symbol compiler compile: GtStrictSymbolInstallation new symbolEqualsSource
]

{ #category : #examples }
GtStrictSymbolComparisonPatchExamples >> symbolEqualsPatchWithStrictComparison [
	"With strict comparison, the patched Symbol>>#= answers true only for the receiver itself"

	<gtExample>
	<return: #CompiledMethod>
	| aMethod |
	aMethod := self symbolEqualsMethod.
	GtStrictSymbolComparisonFlag
		useStrictComparison: true
		during: [ self assert: (self compare: #abc to: #abc with: aMethod).
			self assert: (self compare: #abc to: #abd with: aMethod) not.
			self assert: (self compare: #abc to: 'abc' with: aMethod) not.
			self assert: (self compare: #abc to: 'abc' asWideString with: aMethod) not ].
	^ aMethod
]

{ #category : #examples }
GtStrictSymbolComparisonPatchExamples >> symbolEqualsPatchWithoutStrictComparison [
	"Without strict comparison, the patched Symbol>>#= answers what the Pharo Symbol>>#= answers"

	<gtExample>
	<return: #CompiledMethod>
	| aMethod |
	aMethod := self symbolEqualsMethod.
	self assert: aMethod isInstalled not.
	GtStrictSymbolComparisonFlag
		useStrictComparison: false
		during: [ { #abc -> #abc. #abc -> #abd. #abc -> 'abc'. #abc -> 'abd'. #abc -> 'abc' asWideString. #abc -> 42. #abc -> nil }
				do: [ :each |
					self
						assert: (self compare: each key to: each value with: aMethod)
						equals: each key = each value ].
			self assert: (self compare: #abc to: 'abc' with: aMethod) ].
	^ aMethod
]
