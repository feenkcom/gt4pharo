Extension { #name : #GtPharoMethodCoder }

{ #category : #'*GToolkit-Pharo-Coder-BigMethods' }
GtPharoMethodCoder class >> forBigMethod: aCompiledMethod [
	^ GtPharoBigMethodCoder forMethod: aCompiledMethod
]
