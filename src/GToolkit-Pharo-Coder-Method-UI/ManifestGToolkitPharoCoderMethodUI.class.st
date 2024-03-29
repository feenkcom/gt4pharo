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
ManifestGToolkitPharoCoderMethodUI class >> shouldDependOn [
	^ {
		'GToolkit-Coder'.
		'GToolkit-Coder-StreamingCoders-UI'.
		'GToolkit-Coder-UI'.
		"'GToolkit-Completer'."
		'GToolkit-Pharo-Coder-Method'.
		'GToolkit-Pharo-Completer'.
		'GToolkit-Pharo-Parser'.
		'GToolkit-Pharo-SearchFilters'.
		'GToolkit-VariableBindings'.
	}
]

{ #category : #testing }
ManifestGToolkitPharoCoderMethodUI class >> shouldValidateBaseline [
	^ true
]
