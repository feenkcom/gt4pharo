Extension { #name : #GtSearchFilter }

{ #category : #'*GToolkit-Pharo-Extensions' }
GtSearchFilter >> gtDefaultInspectorTool [
	^ GtPhlowCompositeTool new
		addTool: (GtPhlowSearchFilterTool forSearchFilter: self);
		addTool: (super gtDefaultInspectorTool)
]
