Extension { #name : #GtMetaclassDefinition }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtMetaclassDefinition >> readers [
	<return: #Collection of: #GtCodeDefinitionViewer>
	
	^ { 
		self category categoryReader.
	}
]
