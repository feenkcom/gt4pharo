Class {
	#name : #GtRefactoryTyper,
	#superclass : #RBRefactoryTyper,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring'
}

{ #category : #accessing }
GtRefactoryTyper >> guessTypesFor: anInstVarName in: aClass [
	| selectors getters searcher cls |
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
	cls withAllSubclasses
		do: [ :each | 
			(each whichSelectorsReferToInstanceVariable: anInstVarName)
				do: [ :sel | searcher executeTree: (each parseTreeFor: sel) ] ].
	getters
		do: [ :getter | 
			getter numArgs = 0
				ifTrue: [ searcher := RBParseTreeSearcher new.
					searcher
						matches: 'self ' , getter , ' `@msg: ``@args'
						do: [ :msg :obj | selectors add: msg selector ].
					cls withAllSubclasses
						do: [ :each | 
							(each whichSelectorsReferToSymbol: getter)
								do: [ :sel | searcher executeTree: (each parseTreeFor: sel) ] ] ] ].
	^ self findTypeFor: selectors
]

{ #category : #accessing }
GtRefactoryTyper >> implementorsOf: aSelector [
	| implementers topLevelImplementers |
	implementers := (model allImplementorsOfIncludingTraits: aSelector)
			asSortedCollection: [ :a :b | (self superclassCount: a) < (self superclassCount: b) ].
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
