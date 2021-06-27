Extension { #name : #GtSlotDefinition }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSlotDefinition >> browseFrom: anEvent [
	anEvent currentTarget phlow spawnObject: self
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSlotDefinition >> browseReferencesFrom: anEvent [
	parent classOrMetaClass
		ifNotNil: [ :class | 
			anEvent currentTarget phlow
				spawnObject:
					(GtSearchInstanceSlotReferenceFilter
						forClassAndSubclasses: class
						andVariable: self name) ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSlotDefinition >> inspectFrom: anEvent [
	parent isForMetaclass
		ifFalse: [ ^ self ].
	anEvent currentTarget phlow spawnObject: self value
]
