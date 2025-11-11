Extension { #name : #GtPhlowButtonAction }

{ #category : #'*GToolkit-Pharo-Coder-Method-UI' }
GtPhlowButtonAction >> debugBlock: aBlockClosure [
	"Takes as a parameter a block cloure that should only reference `self` or attributes of the receiver class"
	
	self 
		debugSource: aBlockClosure 
		receiver: aBlockClosure receiver
]

{ #category : #'*GToolkit-Pharo-Coder-Method-UI' }
GtPhlowButtonAction >> debugSource: aBlockClosureOrString receiver: anObject [
	"Takes as a parameter a block cloure or a string with the code to debug.
	The code should only reference `self` or attributes of the receiver class"
	
	self action: 
			[| compiledMethodToDebug targetSourceCode |
			targetSourceCode := aBlockClosureOrString isClosure
						ifTrue: [aBlockClosureOrString compiledBlock ast body formattedCode]
						ifFalse: [aBlockClosureOrString asString].
			compiledMethodToDebug := GtPharoCodeModifier current critical: 
							[(anObject class compiler)
								source: targetSourceCode;
								class: anObject class;
								context: nil;
								requestor: nil;
								isScripting: true;
								failBlock: nil;
								compile ].
			GtPharoSourceCoder
				debug: compiledMethodToDebug
				receiver: anObject
				in: nil
				coderEvaluationContext: nil]
]
