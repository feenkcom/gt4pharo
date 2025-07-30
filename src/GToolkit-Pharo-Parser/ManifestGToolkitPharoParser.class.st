"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestGToolkitPharoParser,
	#superclass : #PackageManifest,
	#category : #'GToolkit-Pharo-Parser-Manifest'
}

{ #category : #accessing }
ManifestGToolkitPharoParser class >> mustOnlyDependOn [
	^ {
		'Collections-Native'.
		'Collections-Sequenceable'.
		'Collections-Strings'.
		'Collections-Unordered'.
		'Kernel'.
		'SmaCC_GLR_Runtime'.
		'SmaCC_Runtime'
	}, (self  
		forPharo12: [{
			'Kernel-CodeModel'.}] 
		forPharo11AndPharo10: [{}])
]

{ #category : #accessing }
ManifestGToolkitPharoParser class >> shouldDependOn [
	^ { 
		'SmaCC_GLR_Runtime'.
		'SmaCC_Runtime'
	}
]
