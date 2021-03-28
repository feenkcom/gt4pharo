Class {
	#name : #BaselineOfGToolkit4Pharo,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkit4Pharo
}

{ #category : #baseline }
BaselineOfGToolkit4Pharo >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [
			spec 
				baseline: 'GToolkitRefactoringsUtility' with: [
					spec repository: 'github://feenkcom/gtoolkit-utility/src' ];
				baseline: 'GToolkitCoder' with: [
					spec repository: 'github://feenkcom/gtoolkit-coder/src' ];
				baseline: 'GToolkitCompleter' with: [
					spec repository: 'github://feenkcom/gtoolkit-completer/src' ];
				baseline: 'SmaCC' with: [
					spec repository: 'github://j-brant/SmaCC/src' ];
				
				"contains classes responsible for interaction with pharo system"
				package: 'GToolkit-Pharo-System';
		
				package: 'GToolkit-Pharo-Metamodels' with: [ spec requires: #(GToolkitRefactoringsUtility) ];
				package: 'GToolkit-Pharo-Parser' with: [ spec requires: #(SmaCC) ];
				package: 'GToolkit-Pharo-Completer' with: [ spec requires: #(GToolkitCompleter) ];
				package: 'GToolkit-Pharo-Coder' with: [ spec requires: #(GToolkitCoder 'GToolkit-Pharo-System') ];
				package: 'GToolkit-Pharo-Coder-UI' with: [ spec requires: #('GToolkit-Pharo-Coder') ];
				package: 'GToolkit-Pharo-Coder-AddOns' with: [ spec requires: #('GToolkit-Pharo-Coder-UI') ];
				package: 'GToolkit-Pharo-Coder-Examples' with: [ spec requires: #('GToolkit-Pharo-Coder' 'GToolkit-Pharo-Coder-UI' 'GToolkit-Pharo-Coder-AddOns') ];
				
				"inspector extensions"
				package: 'GToolkit-Pharo-Extensions' with: [ spec requires: #('GToolkit-Pharo-Metamodels') ] ]
]
