Extension { #name : #GtCategoryDefinition }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtCategoryDefinition >> categoryReader [
	<return: #GtCodeDefinitionViewer>
	
	^ GtCodeDefinitionCompositeEntityViewer withAll: {
		self package packageReader.
		self tag tagReader }
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtCategoryDefinition >> readers [
	^ { self categoryReader }
]
