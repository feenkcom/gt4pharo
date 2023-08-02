Extension { #name : #Class }

{ #category : #'*GToolkit-Pharo-Coder' }
Class >> gtIsOrInheritsFrom [
	^ GtSearchMethodsInClassFilter new
		forClass: self;
		includeSubclasses: true
]

{ #category : #'*GToolkit-Pharo-Coder' }
Class >> gtReferences [
	^ (GtSearchReferencesFilter literal: self binding) | (GtSearchSubclassesFilter forClass: self)
]

{ #category : #'*GToolkit-Pharo-Coder' }
Class >> gtReferencesAndComments [
	^ self gtReferences & (GtSearchCommentsFilter new text: self name)
]
