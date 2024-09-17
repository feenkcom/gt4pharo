Extension { #name : #Object }

{ #category : #'*GToolkit-Pharo-Index' }
Object >> gtIsBlockClosure [
	^ false
]

{ #category : #'*GToolkit-Pharo-Index' }
Object >> gtIsCompiledCode [
	^ false
]

{ #category : #'*GToolkit-Pharo-Index' }
Object >> gtIsIndexMethod [
	^ self isCompiledMethod
]
