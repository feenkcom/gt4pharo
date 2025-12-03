Class {
	#name : #GtRefactoryTyper,
	#superclass : #RBRefactoryTyper,
	#classVars : [
		'Timeout'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-Refactoring - Base'
}

{ #category : #accessing }
GtRefactoryTyper class >> timeout [
	^ Timeout ifNil: [ 500000 ]
]

{ #category : #accessing }
GtRefactoryTyper class >> timeout: microSeconds [
	Timeout := microSeconds
]

{ #category : #accessing }
GtRefactoryTyper >> gatherSelectorsSentTo: anInstVarName in: aClass [
	| getters selectors searcher cls startTime |
	startTime := Time microsecondClockValue.
	cls := model classFor: aClass.
	selectors := Set new.
	getters := Set new.
	searcher := RBParseTreeSearcher new.
	searcher
		matches: anInstVarName , '`@msg: ``@args'
		do: [ :msg :obj | selectors add: msg selector ].
	searcher
		matches: '^' , anInstVarName
		do: [ :node :obj | getters add: node methodNode selector ].
	searcher
		matches: '^' , anInstVarName , ' ifNil: ``@a'
		do: [ :node :obj | getters add: node methodNode selector ].
	cls
		gtWithAllSubclassesDo: [ :each | 
			each
				gtSelectorsReferToInstanceVariable: anInstVarName
				do: [ :sel | 
					searcher executeTree: (each parseTreeForSelector: sel).
					Time microsecondClockValue - startTime > self class timeout
						ifTrue: [ ^ selectors ] ] ].
	getters
		do: [ :getter | 
			getter numArgs = 0
				ifTrue: [ searcher := RBParseTreeSearcher new.
					searcher
						matches: 'self ' , getter , ' `@msg: ``@args'
						do: [ :msg :obj | selectors add: msg selector ].
					cls
						gtWithAllSubclassesDo: [ :each | 
							each
								gtSelectorsReferToSymbol: getter
								do: [ :sel | 
									searcher executeTree: (each parseTreeForSelector: sel).
									Time microsecondClockValue - startTime > self class timeout
										ifTrue: [ ^ selectors ] ] ] ] ].
	^ selectors
]

{ #category : #accessing }
GtRefactoryTyper >> guessTypesFor: anInstVarName in: aClass [
	| selectors |
	selectors := self gatherSelectorsSentTo: anInstVarName in: aClass.
	^ self findTypeFor: selectors
]

{ #category : #accessing }
GtRefactoryTyper >> implementorsOf: aSelector [
	| implementers topLevelImplementers superclassCounts |
	superclassCounts := Dictionary new.
	implementers := (model allImplementorsOfIncludingTraits: aSelector)
			asSortedCollection: [ :a :b | 
				(superclassCounts at: a ifAbsentPut: [ self superclassCount: a ])
					< (superclassCounts at: b ifAbsentPut: [ self superclassCount: b ]) ].
	topLevelImplementers := Set new.
	implementers
		do: [ :each | 
			| found current |
			found := false.
			current := each superclass.
			[ found or: [ current isNil ] ]
				whileFalse: [ found := topLevelImplementers includes: current.
					current := current superclass ].
			found ifFalse: [ topLevelImplementers add: each ] ].
	^ topLevelImplementers
]

{ #category : #accessing }
GtRefactoryTyper >> superclassCount: aClass [
	| count current |
	count := 0.
	current := aClass superclass.
	[ current notNil ]
		whileTrue: [ current := current superclass.
			count := count + 1 ].
	^ count
]
