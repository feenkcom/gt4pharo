Class {
	#name : #BaselineOfGToolkit4Pharo,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkit4Pharo
}

{ #category : #baseline }
BaselineOfGToolkit4Pharo >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec
			baseline: 'Futures' with: [
				spec repository: 'github://feenkcom/pharo-futures:v0.6.41/src' ].
		spec
			baseline: 'GToolkitExamplesEngine' with: [
				spec repository: 'github://feenkcom/gtoolkit-examples:v0.8.46/src' ].
		spec
			baseline: 'GToolkitRefactoringsUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:v0.8.108/src' ].
		spec
			baseline: 'GToolkitCoder' with: [
				spec repository: 'github://feenkcom/gtoolkit-coder:v0.8.742/src' ].
		spec
			baseline: 'GToolkitCompleter' with: [
				spec repository: 'github://feenkcom/gtoolkit-completer:v0.8.612/src' ].
		spec
			baseline: 'SmaCC' with: [
				spec repository: 'github://j-brant/SmaCC:217d2090086a8fb14ee0f65cbbede7c13505e88f/src' ].

		spec package: 'GToolkit-Pharo-System' with: [
			spec requires: #('GToolkitExamplesEngine') ].
		spec package: 'GToolkit-Pharo-Parser' with: [
			spec requires: #('SmaCC') ].
		spec package: 'GToolkit-Pharo-Metamodels' with: [
			spec requires: #('GToolkitRefactoringsUtility' 'GToolkit-Pharo-Parser' 'GToolkit-Pharo-System') ].
		spec package: 'GToolkit-Pharo-SearchFilters' with: [
			spec requires: #('GToolkitCoder' 'GToolkit-Pharo-System') ].
		spec package: 'GToolkit-Pharo-Completer' with: [
			spec requires: #('SmaCC' 'GToolkitCompleter' 'GToolkit-Pharo-Parser' 'GToolkit-Pharo-System') ].
		spec package: 'GToolkit-Pharo-TestSuite' with: [
			spec requires: #('Futures' 'GToolkit-Pharo-SearchFilters') ].
		spec package: 'GToolkit-Pharo-TestSuite-Remote' with: [
			spec requires: #('GToolkit-Pharo-TestSuite') ].
		spec package: 'GToolkit-Pharo-TestSuite-UI' with: [
			spec requires: #('Futures' 'GToolkitCoder' 'GToolkit-Pharo-TestSuite' 'GToolkit-Pharo-TestSuite-Remote') ].
		spec package: 'GToolkit-Pharo-Coder-Method' with: [
			spec requires: #('GToolkitCoder' 'GToolkitCompleter' 'GToolkitExamplesEngine' 'GToolkit-Pharo-Completer' 'GToolkit-Pharo-Metamodels' 'GToolkit-Pharo-Parser' 'GToolkit-Pharo-SearchFilters' 'GToolkit-Pharo-System') ].
		spec package: 'GToolkit-Pharo-Coder-Method-UI' with: [
			spec requires: #('GToolkitCoder' 'GToolkitCompleter' 'GToolkit-Pharo-Coder-Method' 'GToolkit-Pharo-Parser' 'GToolkit-Pharo-SearchFilters') ].
		spec package: 'GToolkit-Pharo-Coder-Method-Examples' with: [
			spec requires: #('GToolkit-Pharo-Coder-Method' 'GToolkit-Pharo-SearchFilters') ].
		spec package: 'GToolkit-Pharo-Coder' with: [
			spec requires: #('GToolkitCoder' 'GToolkitCompleter' 'GToolkit-Pharo-Coder-Method' 'GToolkit-Pharo-Metamodels' 'GToolkit-Pharo-Parser' 'GToolkit-Pharo-SearchFilters' 'GToolkit-Pharo-System') ].
		spec package: 'GToolkit-Pharo-Coder-UI' with: [
			spec requires: #('GToolkitCoder' 'GToolkitCompleter' 'GToolkitRefactoringsUtility' 'GToolkit-Pharo-Coder' 'GToolkit-Pharo-Coder-Method' 'GToolkit-Pharo-Coder-Method-UI' 'GToolkit-Pharo-Metamodels' 'GToolkit-Pharo-SearchFilters' 'GToolkit-Pharo-System' 'GToolkit-Pharo-TestSuite' 'GToolkit-Pharo-TestSuite-UI') ].
		spec package: 'GToolkit-Pharo-Coder-AddOns' with: [
			spec requires: #('GToolkit-Pharo-Coder-UI') ].
		spec package: 'GToolkit-Pharo-Coder-Examples' with: [
			spec requires: #('GToolkit-Pharo-Coder' 'GToolkit-Pharo-Coder-AddOns' 'GToolkit-Pharo-Coder-Method' 'GToolkit-Pharo-Coder-Method-UI' 'GToolkit-Pharo-Coder-UI' 'GToolkit-Pharo-Completer' 'GToolkit-Pharo-Metamodels' 'GToolkit-Pharo-Parser' 'GToolkit-Pharo-SearchFilters' 'GToolkit-Pharo-System' 'GToolkit-Pharo-TestSuite') ].
		spec package: 'GToolkit-Pharo-TestSuite-Examples' with: [
			spec requires: #('GToolkit-Pharo-Coder' 'GToolkit-Pharo-Coder-Examples' 'GToolkit-Pharo-Coder-Method' 'GToolkit-Pharo-TestSuite' 'GToolkit-Pharo-TestSuite-UI') ].
		spec package: 'GToolkit-Pharo-Extensions' with: [
			spec requires: #('GToolkitCoder' 'GToolkit-Pharo-Coder' 'GToolkit-Pharo-Metamodels') ].
	]
]
