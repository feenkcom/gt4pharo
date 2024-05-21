Extension { #name : #TaEmptyComposition }

{ #category : #'*GToolkit-Pharo-System' }
TaEmptyComposition >> asRingMinimalDefinitionIn: anRGEnvironment [
	<gtPharoPatch: #Pharo>
	
	^ anRGEnvironment backend
		definitionFor: self
		ifAbsentRegister: [
			| def |
			def := RGTraitComposition named: '{}'.

			def propertyNamed: #realObject put: self.

			"we need to set real object because we cannot simply identify the real object from the model data"
			def ]
]
