Extension { #name : #RGMethodDefinition }

{ #category : #'*GToolkit-Pharo-Coder-BigMethods' }
RGMethodDefinition >> isBigMethod [
	^ self compiledMethod
		ifNil: [ self sourceCode size > CompiledMethod bigMethodSize ]
		ifNotNil: [ :compiledMethod | compiledMethod isBigMethod ]
]
