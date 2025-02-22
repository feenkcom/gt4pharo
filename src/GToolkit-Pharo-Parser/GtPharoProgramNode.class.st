Class {
	#name : #GtPharoProgramNode,
	#superclass : #SmaCCParseNode,
	#category : #'GToolkit-Pharo-Parser-Parser'
}

{ #category : #'api - ast' }
GtPharoProgramNode class >> typeOf: aGtPharoProgramNode in: aClass bindings: theBindings [
	"Given a pharo ast node and a class find the return type of the node"

	(aGtPharoProgramNode isVariable and: [ aGtPharoProgramNode isSelf ])
		ifTrue: [ ^ aClass ].

	(aGtPharoProgramNode isVariable and: [ aGtPharoProgramNode isSuper ])
		ifTrue: [ ^ aClass ifNotNil: [ :class | class superclass ] ].

	(aGtPharoProgramNode isVariable and: [ aGtPharoProgramNode isThisContext ])
		ifTrue: [ ^ Context ].

	aGtPharoProgramNode isVariable
		ifTrue: [ | aVariableName |
			aVariableName := aGtPharoProgramNode name value asSymbol.

			aGtPharoProgramNode whoDefines
				ifNotNil: [ :aNode | 
					(theBindings notNil and: [ theBindings hasBindingOf: aVariableName ])
						ifTrue: [ (theBindings bindingValueOf: aVariableName)
								ifNotNil: [ :aValue | ^ aValue class ] ].
					^ nil ].

			self class environment
				at: aVariableName
				ifPresent: [ :anObject | ^ anObject class ].

			^ (theBindings notNil and: [ theBindings hasBindingOf: aVariableName ])
				ifTrue: [ (theBindings bindingValueOf: aVariableName)
						ifNotNil: [ :aValue | aValue class ] ] ].

	aGtPharoProgramNode isLiteral
		ifTrue: [ ^ aGtPharoProgramNode literalValue class ].

	(aGtPharoProgramNode isKindOf: GtPharoArrayNode) ifTrue: [ ^ {} class ].

	(aGtPharoProgramNode isKindOf: GtPharoBlockNode) ifTrue: [ ^ [  ] class ].

	aGtPharoProgramNode isMessageSend
		ifTrue: [ aGtPharoProgramNode selector = #class
				ifTrue: [ ^ (self
						typeOf: aGtPharoProgramNode receiver
						in: aClass
						bindings: theBindings) ifNotNil: [ :class | class class ] ].
			(#(new new:) includes: aGtPharoProgramNode selector)
				ifTrue: [ (aGtPharoProgramNode receiver isVariable
						and: [ aGtPharoProgramNode receiver isSuper ])
						ifTrue: [ ^ aClass ifNotNil: [ :class | class instanceSide ] ].
					^ (self
						typeOf: aGtPharoProgramNode receiver
						in: aClass
						bindings: theBindings) ifNotNil: [ :class | class instanceSide ] ] ].

	^ nil
]

{ #category : #generated }
GtPharoProgramNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitProgram: self
]

{ #category : #accessing }
GtPharoProgramNode >> bestNodeFor: anInterval ifFound: aFoundBlock ifNone: aNoneBlock [
	| selectedChildren |
	
	self
		assert: [ anInterval notNil ]
		description: [ 'Interval must not be nil' ].
	
	(self intersectsInterval: anInterval)
		ifFalse: [ ^ aNoneBlock value ].

	(self containedBy: anInterval)
		ifTrue: [ ^ aFoundBlock value: self ].
	
	selectedChildren := self children
		select: [ :eachChildNode | eachChildNode intersectsInterval: anInterval ].

	^ selectedChildren size = 1 
		ifTrue: [ selectedChildren first bestNodeFor: anInterval ifFound: aFoundBlock ifNone: aNoneBlock ]
		ifFalse: [ aFoundBlock value: self ]
]

{ #category : #testing }
GtPharoProgramNode >> containedBy: anInterval [
	"Return true if this node is contained within the interval (or equal to the interval)"
	<return: #Boolean>

	^ anInterval first <= self startPosition and: [ anInterval last >= self stopPosition ]
]

{ #category : #testing }
GtPharoProgramNode >> defines: aString [
	^ false
]

{ #category : #accessing }
GtPharoProgramNode >> findVariableNodeAt: anInteger [
	self
		nodesDo:
			[ :each | (each findVariableNodeAt: anInteger) ifNotNil: [ :node | ^ node ] ]
		andTokensDo: [ :each |  ]
		includeErrors: true.
	^ nil
]

{ #category : #accessing }
GtPharoProgramNode >> implicitLocalVariables [
	| variables |
	variables := self localVariables.
	self topParent
		allNodesOfType: GtPharoVariableNode
		do: [ :each | 
			(each == self or: [ each isLocallyDefined ])
				ifFalse: [ variables add: each variableName ] ].
	^ variables
]

{ #category : #accessing }
GtPharoProgramNode >> indexOfTrailingPeriodIfAny [
	| index |
	parent isSequence ifFalse: [ ^ self sourceInterval last ].
	index := parent periods
			findFirst: [ :each | each startPosition > self stopPosition ].
	index isZero ifTrue: [ ^ self sourceInterval last ].
	^ (parent periods at: index) sourceInterval last
]

{ #category : #testing }
GtPharoProgramNode >> intersectsInterval: anInterval [
	<return: #Boolean>

	^ (anInterval first between: self startPosition and: self stopPosition) 
		or: [ self startPosition between: anInterval first and: anInterval last ]
]

{ #category : #testing }
GtPharoProgramNode >> isAssignment [
	^ false
]

{ #category : #testing }
GtPharoProgramNode >> isBlock [
	^ false
]

{ #category : #testing }
GtPharoProgramNode >> isCascade [
	^ false
]

{ #category : #testing }
GtPharoProgramNode >> isKeyword [
	^ false
]

{ #category : #testing }
GtPharoProgramNode >> isLiteral [
	^ false
]

{ #category : #testing }
GtPharoProgramNode >> isMessage [
	^ false
]

{ #category : #testing }
GtPharoProgramNode >> isMessageSend [
	^ false
]

{ #category : #testing }
GtPharoProgramNode >> isMethod [
	^ false
]

{ #category : #testing }
GtPharoProgramNode >> isMethodPattern [
	^ false
]

{ #category : #testing }
GtPharoProgramNode >> isPragma [
	^ false
]

{ #category : #testing }
GtPharoProgramNode >> isReturn [
	^ false
]

{ #category : #testing }
GtPharoProgramNode >> isSelf [
	^ false
]

{ #category : #testing }
GtPharoProgramNode >> isSequence [
	^ false
]

{ #category : #testing }
GtPharoProgramNode >> isSuper [
	^ false
]

{ #category : #accessing }
GtPharoProgramNode >> isUsed [
	parent ifNil: [ ^ true ].
	parent isValueNode ifTrue: [ ^ true ].
	parent isReturn ifTrue: [ ^ true ].
	parent isMessage ifTrue: [ ^ true ].
	(parent isSequence
		and: [ parent statements notEmpty and: [ parent statements last == self ] ])
		ifTrue: [ parent parent ifNil: [ ^ true ].
			parent parent isBlock
				ifTrue: [ | node |
					node := parent parent parent.
					node isMessage
						ifTrue: [ (#(#ifTrue: #ifTrue:ifFalse: #ifFalse: #ifFalse:ifTrue: #whileTrue: #whileFalse: #ifNil: #ifNil:ifNotNil: #ifNotNil: #ifNotNil:ifNil:)
								includes: node selector) ifTrue: [ ^ node isUsed ] ].
					^ true ] ].
	parent isPragma ifTrue: [ ^ true ].
	^ false
]

{ #category : #testing }
GtPharoProgramNode >> isValueNode [
	^ false
]

{ #category : #testing }
GtPharoProgramNode >> isVariable [
	^ false
]

{ #category : #testing }
GtPharoProgramNode >> isVariableDefinition [
	^ false
]

{ #category : #accessing }
GtPharoProgramNode >> localVariablesInto: aCollection [
	| ancestor |
	ancestor := parent.
	[ ancestor notNil and: [ (ancestor isKindOf: GtPharoProgramNode) not ] ] whileTrue: [ ancestor := ancestor parent ].
	ancestor isNil ifTrue: [ ^ self ].
	ancestor localVariablesInto: aCollection
]

{ #category : #accessing }
GtPharoProgramNode >> messageReceiver [
	^ self
]

{ #category : #accessing }
GtPharoProgramNode >> methodNode [
	^ parent ifNotNil: [ parent methodNode ]
]

{ #category : #testing }
GtPharoProgramNode >> needsParenthesisForKeyword [
	^ false
]

{ #category : #accessing }
GtPharoProgramNode >> nestingLevel [
	^ (parent notNil and: [ parent isErrorNode not ])
		ifTrue: [ parent nestingLevel ]
		ifFalse: [ 0 ]
]

{ #category : #'as yet unclassified' }
GtPharoProgramNode >> pragmasNamed: aSelector [
	^ parent
		ifNil: [ #() ]
		ifNotNil: [ | method |
			method := self topParent.
			method isErrorNode
				ifTrue: [ #() ]
				ifFalse: [ method pragmasNamed: aSelector ] ]
]

{ #category : #accessing }
GtPharoProgramNode >> priority [
	^ SmallInteger maxVal
]

{ #category : #accessing }
GtPharoProgramNode >> statementNode [
	"Return your topmost node that is contained by a sequence node."

	(parent isNil or: [parent isSequence]) ifTrue: [^self].
	^parent statementNode
]

{ #category : #accessing }
GtPharoProgramNode >> whoDefines: aName [ 
	^ (self defines: aName) 
		ifTrue: [ self ]
		ifFalse: [ parent
			ifNotNil: [ parent whoDefines: aName ]
			ifNil: [ nil ] ]
]

{ #category : #enumerating }
GtPharoProgramNode >> withAllParentsDo: aBlock [
	| node |
	node := self.
	[ node notNil ]
		whileTrue: [
			aBlock value: node.
			node := node parent ]
]
