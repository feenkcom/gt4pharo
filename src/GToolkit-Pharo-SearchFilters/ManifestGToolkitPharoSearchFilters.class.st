"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestGToolkitPharoSearchFilters,
	#superclass : #PackageManifest,
	#category : #'GToolkit-Pharo-SearchFilters-Manifest'
}

{ #category : #accessing }
ManifestGToolkitPharoSearchFilters class >> mustNotDependOn [
	^ { 
		'GToolkit-Pharo-Coder'.
		'GToolkit-Pharo-Coder-AddOns'.
		'GToolkit-Pharo-Coder-UI'.
	}
]

{ #category : #accessing }
ManifestGToolkitPharoSearchFilters class >> mustOnlyDependOn [
	^ {
		'AST-Core'.
		'Collections-Sequenceable'.
		'Collections-Unordered'.
		'Futures-Extra'.
		'GToolkit-Pharo-System'.
		'GToolkit-SearchFilters'.
		'Kernel'.
		'RPackage-Core'
	}
]

{ #category : #accessing }
ManifestGToolkitPharoSearchFilters class >> shouldDependOn [
	^ { 
		'GToolkit-SearchFilters'.
	}
]
