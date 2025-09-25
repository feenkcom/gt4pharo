Extension { #name : #Behavior }

{ #category : #'*GToolkit-Pharo-Index' }
Behavior >> recompile: selector from: oldClass [
	<gtPharoPatch: #Pharo12>
	"Compile the method associated with selector in the receiver's method dictionary.
	Pharo 11 behaviour is unchanged.  Pharo 12 behaviour is currently also unchanged, under investigation."
	| method currentSource newSource recompileBlock newMethod |

	self forPharo12AndNewer:
		[ method := oldClass compiledMethodAt: selector.
		currentSource := self sourceCodeAt: selector ifAbsent: [ nil ].
		newSource := oldClass sourceCodeAt: selector ifAbsent: [ nil ].
		recompileBlock := 
			[ newMethod := oldClass compiler
				source: newSource;
				priorMethod: method;
				class: self;
				permitFaulty: true;
				"No need to log recompilation in the sources,
				We are going to reuse the original source pointer."
				logged: false;
				install.
			newMethod sourcePointer: method sourcePointer. ].
		"newSource = currentSource" true ifTrue:
			"Compile without announcing"
			[ self codeChangeAnnouncer suspendAllWhile: recompileBlock ]
		ifFalse:
			[ recompileBlock value ].
	
		selector == newMethod selector ifFalse: [
			self error: 'selector changed!' ] ]
	forPharo11:
		[ method := oldClass compiledMethodAt: selector.
		newMethod := oldClass compiler
					source: (oldClass sourceCodeAt: selector);
					class: self;
					failBlock: [^ self];
					compiledMethodTrailer: method trailer;
					compile.   "Assume OK after proceed from SyntaxError"
		selector == newMethod selector ifFalse: [self error: 'selector changed!'].
		self addSelector: selector withRecompiledMethod: newMethod ]
]
