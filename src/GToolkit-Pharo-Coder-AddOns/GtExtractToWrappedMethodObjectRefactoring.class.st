Class {
	#name : #GtExtractToWrappedMethodObjectRefactoring,
	#superclass : #GtExtractMethodObjectRefactoring,
	#instVars : [
		'methodObjectSelector'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring'
}

{ #category : #accessing }
GtExtractToWrappedMethodObjectRefactoring >> addWrappedCall [
	| ast |
	ast := class parseTreeFor: selector.
	ast
		nodesDo: [ :each | 
			(each isMessage
				and: [ each selector = methodObjectSelector
						and: [ self isMethodObject: each receiver ] ])
				ifTrue: [ self insertWrappedSendOn: each ] ].
	class compileTree: ast
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
	self gtCleanupChanges
]
