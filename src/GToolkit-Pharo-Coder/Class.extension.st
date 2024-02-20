Extension { #name : #Class }

{ #category : #'*GToolkit-Pharo-Coder' }
Class >> gtIsOrInheritsFrom [
	^ GtSearchMethodsInClassFilter new
		forClass: self;
		includeSubclasses: true
]

{ #category : #'*GToolkit-Pharo-Coder' }
Class >> gtReferences [
	^ (GtSearchReferencesFilter literal: self binding) 
]

{ #category : #'*GToolkit-Pharo-Coder' }
Class >> gtReferencesAndComments [
	^ self gtReferences & (GtSearchCommentsFilter new text: self name)
]

{ #category : #'*GToolkit-Pharo-Coder' }
Class >> gtReferencesWithSubclasses [
	^ self allSubclasses
		inject: self gtReferences
		into: [ :aFilter :aClass | aFilter | aClass gtReferences ]
]

{ #category : #'*GToolkit-Pharo-Coder' }
Class >> gtReferencesWithSuperclasses [
	^ self allSuperclasses
		inject: self gtReferences
		into: [ :aFilter :aClass | aFilter | aClass gtReferences ]
]
