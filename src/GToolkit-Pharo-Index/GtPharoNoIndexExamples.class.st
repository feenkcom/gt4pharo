Class {
	#name : #GtPharoNoIndexExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Index'
}

{ #category : #examples }
GtPharoNoIndexExamples >> allImplementers [
	<gtExample>
	| index noIndex diff |
	index := GtPharoIndex current allImplementersOf: #initialize.
	noIndex := GtPharoNoIndex new allImplementersOf: #initialize.
	self assert: index size >= noIndex size.
	diff := (IdentitySet withAll: index)
			removeAll: noIndex;
			yourself.
	diff do: [ :each | self assert: each gtIsActive not ].
	^ {index.
		noIndex}
]

{ #category : #examples }
GtPharoNoIndexExamples >> allSenders [
	<gtExample>
	| index noIndex diff |
	index := GtPharoIndex current allSendersOf: #add:.
	noIndex := GtPharoNoIndex new allSendersOf: #add:.
	self assert: index size >= noIndex size.
	diff := (IdentitySet withAll: index)
			removeAll: noIndex;
			yourself.
	diff do: [ :each | self assert: each gtIsActive not ].
	^ {index.
		noIndex}
]

{ #category : #examples }
GtPharoNoIndexExamples >> asyncClassNamesForWord [
	<gtExample>
	| index noIndex |
	index := (GtPharoIndex current asyncClassNamesForWord: 'OrColl') toArray wait.
	noIndex := (GtPharoNoIndex new asyncClassNamesForWord: 'OrColl') toArray wait.
	self assert: noIndex size equals: index size.
	self
		assert: ((Set withAll: index)
				removeAll: noIndex;
				size)
		equals: 0.
	^ {index.
		noIndex}
]

{ #category : #examples }
GtPharoNoIndexExamples >> asyncImplementersForWord [
	<gtExample>
	| index noIndex |
	index := (GtPharoIndex current asyncImplementersForWord: 'adAl') toArray wait.
	noIndex := (GtPharoNoIndex new asyncImplementersForWord: 'adAl') toArray wait.
	self assert: noIndex size equals: index size.
	self
		assert: ((Set withAll: index)
				removeAll: noIndex;
				size)
		equals: 0.
	^ {index.
		noIndex}
]

{ #category : #examples }
GtPharoNoIndexExamples >> asyncImplementersForWordConvertUsing [
	<gtExample>
	| index noIndex |
	index := (GtPharoIndex current
			asyncImplementersForWord: 'adAl'
			convertUsing: [ :s | 
				(OrderedCollection whichClassIncludesSelector: s asSymbol)
					ifNotNil: [ :c | c >> s asSymbol ] ]) toArray wait.
	noIndex := (GtPharoNoIndex new
			asyncImplementersForWord: 'adAl'
			convertUsing: [ :s | 
				(OrderedCollection whichClassIncludesSelector: s asSymbol)
					ifNotNil: [ :c | c >> s asSymbol ] ]) toArray wait.
	self assert: noIndex size equals: index size.
	self
		assert: ((Set withAll: index)
				removeAll: noIndex;
				size)
		equals: 0.
	^ {index.
		noIndex}
]

{ #category : #examples }
GtPharoNoIndexExamples >> asyncKeywordImplementors [
	<gtExample>
	| index noIndex |
	index := (GtPharoIndex current asyncKeywordImplementorsFor: #('with:' 'with:'))
			toArray wait.
	noIndex := (GtPharoNoIndex new asyncKeywordImplementorsFor: #('with:' 'with:'))
			toArray wait.
	self assert: noIndex size equals: index size.
	self
		assert: ((Set withAll: index)
				removeAll: noIndex;
				yourself) isEmpty.
	^ {index.
		noIndex}
]

{ #category : #examples }
GtPharoNoIndexExamples >> asyncSelectorsForWord [
	<gtExample>
	| index noIndex |
	index := (GtPharoIndex current asyncSelectorsForWord: 'adAl') toArray wait.
	noIndex := (GtPharoNoIndex new asyncSelectorsForWord: 'adAl') toArray wait.
	self assert: noIndex size equals: index size.
	self
		assert: ((Set withAll: index)
				removeAll: noIndex;
				yourself) isEmpty.
	^ {index.
		noIndex}
]

{ #category : #examples }
GtPharoNoIndexExamples >> classNameTree [
	<gtExample>
	| index noIndex |
	index := GtPharoIndex current classNameTree.
	noIndex := GtPharoNoIndex new classNameTree.
	index do: [ :each | self assert: (noIndex includes: each) ].
	noIndex do: [ :each | self assert: (index includes: each) ].
	^ {index.
		noIndex}
]

{ #category : #examples }
GtPharoNoIndexExamples >> globalCache [
	<gtExample>
	| index noIndex |
	index := GtPharoIndex current globalCache.
	noIndex := GtPharoNoIndex new globalCache.
	index do: [ :each | self assert: (noIndex includes: each) ].
	noIndex do: [ :each | self assert: (index includes: each) ].
	^ {index.
		noIndex}
]

{ #category : #examples }
GtPharoNoIndexExamples >> globalVariableReferences [
	<gtExample>
	| index noIndex |
	index := GtPharoIndex current
			globalVariableReferencesTo: (self class environment bindingOf: #OrderedCollection).
	noIndex := GtPharoNoIndex new
			globalVariableReferencesTo: (self class environment bindingOf: #OrderedCollection).
	self assert: index size equals: noIndex size.
	self
		assert: ((IdentitySet withAll: index)
				removeAll: noIndex;
				size)
		equals: 0.
	^ {index.
		noIndex}
]

{ #category : #examples }
GtPharoNoIndexExamples >> hasImplementersOf [
	<gtExample>
	| index noIndex |
	index := GtPharoIndex current hasImplementersOf: thisContext selector.
	noIndex := GtPharoNoIndex new hasImplementersOf: thisContext selector.
	self assert: noIndex equals: index.
	^ {index.
		noIndex}
]

{ #category : #examples }
GtPharoNoIndexExamples >> implementers [
	<gtExample>
	| index noIndex |
	index := GtPharoIndex current implementersOf: #initialize.
	noIndex := GtPharoNoIndex new implementersOf: #initialize.
	self assert: index size equals: noIndex size.
	self
		assert: ((IdentitySet withAll: index)
				removeAll: noIndex;
				size)
		equals: 0.
	^ {index.
		noIndex}
]

{ #category : #examples }
GtPharoNoIndexExamples >> implementersDo [
	<gtExample>
	| index noIndex |
	index := OrderedCollection new.
	noIndex := OrderedCollection new.
	GtPharoIndex current implementersDo: [ :e | index add: e ].
	GtPharoNoIndex new implementersDo: [ :e | noIndex add: e ].
	self assert: index size equals: noIndex size.
	self
		assert: ((Set withAll: index)
				removeAll: noIndex;
				size)
		equals: 0.
	^ {index.
		noIndex}
]

{ #category : #examples }
GtPharoNoIndexExamples >> implementersOfTraitMethods [
	<gtExample>
	| index noIndex |
	index := GtPharoIndex current implementersOf: #toArray.
	noIndex := GtPharoNoIndex new implementersOf: #toArray.
	self assert: index size equals: noIndex size.
	self
		assert: ((IdentitySet withAll: index)
				removeAll: noIndex;
				size)
		equals: 0.
	^ {index.
		noIndex}
]

{ #category : #examples }
GtPharoNoIndexExamples >> selectorCache [
	<gtExample>
	| index noIndex diff |
	index := (GtPharoIndex current selectorCache asyncStreamStartingWith: 'add:')
			toArray wait.
	noIndex := (GtPharoNoIndex new selectorCache asyncStreamStartingWith: 'add:')
			toArray wait.
	self assert: index size = noIndex size.
	diff := (Set withAll: index)
			removeAll: noIndex;
			yourself.
	^ {index.
		noIndex}
]

{ #category : #examples }
GtPharoNoIndexExamples >> senders [
	<gtExample>
	| index noIndex |
	index := GtPharoIndex current sendersOf: #at:.
	noIndex := GtPharoNoIndex new sendersOf: #at:.
	self assert: index size equals: noIndex size.
	self
		assert: ((IdentitySet withAll: index)
				removeAll: noIndex;
				size)
		equals: 0.
	^ {index.
		noIndex}
]
