Extension { #name : #RGReadOnlyImageBackend }

{ #category : #'*GToolkit-Pharo-System' }
RGReadOnlyImageBackend >> subclassesFor: anRGBehavior [
	^ (self realBehaviorFor: anRGBehavior) subclasses collect: [ :eachClass |
		eachClass asRingMinimalDefinitionIn: self environment ]
]
