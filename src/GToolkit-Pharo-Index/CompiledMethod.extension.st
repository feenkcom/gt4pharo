Extension { #name : #CompiledMethod }

{ #category : #'*GToolkit-Pharo-Index' }
CompiledMethod >> gtIsActive [
	^ self isInstalled
		or: [ self isFFIMethod
				and: [ | installedMethod |
					installedMethod := self methodClass
							ifNotNil: [ :class | 
								self selector
									ifNotNil: [ :selector | class compiledMethodAt: selector ifAbsent: nil ] ].
					self == (installedMethod ifNotNil: [ installedMethod gtOriginalFFIMethod ]) ] ]
]

{ #category : #'*GToolkit-Pharo-Index' }
CompiledMethod >> gtOriginalFFIMethod [
	| other |
	self isFFIMethod ifFalse: [ ^ self ].
	other := self propertyAt: #ffiNonCompiledMethod.
	(other isNil or: [ self == other ]) ifTrue: [ ^ self ].
	^ other gtOriginalFFIMethod
]
