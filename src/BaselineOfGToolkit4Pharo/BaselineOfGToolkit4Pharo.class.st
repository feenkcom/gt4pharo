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
				spec repository: 'github://feenkcom/gtoolkit-utility:main/src' ];
			baseline: 'GToolkitCoder' with: [
				spec repository: 'github://feenkcom/gtoolkit-coder:main/src' ];
			baseline: 'GToolkitCompleter' with: [
				spec repository: 'github://feenkcom/gtoolkit-completer:main/src' ];
			baseline: 'SmaCC' with: [
				spec repository: 'github://j-brant/SmaCC/src' ].
		spec 
			package: 'GToolkit-Pharo-System';
			package: 'GToolkit-Pharo-Metamodels' with: [
				spec requires: #('GToolkitRefactoringsUtility' ). ];
			package: 'GToolkit-Pharo-Parser' with: [
				spec requires: #('SmaCC' ). ];
			package: 'GToolkit-Pharo-Completer' with: [
				spec requires: #('GToolkitCompleter' 'GToolkit-Pharo-Parser' ). ];
			package: 'GToolkit-Pharo-Coder' with: [
				spec requires: #('GToolkitCoder' 'GToolkit-Pharo-Parser' 'GToolkit-Pharo-System' 'GToolkit-Pharo-Metamodels' 'GToolkit-Pharo-Completer' ). ];
			package: 'GToolkit-Pharo-Coder-UI' with: [
				spec requires: #('GToolkit-Pharo-Coder' 'GToolkit-Pharo-Metamodels' ). ];
			package: 'GToolkit-Pharo-Coder-Bubbles' with: [
				spec requires: #('GToolkit-Pharo-Coder' 'GToolkit-Pharo-Coder-UI' ). ];
			package: 'GToolkit-Pharo-Coder-AddOns' with: [
				spec requires: #('GToolkit-Pharo-Coder-UI' ). ];
			package: 'GToolkit-Pharo-Coder-Examples' with: [
				spec requires: #('GToolkit-Pharo-Coder' 'GToolkit-Pharo-Coder-UI' 'GToolkit-Pharo-Coder-AddOns' ). ];
			package: 'GToolkit-Pharo-Extensions' with: [
				spec requires: #('GToolkit-Pharo-Metamodels' ). ]. ].

]
