"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestGToolkitPharoCompleter,
	#superclass : #PackageManifest,
	#category : #'GToolkit-Pharo-Completer-Manifest'
}

{ #category : #accessing }
ManifestGToolkitPharoCompleter class >> mustOnlyDependOn [
	^ {
		'Collections-Sequenceable'.
		'Collections-Strings'.
		'Collections-Unordered'.
		'GToolkit-Completer'.
		'GToolkit-Pharo-Index'.
		'GToolkit-Pharo-Parser'.
		'GToolkit-Pharo-System'.
		'Kernel'.
		'SmaCC_Runtime'.
	}
]

{ #category : #accessing }
ManifestGToolkitPharoCompleter class >> shouldDependOn [
	^ {
		'GToolkit-Completer'.
		'GToolkit-Pharo-Index'.
		'GToolkit-Pharo-Parser'.
		'GToolkit-Pharo-System'.
		'SmaCC_Runtime'.
	}
]
