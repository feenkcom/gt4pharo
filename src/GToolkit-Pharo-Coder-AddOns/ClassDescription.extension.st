Extension { #name : #ClassDescription }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
ClassDescription >> gtAllSubclassesDefineVariable: aGtAdvice [
	<gtAdvice>
	^ aGtAdvice list
		priority: 40;
		description: [ :each | (each , ' is defined in all subclasses') asRopedText ];
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
		action: [ :each | 
			(self instVarNames includes: each)
				ifFalse: [ GtPullUpVariableAdviceAction pullUp: each into: self ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
ClassDescription >> gtInstanceVariableCase: aGtAdvice [
	<gtAdvice>
	^ aGtAdvice list
		priority: 20;
		description: [ :each | (each , ' should start with a lowercase letter') asRopedText ];
		compute: [ self instVarNames select: [ :each | each first isUppercase ] ];
		action: [ :each | 
			(self instVarNames includes: each)
				ifTrue: [ GtRenameInstanceVariableAdviceAction
						rename: each
						to: each first asLowercase asString , each allButFirst
						in: self ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
ClassDescription >> gtNonAbstractClassHasAbstractMethods: aGtAdvice [
	<gtAdvice>
	^ aGtAdvice list
		priority: 100;
		description: [ :each | ('#' , each , ' is an abstract method in a non-abstract class') asRopedText ];
		compute: [ (self instanceSide isAbstract
				or: [ self isTrait or: [ self subclasses notEmpty ] ])
				ifTrue: [ #() ]
				ifFalse: [ ((GtPharoCompletionStrategy sendersOf: #subclassResponsibility)
						select: [ :each | each methodClass = self ]
						thenCollect: [ :each | each selector ]) asSortedCollection ] ];
		action: [ :each | 
			(self includesSelector: each)
				ifTrue: [ GtRemoveMethodAdviceAction remove: each from: self ] ]
]
