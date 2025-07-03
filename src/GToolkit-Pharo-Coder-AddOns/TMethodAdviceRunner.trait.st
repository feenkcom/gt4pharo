Trait {
	#name : #TMethodAdviceRunner,
	#category : #'GToolkit-Pharo-Coder-AddOns-MethodAdvices'
}

{ #category : #accessing }
TMethodAdviceRunner >> behavior [
	^ nil class
]

{ #category : #accessing }
TMethodAdviceRunner >> foundIssue: aCritic in: aNode [
]

{ #category : #testing }
TMethodAdviceRunner >> hasDeclaredGlobalNamed: aString [
	^ self class environment includesKey: aString asSymbol
]

{ #category : #testing }
TMethodAdviceRunner >> hasDeclaredVariableNamed: aString [
	| class |
	class := self behavior.
	(class classThatDefinesInstVarNamed: aString) ifNotNil: [ ^ true ].
	(class instanceSide classThatDefinesClassVariable: aString) ifNotNil: [ ^ true ].
	^ class instanceSide allSharedPools
		anySatisfy: [ :each | each classPool includesKey: aString asSymbol ]
]

{ #category : #testing }
TMethodAdviceRunner >> hasRefactoring [
	^ false
]

{ #category : #accessing }
TMethodAdviceRunner >> textAttributesAt: anInteger [
	^ #()
]

{ #category : #typing }
TMethodAdviceRunner >> typeOf: aGtPharoProgramNode [
	^ GtPharoProgramNode
		typeOf: aGtPharoProgramNode
		in: self behavior
		bindings: nil
]
