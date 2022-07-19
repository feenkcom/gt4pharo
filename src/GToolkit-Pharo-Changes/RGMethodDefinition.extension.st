Extension { #name : #RGMethodDefinition }

{ #category : #'*GToolkit-Pharo-Changes' }
RGMethodDefinition >> displayForTree [
	^ self selector asString
]

{ #category : #'*GToolkit-Pharo-Changes' }
RGMethodDefinition >> gtChildren [
	^ {}
]

{ #category : #'*GToolkit-Pharo-Changes' }
RGMethodDefinition >> navigateToUsingModel: aNavigationModel [
	aNavigationModel selectMethod: self
]
