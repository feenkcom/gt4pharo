Class {
	#name : #GtPharoMethodCoderMenu,
	#superclass : #GtTextualCoderMenu,
	#category : #'GToolkit-Pharo-Coder-Method-UI-Menu'
}

{ #category : #'api - initialization' }
GtPharoMethodCoderMenu >> forMethod: aCompiledMethod [
	self coder: (GtPharoMethodCoder forMethod: aCompiledMethod)
]

{ #category : #views }
GtPharoMethodCoderMenu >> gtLiveFor: aView [
	<gtView>
	^ aView explicit
		title: 'Live';
		stencil: [ self asElement ]
]
