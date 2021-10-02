Class {
	#name : #BaselineOfGToolkitCoderRemotePharoEnvironment,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitCoderRemotePharoEnvironment
}

{ #category : #baselines }
BaselineOfGToolkitCoderRemotePharoEnvironment >> baseline: spec [
	<baseline>

	spec for: #common do: [ 
		spec package: 'GToolkit-Coder-Environment-Smalltalk-Core'.
		spec
			package: 'GToolkit-Coder-Environment-Pharo-Driver'
			with: [ spec requires: #( 'GToolkit-Coder-Environment-Smalltalk-Core' ) ] ]
]
