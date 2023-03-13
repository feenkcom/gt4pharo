Extension { #name : #GtClassDefinition }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtClassDefinition >> readers [
	<return: #Collection of: #GtCodeDefinitionViewer>
	
	^ { 
		self superclass superclassReader.
		self category categoryReader.
	}
]
