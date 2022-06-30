Extension { #name : #ClassDescription }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
ClassDescription >> gtAllSubclassesDefineVariable: aGtAdvice [
	<gtAdvice>
	^ aGtAdvice list
		priority: 40;
		name: 'Variable defined in all subclasses';
		description: [ :variables | 
			('All subclasses of ' , self name asString , ' define common instance variable'
				, (String
						streamContents: [ :stream | 
							variables size > 1 ifTrue: [ stream nextPut: $s ].
							stream nextPutAll: ' ('.
							variables
								do: [ :each | stream nextPutAll: each ]
								separatedBy: [ stream nextPutAll: ', ' ].
							stream nextPutAll: ').' ])) asRopedText ];
		compute: [ | vars subs problemVariables |
			subs := self subclasses.
			subs size <= 1
				ifTrue: [ #() ]
				ifFalse: [ vars := Bag new.
					subs
						do: [ :cls | cls instVarNames ifNotEmpty: [ :col | vars addAll: col ] ].
					problemVariables := OrderedCollection new.
					vars
						doWithOccurrences: [ :var :count | count = subs size ifTrue: [ problemVariables add: var ] ].
					problemVariables asSortedCollection ] ];
		actions: [ :variables | 
			variables
				select: [ :each | (self instVarNames includes: each) not ]
				thenCollect: [ :each | GtPullUpVariableAdviceAction pullUp: each into: self ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
ClassDescription >> gtInstanceVariableCase: aGtAdvice [
	<gtAdvice>
	^ aGtAdvice list
		priority: 20;
		name: 'Instance variable name should start with lowercase letters';
		description: [ :variables | 
			(self name asString , ' has instance variable'
				, (variables size > 1 ifTrue: [ 's' ] ifFalse: [ '' ]) , ' that start'
				, (variables size = 1 ifTrue: [ 's' ] ifFalse: [ '' ])
				, ' with uppercase letters '
				, (String
						streamContents: [ :stream | 
							stream nextPutAll: '('.
							variables
								do: [ :each | stream nextPutAll: each ]
								separatedBy: [ stream nextPutAll: ', ' ].
							stream nextPutAll: ').' ])) asRopedText ];
		compute: [ self instVarNames select: [ :each | each first isUppercase ] ];
		actions: [ :variables | 
			variables
				select: [ :each | self instVarNames includes: each ]
				thenCollect: [ :each | 
					GtRenameInstanceVariableAdviceAction
						rename: each
						to: each first asLowercase asString , each allButFirst
						in: self ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
ClassDescription >> gtNonAbstractClassHasAbstractMethods: aGtAdvice [
	<gtAdvice>
	^ aGtAdvice list
		priority: 100;
		name: 'Abstract methods in non abstract class';
		description: [ :result | 
			(String
				streamContents: [ :stream | 
					stream
						nextPutAll: self name;
						nextPutAll: ' has no subclasses, but has ';
						nextPutAll: (result size > 1 ifTrue: [ 'methods' ] ifFalse: [ 'a method' ]);
						nextPutAll: ' marked with subclassResponsibility ('.
					result
						do: [ :each | stream nextPutAll: each ]
						separatedBy: [ stream nextPutAll: ', ' ].
					stream nextPutAll: ').' ]) asRopedText ];
		compute: [ (self instanceSide isAbstract
				or: [ self isTrait or: [ self subclasses notEmpty ] ])
				ifTrue: [ #() ]
				ifFalse: [ ((GtPharoCompletionStrategy sendersOf: #subclassResponsibility)
						select: [ :each | each methodClass = self ]
						thenCollect: [ :each | each selector ]) asSortedCollection ] ];
		actions: [ :selectors | 
			selectors
				select: [ :each | self includesSelector: each ]
				thenCollect: [ :each | GtRemoveMethodAdviceAction remove: each from: self ] ]
]
