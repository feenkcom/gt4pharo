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
	| index noIndex indexOnly noIndexOnly |
	index := (GtPharoIndex current asyncImplementersForWord: 'adAl') toArray wait.
	noIndex := (GtPharoNoIndex new asyncImplementersForWord: 'adAl') toArray wait.
	indexOnly := (Set withAll: index) difference: noIndex.
	noIndexOnly := (Set withAll: noIndex) difference: index.
	self
		assert: (indexOnly isEmpty
				and: [ noIndexOnly isEmpty and: [ index size = noIndex size ] ])
		description: [ 'Index count: ' , index size printString , '; NoIndex count: '
				, noIndex size printString , '; Index only: ' , indexOnly printString
				, '; NoIndex only: ' , noIndexOnly printString ].
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
GtPharoNoIndexExamples >> asyncImplementersForWordUsesOriginalFFIMethod [
	<gtExample>
	^ self
		withGeneratedFFIMethodDo: [ :index :installed :original | 
			| indexed scanned |
			indexed := (index asyncImplementersForWord: 'noIndexExampleGeneratedFFI')
					toArray wait.
			scanned := (GtPharoNoIndex new
					asyncImplementersForWord: 'noIndexExampleGeneratedFFI') toArray wait.
			self assert: (indexed anySatisfy: [ :method | method == original ]).
			self assert: (scanned anySatisfy: [ :method | method == original ]).
			self assert: (scanned includes: installed) not.
			original ]
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
	| index noIndex indexOnly noIndexOnly |
	index := (GtPharoIndex current asyncSelectorsForWord: 'adAl') toArray wait.
	noIndex := (GtPharoNoIndex new asyncSelectorsForWord: 'adAl') toArray wait.
	indexOnly := (Set withAll: index) difference: noIndex.
	noIndexOnly := (Set withAll: noIndex) difference: index.
	self
		assert: (indexOnly isEmpty
				and: [ noIndexOnly isEmpty and: [ index size = noIndex size ] ])
		description: [ 'Index count: ' , index size printString , '; NoIndex count: '
				, noIndex size printString , '; Index only: ' , indexOnly printString
				, '; NoIndex only: ' , noIndexOnly printString ].
	^ {index.
		noIndex}
]

