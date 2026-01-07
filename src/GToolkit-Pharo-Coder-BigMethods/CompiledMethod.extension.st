Extension { #name : #CompiledMethod }

{ #category : #'*GToolkit-Pharo-Coder-BigMethods' }
CompiledMethod class >> bigMethodSize [
	"Answer the size in characters of methods that are considered big"
	
	^ 10000
]

{ #category : #'*GToolkit-Pharo-Coder-BigMethods' }
CompiledMethod >> gtBigMethodCoder [
	<gtMethodCoder: 5>
	^ self isBigMethod ifTrue: [ GtPharoBigMethodCoder ] ifFalse: [ nil ]
]

{ #category : #'*GToolkit-Pharo-Coder-BigMethods' }
CompiledMethod >> isBigMethod [
	^ self isSourceSearchable not or: [ self sourceCode size > self class bigMethodSize ]
]
