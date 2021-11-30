"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestGToolkitPharoTestSuite,
	#superclass : #PackageManifest,
	#category : #'GToolkit-Pharo-TestSuite-Manifest'
}

{ #category : #accessing }
ManifestGToolkitPharoTestSuite class >> mustOnlyDependOn [
	^ {
		'Announcements-Core'.
		'Collections-Sequenceable'.
		'Collections-Unordered'.
		'Futures'.
		'GToolkit-Pharo-Coder'.
		'Kernel'.
		'SUnit-Core'
	}
]
