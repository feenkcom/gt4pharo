Extension { #name : #ReflectiveMethod }

{ #category : #'*GToolkit-Pharo-Index' }
ReflectiveMethod >> gtIndexMethod [
	^ self
]

{ #category : #'*GToolkit-Pharo-Index' }
ReflectiveMethod >> gtIsActive [
	compiledMethod methodClass
		ifNotNil: [ :class | 
			self selector
				ifNotNil: [ :selector | ^ self == (class compiledMethodAt: selector ifAbsent: nil) ] ].
	^ false
]

{ #category : #'*GToolkit-Pharo-Index' }
ReflectiveMethod >> gtIsIndexMethod [
	^ true
]

{ #category : #'*GToolkit-Pharo-Index' }
ReflectiveMethod >> gtOriginalMethod [
	^ compiledMethod gtOriginalMethod
]
