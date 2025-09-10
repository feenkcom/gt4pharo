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
	"Do not bring these dependencies back!"

	^ { 
		'GToolkit-Pharo-Coder'.
		'GToolkit-Pharo-Coder-AddOns'.
		'GToolkit-Pharo-Coder-UI'.
		'GToolkit-Pharo-Completer'.
		'GToolkit-Utility-Announcer'
	}
]

{ #category : #accessing }
ManifestGToolkitPharoSearchFilters class >> mustOnlyDependOn [
	^ {
		'AST-Core'.
		'Announcements-Core'.
		'Collections-Sequenceable'.
		'Collections-Strings'.
		'Collections-Unordered'.
		'Futures'.
		'Futures-Extra'.
		'GToolkit-Pharo-Index'.
		'GToolkit-Pharo-System'.
		'GToolkit-SearchFilters'.
		'GToolkit-Utility-Basic'.
		'Kernel'.
	}, (self  
		forPharo12AndNewer: [{
			'Kernel-CodeModel'.}] 
		forPharo11: [{}])
]

{ #category : #accessing }
ManifestGToolkitPharoSearchFilters class >> shouldDependOn [
	^ { 
		'GToolkit-SearchFilters'.
	}
]
