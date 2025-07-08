Extension { #name : #CompiledMethod }

{ #category : #'*GToolkit-Pharo-Index' }
CompiledMethod >> gtIndexMethod [
	^ self gtOriginalMethod
]

{ #category : #'*GToolkit-Pharo-Index' }
CompiledMethod >> gtIsActive [
	^ self isInstalled
		or: [ self isFFIMethod
				and: [ | installedMethod |
					installedMethod := self methodClass
							ifNotNil: [ :class | 
								self selector
									ifNotNil: [ :selector | class compiledMethodAt: selector ifAbsent: nil ] ].
					self == (installedMethod ifNotNil: [ installedMethod gtOriginalMethod ]) ] ]
]

{ #category : #'*GToolkit-Pharo-Index' }
CompiledMethod >> gtOriginalMethod [
	| other |
	self isFFIMethod ifFalse: [ ^ self ].
	other := self propertyAt: #ffiNonCompiledMethod.
	(other isNil or: [ self == other ]) ifTrue: [ ^ self ].
	^ other gtOriginalMethod
]

{ #category : #'*GToolkit-Pharo-Index' }
CompiledMethod >> recompile [
	<gtPharoPatch: #Pharo>
	| result |
	result := self methodClass recompile: self selector.
	SystemAnnouncer uniqueInstance
		announce: (GtMethodRecompiled
				methodChangedFrom: self
				to: (self methodClass compiledMethodAt: self selector)).
	^ result
]
