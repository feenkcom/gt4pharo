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
		'Kernel'.
		'SmaCC_Runtime'.
	}, (self  
		forPharo12AndNewer: [{
			'Kernel-CodeModel'.}] 
		forPharo11: [{
			'Collections-Abstract'.}])
]

{ #category : #accessing }
ManifestGToolkitPharoCompleter class >> shouldDependOn [
	^ {
		'GToolkit-Completer'.
		'GToolkit-Pharo-Index'.
		'GToolkit-Pharo-Parser'.
		'SmaCC_Runtime'.
	}
]
