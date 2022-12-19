"
nil
"
Class {
	#name : #GtPackageAndTagDescription,
	#superclass : #MAElementDescription,
	#category : #'GToolkit-Pharo-Coder-Models'
}

{ #category : #accessing }
GtPackageAndTagDescription >> acceptMagritte: aVisitor [
	aVisitor visitGtPackageAndTagDescription: self
]

{ #category : #'validation-private' }
GtPackageAndTagDescription >> validateRequired: anObject [
	"Validate ==anObject== not to be ==empty== if it is required."

	(self isRequired and: [ anObject isEmpty ])
		ifTrue: [ MARequiredError description: self signal: self requiredErrorMessage ]
]
