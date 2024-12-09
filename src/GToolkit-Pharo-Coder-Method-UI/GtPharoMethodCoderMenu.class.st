Class {
	#name : #GtPharoMethodCoderMenu,
	#superclass : #GtTextualCoderMenu,
	#category : #'GToolkit-Pharo-Coder-Method-UI-Menu'
}

{ #category : #'api - initialization' }
GtPharoMethodCoderMenu >> forMethod: aCompiledMethod [
	self coder: (GtPharoMethodCoder forMethod: aCompiledMethod)
]
