Class {
	#name : #GtExtractToWrappedMethodObjectRefactoring,
	#superclass : #GtExtractMethodObjectRefactoring,
	#instVars : [
		'methodObjectSelector',
		'useSetMethod'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring'
}

{ #category : #accessing }
GtExtractToWrappedMethodObjectRefactoring >> addWrappedCall [
	| ast |
	ast := class parseTreeForSelector: selector.
	ast
		nodesDo: [ :each | 
			(each isMessage
				and: [ each selector = methodObjectSelector
						and: [ self isMethodObject: each receiver ] ])
				ifTrue: [ self insertWrappedSendOn: each ] ].
	class compileTree: ast
]

{ #category : #accessing }
GtExtractToWrappedMethodObjectRefactoring >> createConstructor: methodName [
	super createConstructor: methodName.
	self createSetMethod: methodName.
	self fixConstructorArguments: methodName
]

{ #category : #accessing }
GtExtractToWrappedMethodObjectRefactoring >> createSetMethod: methodName [
	| ast meta removeCascadeRefactoring cascade extractSetMethodRefactoring tempName setSelector |
	(self useSetMethod not and: [ methodName arguments isEmpty ])
		ifTrue: [ ^ self ].

	meta := (self model classNamed: className) classSide.
	ast := meta parseTreeForSelector: methodName selector.
	ast ifNil: [ ^ self ].
	cascade := ast statements last value.
	cascade isCascade ifFalse: [ ^ self ].
	removeCascadeRefactoring := GtConvertCascadesToStatementsRefactoring
			model: self model
			convert: cascade sourceInterval
			inMethod: methodName selector
			forClass: meta.
	removeCascadeRefactoring
		setOption: #receiverName
		toUse: [ :ref | tempName := 'var' , UUID new asString36 ].
	self performCompositeRefactoring: removeCascadeRefactoring.

	ast := meta parseTreeForSelector: methodName selector.
	extractSetMethodRefactoring := GtExtractMethodToComponentRefactoring
			model: model
			extract: (ast statements second start
					to: (ast statements at: ast statements size - 1) stop)
			from: methodName selector
			in: meta.
	extractSetMethodRefactoring
		setOption: #renameTemporaries toUse: [ :ref | true ];
		setOption: #methodName
			toUse: [ :mn :ref | 
				setSelector := ('set' , methodName selector asString capitalized) asSymbol.
				mn selector: setSelector.
				mn
					arguments: (mn arguments
							asSortedCollection: [ :a :b | 
								(methodName arguments
									indexOf: a
									ifAbsent: [ methodName arguments indexOf: 'self' ])
									< (methodName arguments
											indexOf: b
											ifAbsent: [ methodName arguments indexOf: 'self' ]) ]).
				mn ];
		setOption: #selectVariableToMoveTo toUse: [ :ref :cls :sel | tempName ];
		setOption: #variableTypes
			toUse: [ :ref :types :selected | {meta instanceSide} ];
		setOption: #useExistingMethod toUse: [ :ref :sel | false ].
	self performCompositeRefactoring: extractSetMethodRefactoring.

	ast := meta parseTreeForSelector: methodName selector.
	self
		performCompositeRefactoring: (GtConvertStatementsToCascadesRefactoring
				model: self model
				convert: (ast statements first start
						to: (ast statements at: ast statements size - 1) stop)
				inMethod: methodName selector
				forClass: meta).

	ast := meta parseTreeForSelector: methodName selector.
	self
		performCompositeRefactoring: (RBInlineTemporaryRefactoring
				model: self model
				inline: ast statements first sourceInterval
				from: methodName selector
				in: meta).
	self model changes
		gtSelector: setSelector
		in: (self model classNamed: className)
		classified: #private
]

{ #category : #accessing }
GtExtractToWrappedMethodObjectRefactoring >> extractToNewClass [
	super extractToNewClass.
	self options
		at: #methodProtocol
		ifPresent: [ :block | 
			(block cull: methodObjectSelector cull: self)
				ifNotNil: [ :protocol | 
					self model changes
						gtSelector: methodObjectSelector
						in: (self model classNamed: className)
						classified: protocol ] ]
]

{ #category : #accessing }
GtExtractToWrappedMethodObjectRefactoring >> fixConstructorArguments: methodName [
	| meta ast |
	meta := (self model classNamed: className) classSide.
	ast := meta parseTreeForSelector: methodName selector.
	ast ifNil: [ ^ self ].
	ast arguments
		do: [ :each | 
			| name newName |
			name := each name.
			(((name beginsWith: 'an') and: [ (name at: 3 ifAbsent: [ $a ]) isUppercase ])
				or: [ (name beginsWith: 'a') and: [ (name at: 2 ifAbsent: [ $a ]) isUppercase ] ])
				ifFalse: [ newName := (name first isVowel ifTrue: [ 'an' ] ifFalse: [ 'a' ])
							, name capitalized.
					ast
						nodesDo: [ :node | 
							(node isVariable and: [ node name = name ])
								ifTrue: [ node replaceWith: (RBVariableNode named: newName) ] ] ] ].
	meta compileTree: ast
]

{ #category : #initialization }
GtExtractToWrappedMethodObjectRefactoring >> initialize [
	super initialize.
	self setOption: #splitVariableLifetimes toUse: [ true ]
]

{ #category : #accessing }
GtExtractToWrappedMethodObjectRefactoring >> insertWrappedSendOn: aMessageNode [
	| newReceiver newMethodName newNode |
	newReceiver := (self options at: #wrappedReceiver)
			cull: (aMessageNode arguments collect: #name)
			cull: self.
	newMethodName := RBMethodName new.
	newMethodName selector: aMessageNode selector.
	newMethodName
		arguments: #('~') , ((aMessageNode arguments collect: #name) copyWithout: newReceiver).
	newMethodName := (self options at: #wrappedMethodName)
			cull: newMethodName
			cull: self.
	newNode := RBMessageNode
			receiver: (RBVariableNode named: newReceiver)
			selector: newMethodName selector
			arguments: (newMethodName arguments
					collect: [ :each | 
						each = '~'
							ifTrue: [ aMessageNode receiver copy ]
							ifFalse: [ RBVariableNode named: each ] ]).
	aMessageNode replaceWith: newNode
]

{ #category : #accessing }
GtExtractToWrappedMethodObjectRefactoring >> isMethodObject: aNode [
	aNode isMessage
		ifTrue: [ ^ aNode receiver isVariable and: [ aNode receiver name = className ] ].
	aNode isCascade
		ifTrue: [ ^ self isMethodObject: aNode messages first receiver ].
	^ false
]

{ #category : #transforming }
GtExtractToWrappedMethodObjectRefactoring >> privateTransform [
	| methodNameBlock |
	methodNameBlock := self options at: #methodName.
	self
		setOption: #methodName
		toUse: [ :methodName :ref | 
			(methodNameBlock cull: methodName cull: ref)
				ifNotNil: [ :result | 
					methodObjectSelector := result selector.
					result ] ].
	super privateTransform.
	self addWrappedCall.
	self removeNewClassAccessors.
	self gtCleanupChanges
]

{ #category : #accessing }
GtExtractToWrappedMethodObjectRefactoring >> removeNewClassAccessors [
	| cls |
	cls := self model classNamed: className.
	cls instanceVariableNames
		do: [ :each | 
			{cls getterMethodFor: each.
				cls setterMethodFor: each}
				do: [ :sel | 
					sel
						ifNotNil: [ | refactoring |
							refactoring := RBInlineAllSendersRefactoring
									model: self model
									sendersOf: sel
									in: cls.
							refactoring setOption: #inlineExpression toUse: [ :ref :str | true ].
							self performCompositeRefactoring: refactoring.
							(cls directlyDefinesMethod: sel) ifTrue: [ cls removeMethod: sel ] ] ] ]
]

{ #category : #testing }
GtExtractToWrappedMethodObjectRefactoring >> shouldEliminateYourselfFromConstructor [
	^ false
]

{ #category : #accessing }
GtExtractToWrappedMethodObjectRefactoring >> transform [
	| methodNameBlock |
	methodNameBlock := self options at: #methodName.
	self
		setOption: #methodName
		toUse: [ :methodName :ref | 
			(methodNameBlock cull: methodName cull: ref)
				ifNotNil: [ :result | 
					methodObjectSelector := result selector.
					result ] ].
	super transform.
	self addWrappedCall.
	self removeNewClassAccessors.
	self gtCleanupChanges
]

{ #category : #accessing }
GtExtractToWrappedMethodObjectRefactoring >> useSetMethod [
	^ useSetMethod ifNil: [ true ]
]

{ #category : #accessing }
GtExtractToWrappedMethodObjectRefactoring >> useSetMethod: aBoolean [
	useSetMethod := aBoolean
]
