Extension { #name : #RGMethodDefinition }

{ #category : #'*GToolkit-Pharo-Coder-BigMethods' }
RGMethodDefinition >> isBigMethod [
	^ self compiledMethod
		ifNil: [ self sourceCode
				ifNotNil: [ :aSource | aSource size > CompiledMethod bigMethodSize ]
				ifNil: [ false ] ]
		ifNotNil: [ :compiledMethod | compiledMethod isBigMethod ]
]
