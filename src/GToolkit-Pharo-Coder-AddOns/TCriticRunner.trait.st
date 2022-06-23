Trait {
	#name : #TCriticRunner,
	#category : #'GToolkit-Pharo-Coder-AddOns-Critics'
}

{ #category : #accessing }
TCriticRunner >> behavior [
	^ nil class
]

{ #category : #accessing }
TCriticRunner >> foundIssue: aCritic in: aNode [
]

{ #category : #testing }
TCriticRunner >> hasDeclaredGlobalNamed: aString [
	^ self class environment includesKey: aString asSymbol
]

{ #category : #testing }
TCriticRunner >> hasDeclaredVariableNamed: aString [
	| class |
	class := self behavior.
	(class classThatDefinesInstVarNamed: aString) ifNotNil: [ ^ true ].
	(class classThatDefinesClassVariable: aString) ifNotNil: [ ^ true ].
	^ class instanceSide allSharedPools
		anySatisfy: [ :each | each classPool includesKey: aString asSymbol ]
]

{ #category : #testing }
TCriticRunner >> hasRefactoring [
	^ false
]

{ #category : #typing }
TCriticRunner >> typeOf: aGtPharoProgramNode [
	^ GtPharoProgramNode
		typeOf: aGtPharoProgramNode
		in: self behavior
		bindings: nil
]
