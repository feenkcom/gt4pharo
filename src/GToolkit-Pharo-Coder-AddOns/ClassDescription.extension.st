Extension { #name : #ClassDescription }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
ClassDescription >> gtAllSubclassesDefineVariable: aGtAdvice [
	<gtAdvice: 40>
	| vars subs problemVariables |
	subs := self subclasses.
	subs size <= 1 ifTrue: [ ^ aGtAdvice none ].
	vars := Bag new.
	subs
		do: [ :cls | 
			cls instVarNames
				ifNotEmpty: [ :col | vars addAll: col ]
				ifEmpty: [ ^ aGtAdvice none ] ].
	problemVariables := OrderedCollection new.
	vars
		doWithOccurrences: [ :var :count | count = subs size ifTrue: [ problemVariables add: var ] ].
	^ problemVariables isEmpty
		ifTrue: [ aGtAdvice none ]
		ifFalse: [ (GtAllSubclassesDefineVariableAdvice on: aGtAdvice)
				behavior: self;
				variables: problemVariables asSortedCollection;
				yourself ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
ClassDescription >> gtInstanceVariableCase: aGtAdvice [
	<gtAdvice: 20>
	^ (self instVarNames select: [ :each | each first isUppercase ])
		ifEmpty: [ aGtAdvice none ]
		ifNotEmpty: [ :vars | 
			(GtInstanceVariableCaseAdvice on: aGtAdvice)
				behavior: self;
				variables: vars asSortedCollection;
				yourself ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
ClassDescription >> gtNonAbstractClassHasAbstractMethods: aGtAdvice [
	<gtAdvice: 100>
	(self instanceSide isAbstract
		or: [ self isTrait or: [ self subclasses notEmpty ] ])
		ifTrue: [ ^ aGtAdvice none ].
	((GtPharoCompletionStrategy sendersOf: #subclassResponsibility)
		anySatisfy: [ :each | each methodClass = self ]) ifFalse: [ ^ aGtAdvice none ].
	^ (GtNonAbstractClassHasAbstractMethodsAdvice on: aGtAdvice) behavior: self
]
