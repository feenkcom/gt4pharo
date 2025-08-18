Extension { #name : #CompiledMethod }

{ #category : #'*GToolkit-Pharo-Coder-BigMethods' }
CompiledMethod >> gtBigMethodCoder [
	<gtMethodCoder: 5>
	^ self isBigMethod ifTrue: [ GtPharoBigMethodCoder ] ifFalse: [ nil ]
]

{ #category : #'*GToolkit-Pharo-Coder-BigMethods' }
CompiledMethod >> isBigMethod [
	^ self isSourceSearchable not or: [ self sourceCode size > 10000 ]
]
