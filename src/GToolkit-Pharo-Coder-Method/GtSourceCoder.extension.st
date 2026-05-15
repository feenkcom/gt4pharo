Extension { #name : #GtSourceCoder }

{ #category : #'*GToolkit-Pharo-Coder-Method' }
GtSourceCoder class >> forPharoMethod: aMethod [
	"I am used to not depend on gt4pharo packages in gtoolkit-coder packages"

	^ GtPharoMethodCoder forMethod: aMethod
]

{ #category : #'*GToolkit-Pharo-Coder-Method' }
GtSourceCoder class >> forPharoMethod: aMethod in: aBehavior [
	"I am used to not depend on gt4pharo packages in gtoolkit-coder packages"

	^ GtPharoMethodCoder forMethod: aMethod in: aBehavior
]