{ #category : #examples }
GtPharoNoIndexExamples >> asyncSelectorsForWordUsesOriginalFFILiterals [
	<gtExample>
	^ self
		withGeneratedFFIMethodDo: [ :index :installed :original | 
			| symbol indexed scanned |
			symbol := 'noIndexExampleOriginalFFILiteral' asSymbol.
			self assert: (installed allLiterals includes: symbol) not.
			self assert: (original allLiterals includes: symbol).
			indexed := (index asyncSelectorsForWord: symbol) toArray wait.
			scanned := (GtPharoNoIndex new asyncSelectorsForWord: symbol) toArray wait.
			self assert: (indexed includes: symbol).
			self assert: (scanned includes: symbol).
			original ]
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
	| index noIndex indexOnly noIndexOnly |
	index := GtPharoIndex current globalCache.
	self
		forPharo13AndNewer: [ index := index copyWithout: 'StackSignal' ]
		forOlder: [  ].
	noIndex := GtPharoNoIndex new globalCache.
	indexOnly := ((Set withAll: index) difference: noIndex)
			reject: [ :each | each beginsWith: 'TemporaryPackage' ].
	noIndexOnly := ((Set withAll: noIndex) difference: index)
			reject: [ :each | each beginsWith: 'TemporaryPackage' ].
	self
		assert: (indexOnly isEmpty and: [ noIndexOnly isEmpty ])
		description: [ 'Index count: ' , index size printString , '; NoIndex count: '
				, noIndex size printString , '; Index only: ' , indexOnly printString
				, '; NoIndex only: ' , noIndexOnly printString ].
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
GtPharoNoIndexExamples >> ignoredMethodsMatchMainIndex [
	<gtExample>
	| index noIndex anonymousClass methods |
	index := GtPharoIndex new.
	noIndex := GtPharoNoIndex new.
	anonymousClass := Object newAnonymousSubclass.
	anonymousClass compile: 'noIndexExampleAnonymousMethod ^ self'.
	anonymousClass class compile: 'noIndexExampleAnonymousClassMethod ^ self'.
	methods := {GtPharoNoIndexExampleTraitUser >> #noIndexExampleAliasedTraitMethod.
			TGtPharoNoIndexExampleTrait >> #noIndexExampleTraitMethod.
			GtPharoNoIndexExampleFFI >> #noIndexExampleGeneratedFFI.
			anonymousClass >> #noIndexExampleAnonymousMethod.
			anonymousClass class >> #noIndexExampleAnonymousClassMethod}.
	methods
		do: [ :method | 
			self
				assert: (noIndex isIgnoredMethod: method)
				equals: (index isIgnoredMethod: method) ].
	self assert: (noIndex isIgnoredMethod: methods first).
	self assert: (noIndex isIgnoredMethod: methods second) not.
	self assert: (noIndex isIgnoredMethod: methods third) not.
	self assert: (noIndex isIgnoredMethod: methods fourth).
	self assert: (noIndex isIgnoredMethod: methods fifth).
	^ methods
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
	| index noIndex indexOnly noIndexOnly |
	index := OrderedCollection new.
	noIndex := OrderedCollection new.
	GtPharoIndex current implementersDo: [ :e | index add: e ].
	GtPharoNoIndex new implementersDo: [ :e | noIndex add: e ].
	indexOnly := (GtStringContentSet withAll: index) difference: noIndex.
	noIndexOnly := (GtStringContentSet withAll: noIndex) difference: index.
	self
		assert: (indexOnly isEmpty
				and: [ noIndexOnly isEmpty and: [ index size = noIndex size ] ])
		description: [ 'Index count: ' , index size printString , '; NoIndex count: '
				, noIndex size printString , '; Index only: ' , indexOnly printString
				, '; NoIndex only: ' , noIndexOnly printString ].
	^ {index.
		noIndex}
]

{ #category : #examples }
GtPharoNoIndexExamples >> implementersDoExcludesTraitAliases [
	<gtExample>
	| selectors aliasSelector originalSelector |
	aliasSelector := #noIndexExampleAliasedTraitMethod.
	originalSelector := #noIndexExampleTraitMethod.
	self assert: (GtPharoNoIndexExampleTraitUser >> aliasSelector) isFromTrait.
	selectors := Set new.
	GtPharoNoIndex new implementersDo: [ :selector | selectors add: selector ].
	self assert: (selectors includes: aliasSelector) not.
	self assert: (selectors includes: originalSelector).
	self assert: (GtPharoNoIndex new implementersOf: aliasSelector) isEmpty.
	self assert: (GtPharoIndex current hasImplementersOf: aliasSelector) not.
	^ selectors
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
	index := (GtPharoIndex current selectorCache asyncStreamStartingWith: 'remove:')
			toArray wait.
	noIndex := (GtPharoNoIndex new selectorCache asyncStreamStartingWith: 'remove:')
			toArray wait.
	self assert: index size = noIndex size.
	diff := (GtStringContentSet withAll: index)
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

{ #category : #private }
GtPharoNoIndexExamples >> withGeneratedFFIMethodDo: aBlock [
	| installed original index |
	installed := GtPharoNoIndexExampleFFI >> #noIndexExampleGeneratedFFI.
	original := installed copy.
	original literalAt: 1 put: 'noIndexExampleOriginalFFILiteral' asSymbol.
	original propertyAt: #isFFIMethod put: true.
	[ installed propertyAt: #isFFIMethod put: true.
	installed propertyAt: #ffiNonCompiledMethod put: original.
	index := GtPharoIndex new.
	index methodAdded: (MethodAdded method: installed).
	^ aBlock
		value: index
		value: installed
		value: original ]
		ensure: [ installed removeProperty: #ffiNonCompiledMethod.
			installed removeProperty: #isFFIMethod ]
]
