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
	| result oldMethod newMethod origin |
	origin := self origin.
	self isFromTrait
		ifTrue: [ oldMethod := origin compiledMethodAt: self selector ifAbsent: [ self ] ]
		ifFalse: [ oldMethod := self ].
	result := origin recompile: self selector.
	newMethod := origin
			compiledMethodAt: self selector
			ifAbsent: [ self methodClass compiledMethodAt: self selector ].
	SystemAnnouncer uniqueInstance
		announce: (GtMethodRecompiled methodChangedFrom: oldMethod to: newMethod).
	^ result
]
