"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestGToolkitPharoCoderMethodUI,
	#superclass : #PackageManifest,
	#category : #'GToolkit-Pharo-Coder-Method-UI-Manifest'
}

{ #category : #accessing }
ManifestGToolkitPharoCoderMethodUI class >> mustNotDependOn [
	^ { 
		'GToolkit-Coder-AddOns'.
		'GToolkit-Pharo-Coder-UI'
	}
]

{ #category : #accessing }
ManifestGToolkitPharoCoderMethodUI class >> mustOnlyDependOn [
		^ {
		'Beacon-ExtraSignals'.
		'Bloc'.
		'Bloc-Layout'.
		'Bloc-Text'.
		'Bloc-Text-Elements'.
		'Brick'.
		'Brick-Core'.
		'Brick-Editor'.
		'Brick-Glamorous'.
		'Collections-Sequenceable'.
		'Collections-Unordered'.
		'Colors'.
		'Futures'.
		'GToolkit-Clipboard'.
		'GToolkit-Coder'.
		'GToolkit-Coder-StreamingCoders'.
		'GToolkit-Coder-StreamingCoders-UI'.
		'GToolkit-Coder-UI'.
		'GToolkit-Completer'.
		'GToolkit-Pharo-Coder-Method'.
		'GToolkit-Pharo-Completer'.
		'GToolkit-Pharo-Parser'.
		'GToolkit-Pharo-SearchFilters'.
		'GToolkit-Phlow'.
		'GToolkit-VariableBindings'.
		'Kernel'.
		'TraitsV2'
	}
]

{ #category : #accessing }
ManifestGToolkitPharoCoderMethodUI class >> shouldDependOn [
	^ {
		'GToolkit-Coder'.
		'GToolkit-Coder-StreamingCoders-UI'.
		'GToolkit-Coder-UI'.
		'GToolkit-Completer'.
		'GToolkit-Pharo-Coder-Method'.
		'GToolkit-Pharo-Completer'.
		'GToolkit-Pharo-Parser'.
		'GToolkit-Pharo-SearchFilters'.
		'GToolkit-VariableBindings'.
	}
]
