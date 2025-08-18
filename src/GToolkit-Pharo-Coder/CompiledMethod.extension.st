Extension { #name : #CompiledMethod }

{ #category : #'*GToolkit-Pharo-Coder' }
CompiledMethod >> gtMethodCoder [
	<gtMethodCoder: 1>
	^GtPharoMethodCoder
]

{ #category : #'*GToolkit-Pharo-Coder' }
CompiledMethod class >> gtMethodCoderPragmas [
	^ Pragma
		allNamed: #gtMethodCoder:
		from: CompiledMethod
		to: CompiledMethod
		sortedByArgument: 1
]

{ #category : #'*GToolkit-Pharo-Coder' }
CompiledMethod >> gtSelectCoderClass [
	| coderPragmas |
	coderPragmas := self class gtMethodCoderPragmas.
	coderPragmas
		reverseDo: [ :each | (each method valueWithReceiver: self arguments: #()) ifNotNil: [ :cls | ^ cls ] ].
	^ self gtMethodCoder
]
