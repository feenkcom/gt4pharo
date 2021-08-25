Extension { #name : 'GtFullClassDefinition' }

{ #category : '*GToolkit-Pharo-Coder-UI' }
GtFullClassDefinition >> editors [
	<return: #Collection of: #GtCodeDefinitionViewer>
	^ instanceSideDefinition editors , { classSideDefinition slots slotsEditor }
]

{ #category : '*GToolkit-Pharo-Coder-UI' }
GtFullClassDefinition >> readers [
	^ instanceSideDefinition readers
]
