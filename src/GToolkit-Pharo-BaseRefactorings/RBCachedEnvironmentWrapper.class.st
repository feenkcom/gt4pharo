Class {
	#name : #RBCachedEnvironmentWrapper,
	#superclass : #RBBrowserEnvironmentWrapper,
	#instVars : [
		'packages'
	],
	#category : #'GToolkit-Pharo-BaseRefactorings-Environment'
}

{ #category : #accessing }
RBCachedEnvironmentWrapper >> packages [
	^ packages ifNil: [ packages := environment packages ]
]
