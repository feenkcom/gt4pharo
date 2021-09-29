Class {
	#name : 'BaselineOfGToolkit4Pharo',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfGToolkit4Pharo'
}

{ #category : 'baseline' }
BaselineOfGToolkit4Pharo >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec
			baseline: 'GToolkitRefactoringsUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:v0.8.71/src' ].
		spec
			baseline: 'GToolkitCoder' with: [
				spec repository: 'github://feenkcom/gtoolkit-coder:v0.8.502/src' ].
		spec
			baseline: 'GToolkitCompleter' with: [
				spec repository: 'github://feenkcom/gtoolkit-completer:v0.8.409/src' ].
		spec
			baseline: 'SmaCC' with: [
				spec repository: 'github://j-brant/SmaCC:d45ba3e1d5fb414c17323ab1d66efc09048c07ed/src' ].

		spec package: 'GToolkit-Pharo-System'.
		spec package: 'GToolkit-Pharo-Metamodels' with: [
			spec requires: #('GToolkitRefactoringsUtility') ].
		spec package: 'GToolkit-Pharo-Parser' with: [
			spec requires: #('SmaCC') ].
		spec package: 'GToolkit-Pharo-Completer' with: [
			spec requires: #('GToolkitCompleter' 'GToolkit-Pharo-Parser') ].
		spec package: 'GToolkit-Pharo-Coder' with: [
			spec requires: #('GToolkitCoder' 'GToolkit-Pharo-Parser' 'GToolkit-Pharo-System' 'GToolkit-Pharo-Metamodels' 'GToolkit-Pharo-Completer') ].
		spec package: 'GToolkit-Pharo-Coder-UI' with: [
			spec requires: #('GToolkit-Pharo-Coder' 'GToolkit-Pharo-Metamodels') ].
		spec package: 'GToolkit-Pharo-Coder-AddOns' with: [
			spec requires: #('GToolkit-Pharo-Coder-UI') ].
		spec package: 'GToolkit-Pharo-Coder-Examples' with: [
			spec requires: #('GToolkit-Pharo-Coder' 'GToolkit-Pharo-Coder-UI' 'GToolkit-Pharo-Coder-AddOns') ].
		spec package: 'GToolkit-Pharo-Extensions' with: [
			spec requires: #('GToolkit-Pharo-Metamodels') ].
	]
]
