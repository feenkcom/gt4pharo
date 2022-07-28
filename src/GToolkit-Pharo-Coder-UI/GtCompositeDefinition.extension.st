Extension { #name : #GtCompositeDefinition }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtCompositeDefinition >> createRefactoringModel [
	^ RBClassModelFactory rbNamespace onEnvironment: RBBrowserEnvironment new
]
