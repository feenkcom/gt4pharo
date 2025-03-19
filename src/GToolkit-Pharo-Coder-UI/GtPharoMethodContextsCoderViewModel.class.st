Class {
	#name : #GtPharoMethodContextsCoderViewModel,
	#superclass : #GtPharoMethodsCoderViewModel,
	#category : #'GToolkit-Pharo-Coder-UI-! View Models'
}

{ #category : #updating }
GtPharoMethodContextsCoderViewModel >> coderUIModelFor: aCoder [
	"We do not bind the self object as each individual context coder has its own"
	^ aCoder asCoderViewModel
		expanded: false
]
