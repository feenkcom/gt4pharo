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
			baseline: 'GToolkitRefactoringsUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:v0.8.57/src' ];
			baseline: 'GToolkitCoder' with: [
				spec repository: 'github://feenkcom/gtoolkit-coder:v0.8.444/src' ];
			baseline: 'GToolkitCompleter' with: [
				spec repository: 'github://feenkcom/gtoolkit-completer:v0.8.361/src' ];
			baseline: 'SmaCC' with: [
				spec repository: 'github://j-brant/SmaCC:0418de0ca444076b50495025bfd9a8e113d5493e/src' ].
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
			package: 'GToolkit-Pharo-Coder-AddOns' with: [
				spec requires: #('GToolkit-Pharo-Coder-UI' ). ];
			package: 'GToolkit-Pharo-Coder-Examples' with: [
				spec requires: #('GToolkit-Pharo-Coder' 'GToolkit-Pharo-Coder-UI' 'GToolkit-Pharo-Coder-AddOns' ). ];
			package: 'GToolkit-Pharo-Extensions' with: [
				spec requires: #('GToolkit-Pharo-Metamodels' ). ]. ].

]
