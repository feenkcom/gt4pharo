Extension { #name : 'GtMetaclassDefinition' }

{ #category : '*GToolkit-Pharo-Coder-UI' }
GtMetaclassDefinition >> editors [
	<return: #Collection of: #GtCodeDefinitionViewer>
	
	^ { 
		self category categoryEditor.
		self slots slotsEditor.
	}
]

{ #category : '*GToolkit-Pharo-Coder-UI' }
GtMetaclassDefinition >> readers [
	<return: #Collection of: #GtCodeDefinitionViewer>
	
	^ { 
		self category categoryReader.
	}
]
