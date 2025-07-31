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
				spec repository: 'github://feenkcom/pharo-futures:v0.6.145/src' ].
		spec
			baseline: 'GToolkitExamplesEngine' with: [
				spec repository: 'github://feenkcom/gtoolkit-examples:v0.8.116/src' ].
		spec
			baseline: 'GToolkitCoder' with: [
				spec repository: 'github://feenkcom/gtoolkit-coder:v0.8.2213/src' ].
		spec
			baseline: 'GToolkitCompleter' with: [
				spec repository: 'github://feenkcom/gtoolkit-completer:v0.8.1684/src' ].
		spec
			baseline: 'GToolkit4Magritte' with: [
				spec repository: 'github://feenkcom/gt4magritte:v0.6.1407/src' ].
		spec
			baseline: 'SmaCCRuntime' with: [
				spec repository: 'github://j-brant/SmaCC:v3.0.108' ].

		spec package: 'GToolkit-Pharo-System' with: [
			spec requires: #(#GToolkitExamplesEngine) ].
		spec package: 'GToolkit-Pharo-Parser' with: [
			spec requires: #(#SmaCCRuntime) ].
		spec package: 'GToolkit-Pharo-Index' with: [
			spec requires: #(#GToolkitCompleter) ].
		spec package: 'GToolkit-Pharo-SearchFilters' with: [
			spec requires: #(#Futures #GToolkitCoder #'GToolkit-Pharo-System' #'GToolkit-Pharo-Index') ].
		spec package: 'GToolkit-Pharo-Completer' with: [
			spec requires: #(#SmaCCRuntime #GToolkitCompleter #'GToolkit-Pharo-Index' #'GToolkit-Pharo-Parser' #'GToolkit-Pharo-System') ].
		spec package: 'GToolkit-Pharo-Completer-Examples' with: [
			spec requires: #(#'GToolkit-Pharo-Completer') ].
		spec package: 'GToolkit-Pharo-TestSuite' with: [
			spec requires: #(#Futures #'GToolkit-Pharo-SearchFilters') ].
		spec package: 'GToolkit-Pharo-TestSuite-Remote' with: [
			spec requires: #(#'GToolkit-Pharo-TestSuite') ].
		spec package: 'GToolkit-Pharo-TestSuite-UI' with: [
			spec requires: #(#Futures #GToolkitCoder #'GToolkit-Pharo-TestSuite' #'GToolkit-Pharo-TestSuite-Remote') ].
		spec package: 'GToolkit-Pharo-BaseRefactorings'.
		spec package: 'GToolkit-Pharo-GtRefactorings' with: [
			spec requires: #(#'GToolkit-Pharo-BaseRefactorings') ].
		spec package: 'GToolkit-Pharo-Metamodels' with: [
			spec requires: #(#Futures #'GToolkit-Pharo-GtRefactorings' #'GToolkit-Pharo-Parser' #'GToolkit-Pharo-System') ].
		spec package: 'GToolkit-Pharo-Coder-Method' with: [
			spec requires: #(#GToolkitCoder #GToolkitCompleter #GToolkitExamplesEngine #'GToolkit-Pharo-Completer' #'GToolkit-Pharo-Metamodels' #'GToolkit-Pharo-Parser' #'GToolkit-Pharo-SearchFilters' #'GToolkit-Pharo-System' #'GToolkit-Pharo-TestSuite') ].
		spec package: 'GToolkit-Pharo-Coder' with: [
			spec requires: #(#GToolkitCoder #GToolkit4Magritte #GToolkitCompleter #'GToolkit-Pharo-Coder-Method' #'GToolkit-Pharo-Metamodels' #'GToolkit-Pharo-Parser' #'GToolkit-Pharo-SearchFilters' #'GToolkit-Pharo-System') ].
		spec package: 'GToolkit-Pharo-Extensions' with: [
			spec requires: #(#GToolkitCoder #'GToolkit-Pharo-Coder' #'GToolkit-Pharo-Metamodels' #'GToolkit-Pharo-BaseRefactorings') ].
		spec package: 'GToolkit-Pharo-Coder-Method-UI' with: [
			spec requires: #(#GToolkitCoder #GToolkitCompleter #'GToolkit-Pharo-Coder-Method' #'GToolkit-Pharo-Parser' #'GToolkit-Pharo-SearchFilters') ].
		spec package: 'GToolkit-Pharo-Coder-UI' with: [
			spec requires: #(#GToolkitCoder #GToolkit4Magritte #GToolkitCompleter #'GToolkit-Pharo-GtRefactorings' #'GToolkit-Pharo-Coder' #'GToolkit-Pharo-Coder-Method' #'GToolkit-Pharo-Coder-Method-UI' #'GToolkit-Pharo-Metamodels' #'GToolkit-Pharo-SearchFilters' #'GToolkit-Pharo-System' #'GToolkit-Pharo-TestSuite' #'GToolkit-Pharo-TestSuite-UI') ].
		spec package: 'GToolkit-Pharo-Coder-AddOns' with: [
			spec requires: #(#'GToolkit-Pharo-Coder-UI') ].
		spec package: 'GToolkit-Pharo-Coder-Method-Examples' with: [
			spec requires: #(#'GToolkit-Pharo-Coder-Method' #'GToolkit-Pharo-SearchFilters' #'GToolkit-Pharo-Coder-AddOns') ].
		spec package: 'GToolkit-Pharo-Coder-BigMethods' with: [
			spec requires: #(#GToolkitCoder #'GToolkit-Pharo-Coder-Method' #'GToolkit-Pharo-Coder-Method-UI') ].
		spec package: 'GToolkit-Pharo-StrictSymbolComparison' with: [
			spec requires: #(#'GToolkit-Pharo-Coder-AddOns') ].
		spec package: 'GT-PackageWithSuperclasses'.
		spec package: 'GT-PackageWithSubclasses' with: [
			spec requires: #(#'GT-PackageWithSuperclasses') ].
		spec package: 'GT-PackageWithExtensions' with: [
			spec requires: #(#'GT-PackageWithSuperclasses' #'GT-PackageWithSubclasses') ].
		spec package: 'GToolkit-Pharo-Coder-Examples' with: [
			spec requires: #(#'GToolkit-Pharo-Coder' #'GToolkit-Pharo-Coder-AddOns' #'GToolkit-Pharo-Coder-Method' #'GToolkit-Pharo-Coder-Method-UI' #'GToolkit-Pharo-Coder-UI' #'GToolkit-Pharo-Completer' #'GToolkit-Pharo-Metamodels' #'GToolkit-Pharo-Parser' #'GToolkit-Pharo-SearchFilters' #'GToolkit-Pharo-System' #'GToolkit-Pharo-TestSuite' #'GT-PackageWithSuperclasses' #'GT-PackageWithSubclasses' #'GT-PackageWithExtensions') ].
		spec package: 'GToolkit-Pharo-TestSuite-Examples' with: [
			spec requires: #(#'GToolkit-Pharo-Coder' #'GToolkit-Pharo-Coder-Examples' #'GToolkit-Pharo-Coder-Method' #'GToolkit-Pharo-TestSuite' #'GToolkit-Pharo-TestSuite-UI') ].
	]
]
