Class {
	#name : #GtPharoPackagesCoder,
	#superclass : #GtPackagesCoder,
	#category : #'GToolkit-Pharo-Coder-Coders'
}

{ #category : #converting }
GtPharoPackagesCoder >> asCoderUIModel [
	^ GtPackagesCoderUIModel new coder: self
]

{ #category : #private }
GtPharoPackagesCoder >> newCoderFor: aPackage [
	^ GtPharoPackageCoder forPackage: aPackage
]
