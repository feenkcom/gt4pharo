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
