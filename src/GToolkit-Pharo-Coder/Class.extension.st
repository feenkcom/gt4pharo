Extension { #name : #Class }

{ #category : #'*GToolkit-Pharo-Coder' }
Class >> gtMethods [
	^ GtSearchMethodsInClassFilter forClass: self
]

{ #category : #'*GToolkit-Pharo-Coder' }
Class >> gtReferences [
	^ GtSearchReferencesFilter literal: self binding
]

{ #category : #'*GToolkit-Pharo-Coder' }
Class >> gtReferencesAndComments [
	^ self gtReferences & (GtSearchCommentsFilter new text: self name)
]
