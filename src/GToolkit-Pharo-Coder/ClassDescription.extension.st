Extension { #name : #ClassDescription }

{ #category : #'*GToolkit-Pharo-Coder' }
ClassDescription >> gtMethodsInClass [
	"Sample usage:
		GtLiveShow gtMethodsInClass & #priority gtSenders
	"
	^ GtSearchMethodsInClassFilter new forClass: self
]
