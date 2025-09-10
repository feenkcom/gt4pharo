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
	"Test suit extends 'GToolkit-Examples' to be able to differentiate between gt examples an test cases"

	^ {
		'Announcements-Core'.
		'Brick-Glamorous'.
		'Collections-Sequenceable'.
		'Collections-Unordered'.
		'Futures'.
		'GToolkit-Pharo-SearchFilters'.
		'GToolkit-Utility-StackOverflow'.
		'Kernel'.
		'SUnit-Core'.
		'Ring-Core'
	}, (self  
		forPharo12AndNewer: [{
			'Kernel-CodeModel'.}] 
		forPharo11: [{}])
]

{ #category : #accessing }
ManifestGToolkitPharoTestSuite class >> shouldDependOn [
	^ {
		'Futures'.
		'GToolkit-Pharo-SearchFilters'.
		'GToolkit-Utility-StackOverflow'.
		'SUnit-Core'
	}
]
