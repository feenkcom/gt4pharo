Extension { #name : #Behavior }

{ #category : #'*GToolkit-Pharo-Index' }
Behavior >> compileAllAnnouncing [
	^ self compileAllAnnouncing: true
]

{ #category : #'*GToolkit-Pharo-Index' }
Behavior >> compileAllAnnouncing: announcing [
	^ self compileAllFrom: self announcing: announcing
]

{ #category : #'*GToolkit-Pharo-Index' }
Behavior >> compileAllFrom: oldClass announcing: announcing [
	"Compile all the methods in the receiver's method dictionary.
	This validates sourceCode and variable references and forces
	all methods to use the current bytecode set"
	oldClass localSelectors do: [:sel | self recompile: sel from: oldClass announcing: announcing ]
]

{ #category : #'*GToolkit-Pharo-Index' }
Behavior >> recompile: selector from: oldClass announcing: announcing [
	<gtPharoPatch: #Pharo12>
	"Compile the method associated with selector in the receiver's method dictionary."
	| compileBlock method newMethod |

	compileBlock := [
		method := oldClass compiledMethodAt: selector.
		newMethod := oldClass compiler
			             source: (oldClass sourceCodeAt: selector);
			             priorMethod: method;
			             class: self;
			             permitFaulty: true;
			             "No need to log recompilation in the sources,
						 	 We are going to reuse the original source pointer."
			             logged: false;
			             install ].

	announcing
		ifTrue: [ compileBlock value ]
		ifFalse: [ self codeChangeAnnouncer localSuspendWhile: compileBlock ].

	newMethod sourcePointer: method sourcePointer.
	selector == newMethod selector ifFalse: [
		self error: 'selector changed!' ]
]
